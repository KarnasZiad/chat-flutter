import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/conversation.dart';
import '../models/message.dart';
import '../services/chat_service.dart';
import 'conversation_event.dart';
import 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final ChatService _chatService;

  ConversationBloc({required ChatService chatService})
      : _chatService = chatService,
        super(const ConversationInitial()) {
    on<LoadConversations>(_onLoadConversations);
    on<SendMessage>(_onSendMessage);
    on<ReceiveMessage>(_onReceiveMessage);
    on<CreateConversation>(_onCreateConversation);
    on<SelectConversation>(_onSelectConversation);
    on<MarkMessagesAsRead>(_onMarkMessagesAsRead);
  }

  Future<void> _onLoadConversations(
    LoadConversations event,
    Emitter<ConversationState> emit,
  ) async {
    emit(const ConversationLoading());
    try {
      final conversations = await _chatService.getConversations();
      emit(ConversationLoaded(conversations: conversations));
    } catch (e) {
      emit(ConversationError(message: e.toString()));
    }
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ConversationState> emit,
  ) async {
    final currentState = state;
    if (currentState is ConversationLoaded) {
      emit(MessageSending(
        conversations: currentState.conversations,
        selectedConversation: currentState.selectedConversation,
      ));

      try {
        final message = await _chatService.sendMessage(
          conversationId: event.conversationId,
          content: event.content,
        );

        final updatedConversations = _updateConversationWithMessage(
          currentState.conversations,
          event.conversationId,
          message,
        );

        final updatedSelectedConversation = updatedConversations
            .firstWhere((conv) => conv.id == event.conversationId);

        emit(ConversationLoaded(
          conversations: updatedConversations,
          selectedConversation: updatedSelectedConversation,
        ));
      } catch (e) {
        emit(ConversationError(message: e.toString()));
      }
    }
  }

  Future<void> _onReceiveMessage(
    ReceiveMessage event,
    Emitter<ConversationState> emit,
  ) async {
    final currentState = state;
    if (currentState is ConversationLoaded) {
      try {
        final message = await _chatService.receiveMessage(
          conversationId: event.conversationId,
          content: event.content,
          senderId: event.senderId,
        );

        final updatedConversations = _updateConversationWithMessage(
          currentState.conversations,
          event.conversationId,
          message,
        );

        final updatedSelectedConversation = currentState.selectedConversation?.id == event.conversationId
            ? updatedConversations.firstWhere((conv) => conv.id == event.conversationId)
            : currentState.selectedConversation;

        emit(ConversationLoaded(
          conversations: updatedConversations,
          selectedConversation: updatedSelectedConversation,
        ));
      } catch (e) {
        emit(ConversationError(message: e.toString()));
      }
    }
  }

  Future<void> _onCreateConversation(
    CreateConversation event,
    Emitter<ConversationState> emit,
  ) async {
    final currentState = state;
    if (currentState is ConversationLoaded) {
      try {
        final newConversation = await _chatService.createConversation(
          contactName: event.contactName,
          contactAvatar: event.contactAvatar,
        );

        final updatedConversations = [newConversation, ...currentState.conversations];

        emit(ConversationLoaded(
          conversations: updatedConversations,
          selectedConversation: currentState.selectedConversation,
        ));
      } catch (e) {
        emit(ConversationError(message: e.toString()));
      }
    }
  }

  Future<void> _onSelectConversation(
    SelectConversation event,
    Emitter<ConversationState> emit,
  ) async {
    final currentState = state;
    if (currentState is ConversationLoaded) {
      final selectedConversation = currentState.conversations
          .firstWhere((conv) => conv.id == event.conversationId);

      emit(ConversationLoaded(
        conversations: currentState.conversations,
        selectedConversation: selectedConversation,
      ));
    }
  }

  Future<void> _onMarkMessagesAsRead(
    MarkMessagesAsRead event,
    Emitter<ConversationState> emit,
  ) async {
    final currentState = state;
    if (currentState is ConversationLoaded) {
      final updatedConversations = currentState.conversations.map((conversation) {
        if (conversation.id == event.conversationId) {
          return conversation.copyWith(unreadCount: 0);
        }
        return conversation;
      }).toList();

      emit(ConversationLoaded(
        conversations: updatedConversations,
        selectedConversation: currentState.selectedConversation,
      ));
    }
  }

  List<Conversation> _updateConversationWithMessage(
    List<Conversation> conversations,
    String conversationId,
    Message message,
  ) {
    return conversations.map((conversation) {
      if (conversation.id == conversationId) {
        final updatedMessages = [...conversation.messages, message];
        return conversation.copyWith(
          messages: updatedMessages,
          lastMessage: message.content,
          timestamp: message.timestamp,
          unreadCount: message.isFromCurrentUser ? conversation.unreadCount : conversation.unreadCount + 1,
        );
      }
      return conversation;
    }).toList();
  }
}
