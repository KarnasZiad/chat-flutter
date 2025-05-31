import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/conversation_bloc.dart';
import '../bloc/conversation_event.dart';
import '../bloc/conversation_state.dart';
import '../widgets/conversation_tile.dart';
import 'chat_detail_screen.dart';

class ConversationListScreen extends StatelessWidget {
  const ConversationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateConversationDialog(context),
          ),
        ],
      ),
      body: BlocBuilder<ConversationBloc, ConversationState>(
        builder: (context, state) {
          if (state is ConversationInitial || state is ConversationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ConversationError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Erreur: ${state.message}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ConversationBloc>().add(const LoadConversations());
                    },
                    child: const Text('Réessayer'),
                  ),
                ],
              ),
            );
          }

          if (state is ConversationLoaded) {
            if (state.conversations.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Aucune conversation',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Commencez une nouvelle conversation',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => _showCreateConversationDialog(context),
                      icon: const Icon(Icons.add),
                      label: const Text('Nouvelle conversation'),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<ConversationBloc>().add(const LoadConversations());
              },
              child: ListView.separated(
                itemCount: state.conversations.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: Colors.grey[200],
                ),
                itemBuilder: (context, index) {
                  final conversation = state.conversations[index];
                  return ConversationTile(
                    conversation: conversation,
                    onTap: () {
                      context.read<ConversationBloc>().add(
                        SelectConversation(conversationId: conversation.id),
                      );
                      
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChatDetailScreen(
                            conversation: conversation,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showCreateConversationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Nouvelle conversation'),
        content: const Text('Choisissez un contact pour commencer une conversation :'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _showContactSelectionDialog(context);
            },
            child: const Text('Choisir un contact'),
          ),
        ],
      ),
    );
  }

  void _showContactSelectionDialog(BuildContext context) {
    // Simuler des contacts disponibles basés sur MockData
    final availableContacts = [
      {'name': 'Félix Moreau', 'avatar': '👨‍🎨'},
      {'name': 'Gabrielle Simon', 'avatar': '👩‍⚕️'},
      {'name': 'Hugo Laurent', 'avatar': '👨‍💼'},
      {'name': 'Isabelle Petit', 'avatar': '👩‍🔬'},
      {'name': 'Julien Roux', 'avatar': '👨‍🏫'},
      {'name': 'Léa Blanc', 'avatar': '👩‍💻'},
    ];

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Sélectionner un contact'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: availableContacts.length,
            itemBuilder: (context, index) {
              final contact = availableContacts[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(
                    contact['avatar']!,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                title: Text(contact['name']!),
                onTap: () {
                  context.read<ConversationBloc>().add(
                    CreateConversation(
                      contactName: contact['name']!,
                      contactAvatar: contact['avatar']!,
                    ),
                  );
                  Navigator.of(dialogContext).pop();
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Annuler'),
          ),
        ],
      ),
    );
  }
}
