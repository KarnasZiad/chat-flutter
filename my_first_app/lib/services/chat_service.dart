import 'dart:async';
import 'dart:math';
import '../models/conversation.dart';
import '../models/message.dart';
import '../models/user.dart';
import '../data/mock_data.dart';
import 'chatbot_service.dart';

class ChatService {
  static const String _currentUserId = 'current_user';

  // Utilisation des données mock réalistes
  late final List<Conversation> _conversations;

  // Instance du chatbot intelligent
  final ChatbotService _chatbot = ChatbotService();

  // Flag d'initialisation
  bool _isInitialized = false;

  ChatService() {
    _initializeData();
  }

  void _initializeData() {
    try {
      // Créer directement les données pour éviter les problèmes d'initialisation
      _conversations = _createSimpleData();
      _isInitialized = true;
    } catch (e) {
      // Fallback avec données de base si tout échoue
      _conversations = _createFallbackData();
      _isInitialized = true;
    }
  }

  List<Conversation> _createSimpleData() {
    final now = DateTime.now();
    return [
      Conversation(
        id: 'conv_chatbot',
        contactName: 'Assistant IA',
        contactAvatar: '🤖',
        lastMessage: 'Salut ! Je suis ton assistant IA. Comment puis-je t\'aider ?',
        timestamp: now.subtract(const Duration(minutes: 1)),
        unreadCount: 1,
        messages: [
          Message(
            id: 'msg_chatbot_welcome',
            content: 'Salut ! Je suis ton assistant IA. Comment puis-je t\'aider ?',
            senderId: 'chatbot',
            timestamp: now.subtract(const Duration(minutes: 1)),
            isFromCurrentUser: false,
          ),
        ],
      ),
      Conversation(
        id: 'conv_alice',
        contactName: 'Alice Martin',
        contactAvatar: '👩‍💼',
        lastMessage: 'Parfait ! À tout à l\'heure 👋',
        timestamp: now.subtract(const Duration(minutes: 5)),
        unreadCount: 2,
        messages: [
          Message(
            id: 'msg_alice_1',
            content: 'Salut ! Comment ça va ?',
            senderId: 'alice_martin',
            timestamp: now.subtract(const Duration(minutes: 10)),
            isFromCurrentUser: false,
          ),
          Message(
            id: 'msg_alice_2',
            content: 'Parfait ! À tout à l\'heure 👋',
            senderId: 'alice_martin',
            timestamp: now.subtract(const Duration(minutes: 5)),
            isFromCurrentUser: false,
          ),
        ],
      ),
      Conversation(
        id: 'conv_bob',
        contactName: 'Bob Dupont',
        contactAvatar: '👨‍💻',
        lastMessage: 'De rien ! On en discute demain ?',
        timestamp: now.subtract(const Duration(hours: 3)),
        unreadCount: 1,
        messages: [
          Message(
            id: 'msg_bob_1',
            content: 'Hey ! Tu as vu le nouveau framework ?',
            senderId: 'bob_dupont',
            timestamp: now.subtract(const Duration(hours: 4)),
            isFromCurrentUser: false,
          ),
          Message(
            id: 'msg_bob_2',
            content: 'De rien ! On en discute demain ?',
            senderId: 'bob_dupont',
            timestamp: now.subtract(const Duration(hours: 3)),
            isFromCurrentUser: false,
          ),
        ],
      ),
    ];
  }

  List<Conversation> _createFallbackData() {
    return [
      Conversation(
        id: 'conv_chatbot',
        contactName: 'Assistant IA',
        contactAvatar: '🤖',
        lastMessage: 'Salut ! Je suis ton assistant IA. Comment puis-je t\'aider ?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
        unreadCount: 1,
        messages: [
          Message(
            id: 'msg_chatbot_welcome',
            content: 'Salut ! Je suis ton assistant IA. Comment puis-je t\'aider ?',
            senderId: 'chatbot',
            timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
            isFromCurrentUser: false,
          ),
        ],
      ),
      Conversation(
        id: 'conv_demo',
        contactName: 'Contact Demo',
        contactAvatar: '👤',
        lastMessage: 'Bienvenue dans l\'application de chat !',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        unreadCount: 0,
        messages: [
          Message(
            id: 'msg_demo',
            content: 'Bienvenue dans l\'application de chat !',
            senderId: 'demo',
            timestamp: DateTime.now().subtract(const Duration(hours: 1)),
            isFromCurrentUser: false,
          ),
        ],
      ),
    ];
  }

