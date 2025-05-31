import 'package:equatable/equatable.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object> get props => [];
}

class LoadConversations extends ConversationEvent {
  const LoadConversations();
}

class SendMessage extends ConversationEvent {
  final String conversationId;
  final String content;

  const SendMessage({
    required this.conversationId,
    required this.content,
  });

  @override
  List<Object> get props => [conversationId, content];
}

class ReceiveMessage extends ConversationEvent {
  final String conversationId;
  final String content;
  final String senderId;

  const ReceiveMessage({
    required this.conversationId,
    required this.content,
    required this.senderId,
  });

  @override
  List<Object> get props => [conversationId, content, senderId];
}

class CreateConversation extends ConversationEvent {
  final String contactName;
  final String contactAvatar;

  const CreateConversation({
    required this.contactName,
    required this.contactAvatar,
  });

  @override
  List<Object> get props => [contactName, contactAvatar];
}

class SelectConversation extends ConversationEvent {
  final String conversationId;

  const SelectConversation({
    required this.conversationId,
  });

  @override
  List<Object> get props => [conversationId];
}

class MarkMessagesAsRead extends ConversationEvent {
  final String conversationId;

  const MarkMessagesAsRead({
    required this.conversationId,
  });

  @override
  List<Object> get props => [conversationId];
}
