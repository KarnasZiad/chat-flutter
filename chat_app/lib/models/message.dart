import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final String content;
  final String senderId;
  final DateTime timestamp;
  final bool isRead;
  final bool isFromCurrentUser;

  const Message({
    required this.id,
    required this.content,
    required this.senderId,
    required this.timestamp,
    this.isRead = false,
    this.isFromCurrentUser = false,
  });

  @override
  List<Object> get props => [
        id,
        content,
        senderId,
        timestamp,
        isRead,
        isFromCurrentUser,
      ];

  Message copyWith({
    String? id,
    String? content,
    String? senderId,
    DateTime? timestamp,
    bool? isRead,
    bool? isFromCurrentUser,
  }) {
    return Message(
      id: id ?? this.id,
      content: content ?? this.content,
      senderId: senderId ?? this.senderId,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      isFromCurrentUser: isFromCurrentUser ?? this.isFromCurrentUser,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'senderId': senderId,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'isFromCurrentUser': isFromCurrentUser,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String,
      content: json['content'] as String,
      senderId: json['senderId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isRead: json['isRead'] as bool? ?? false,
      isFromCurrentUser: json['isFromCurrentUser'] as bool? ?? false,
    );
  }
}