  Future<List<Conversation>> getConversations() async {
    // Vérifier l'initialisation
    if (!_isInitialized) {
      _initializeData();
    }

    // Simulation d'un délai réseau
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_conversations);
  }

  Future<Message> sendMessage({
    required String conversationId,
    required String content,
  }) async {
    // Simulation d'un délai réseau
    await Future.delayed(const Duration(milliseconds: 300));

    final message = Message(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      content: content,
      senderId: _currentUserId,
      timestamp: DateTime.now(),
      isFromCurrentUser: true,
    );

    // Mettre à jour la conversation locale
    final conversationIndex = _conversations.indexWhere((conv) => conv.id == conversationId);
    if (conversationIndex != -1) {
      final conversation = _conversations[conversationIndex];
      final updatedMessages = [...conversation.messages, message];
      _conversations[conversationIndex] = conversation.copyWith(
        messages: updatedMessages,
        lastMessage: content,
        timestamp: DateTime.now(),
      );
    }

    // Simuler une réponse automatique après quelques secondes
    _simulateAutoReply(conversationId, content);

    return message;
  }

  Future<Message> receiveMessage({
    required String conversationId,
    required String content,
    required String senderId,
  }) async {
    final message = Message(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      content: content,
      senderId: senderId,
      timestamp: DateTime.now(),
      isFromCurrentUser: false,
    );

    // Mettre à jour la conversation locale
    final conversationIndex = _conversations.indexWhere((conv) => conv.id == conversationId);
    if (conversationIndex != -1) {
      final conversation = _conversations[conversationIndex];
      final updatedMessages = [...conversation.messages, message];
      _conversations[conversationIndex] = conversation.copyWith(
        messages: updatedMessages,
        lastMessage: content,
        timestamp: DateTime.now(),
        unreadCount: conversation.unreadCount + 1,
      );
    }

    return message;
  }

  Future<Conversation> createConversation({
    required String contactName,
    required String contactAvatar,
  }) async {
    // Simulation d'un délai réseau
    await Future.delayed(const Duration(milliseconds: 500));

    final newConversation = Conversation(
      id: 'conv_${DateTime.now().millisecondsSinceEpoch}',
      contactName: contactName,
      contactAvatar: contactAvatar,
      lastMessage: 'Nouvelle conversation',
      timestamp: DateTime.now(),
      unreadCount: 0,
      messages: [],
    );

    _conversations.insert(0, newConversation);
    return newConversation;
  }

  void _simulateAutoReply(String conversationId, String userMessage) {
    Future.delayed(const Duration(seconds: 2), () {
      // Utiliser le chatbot intelligent pour générer une réponse contextuelle
      final intelligentResponse = _chatbot.generateResponse(userMessage, conversationId);

      receiveMessage(
        conversationId: conversationId,
        content: intelligentResponse,
        senderId: 'chatbot',
      );
    });
  }

  // Simuler des messages entrants aléatoires pour rendre l'app plus vivante
  void simulateIncomingMessages() {
    Timer.periodic(const Duration(minutes: 2), (timer) {
      if (_conversations.isNotEmpty && Random().nextBool()) {
        final randomConversation = _conversations[Random().nextInt(_conversations.length)];
        final randomMessage = MockData.starterMessages[Random().nextInt(MockData.starterMessages.length)];

        receiveMessage(
          conversationId: randomConversation.id,
          content: randomMessage,
          senderId: '${randomConversation.id.replaceAll('conv_', '')}_id',
        );
      }
    });
  }

  // Obtenir un utilisateur par son ID
  User? getUserById(String userId) {
    try {
      return MockData.mockUsers.firstWhere((user) => user.id == userId);
    } catch (e) {
      return null;
    }
  }

  // Obtenir tous les utilisateurs disponibles pour créer de nouvelles conversations
  List<User> getAvailableUsers() {
    final existingContactIds = _conversations
        .map((conv) => conv.id.replaceAll('conv_', ''))
        .toList();

    return MockData.mockUsers
        .where((user) => !existingContactIds.contains(user.id.replaceAll('_', '')))
        .toList();
  }
}
