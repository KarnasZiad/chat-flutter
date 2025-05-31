import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/conversation.dart';

class ConversationTile extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback onTap;

  const ConversationTile({
    super.key,
    required this.conversation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            child: Text(
              conversation.contactAvatar,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          if (conversation.unreadCount > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(
                  minWidth: 20,
                  minHeight: 20,
                ),
                child: Text(
                  conversation.unreadCount > 99 ? '99+' : conversation.unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
      title: Text(
        conversation.contactName,
        style: TextStyle(
          fontWeight: conversation.unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        conversation.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: conversation.unreadCount > 0 
              ? Theme.of(context).textTheme.bodyMedium?.color
              : Theme.of(context).textTheme.bodySmall?.color,
          fontWeight: conversation.unreadCount > 0 ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            _formatTimestamp(conversation.timestamp),
            style: TextStyle(
              fontSize: 12,
              color: conversation.unreadCount > 0 
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.bodySmall?.color,
              fontWeight: conversation.unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (conversation.unreadCount > 0)
            const SizedBox(height: 4),
        ],
      ),
      onTap: onTap,
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays == 0) {
      // Aujourd'hui - afficher l'heure
      return DateFormat('HH:mm').format(timestamp);
    } else if (difference.inDays == 1) {
      // Hier
      return 'Hier';
    } else if (difference.inDays < 7) {
      // Cette semaine - afficher le jour
      return DateFormat('EEEE', 'fr_FR').format(timestamp);
    } else {
      // Plus ancien - afficher la date
      return DateFormat('dd/MM/yy').format(timestamp);
    }
  }
}
