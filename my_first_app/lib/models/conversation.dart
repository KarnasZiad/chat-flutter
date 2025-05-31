import 'package:equatable/equatable.dart';
import 'message.dart';

class Conversation extends Equatable {
  final String id;
  final String contactName;
  final String contactAvatar;
  final String lastMessage;
  final DateTime timestamp;
  final int unreadCount;
  final List<Message> messages;

  const Conversation({
    required this.id,
    required this.contactName,
    required this.contactAvatar,
    required this.lastMessage,
    required this.timestamp,
    this.unreadCount = 0,
    this.messages = const [],
  });

  @override
  List<Object> get props => [
        id,
        contactName,
        contactAvatar,
        lastMessage,
        timestamp,
        unreadCount,
        messages,
      ];

  Conversation copyWith({
    String? id,
    String? contactName,
    String? contactAvatar,
    String? lastMessage,
    DateTime? timestamp,
    int? unreadCount,
    List<Message>? messages,
  }) {
    return Conversation(
      id: id ?? this.id,
      contactName: contactName ?? this.contactName,
      contactAvatar: contactAvatar ?? this.contactAvatar,
      lastMessage: lastMessage ?? this.lastMessage,
      timestamp: timestamp ?? this.timestamp,
      unreadCount: unreadCount ?? this.unreadCount,
      messages: messages ?? this.messages,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contactName': contactName,
      'contactAvatar': contactAvatar,
      'lastMessage': lastMessage,
      'timestamp': timestamp.toIso8601String(),
      'unreadCount': unreadCount,
      'messages': messages.map((message) => message.toJson()).toList(),
    };
  }

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'] as String,
      contactName: json['contactName'] as String,
      contactAvatar: json['contactAvatar'] as String,
      lastMessage: json['lastMessage'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      unreadCount: json['unreadCount'] as int? ?? 0,
      messages: (json['messages'] as List<dynamic>?)
              ?.map((messageJson) => Message.fromJson(messageJson as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
