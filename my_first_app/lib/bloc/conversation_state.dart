import 'package:equatable/equatable.dart';
import '../models/conversation.dart';

abstract class ConversationState extends Equatable {
  const ConversationState();

  @override
  List<Object?> get props => [];
}

class ConversationInitial extends ConversationState {
  const ConversationInitial();
}

class ConversationLoading extends ConversationState {
  const ConversationLoading();
}

class ConversationLoaded extends ConversationState {
  final List<Conversation> conversations;
  final Conversation? selectedConversation;

  const ConversationLoaded({
    required this.conversations,
    this.selectedConversation,
  });

  @override
  List<Object?> get props => [conversations, selectedConversation];

  ConversationLoaded copyWith({
    List<Conversation>? conversations,
    Conversation? selectedConversation,
  }) {
    return ConversationLoaded(
      conversations: conversations ?? this.conversations,
      selectedConversation: selectedConversation ?? this.selectedConversation,
    );
  }
}

class ConversationError extends ConversationState {
  final String message;

  const ConversationError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class MessageSending extends ConversationState {
  final List<Conversation> conversations;
  final Conversation? selectedConversation;

  const MessageSending({
    required this.conversations,
    this.selectedConversation,
  });

  @override
  List<Object?> get props => [conversations, selectedConversation];
}

class MessageSent extends ConversationState {
  final List<Conversation> conversations;
  final Conversation? selectedConversation;

  const MessageSent({
    required this.conversations,
    this.selectedConversation,
  });

  @override
  List<Object?> get props => [conversations, selectedConversation];
}
