import '../models/conversation.dart';
import '../models/message.dart';
import '../models/user.dart';

class MockData {
  static const String currentUserId = 'current_user';

  // Utilisateurs mock
  static final List<User> mockUsers = [
    const User(
      id: 'alice_martin',
      name: 'Alice Martin',
      avatar: '👩‍💼',
    ),
    const User(
      id: 'bob_dupont',
      name: 'Bob Dupont',
      avatar: '👨‍💻',
    ),
    const User(
      id: 'claire_rousseau',
      name: 'Claire Rousseau',
      avatar: '👩‍🎨',
    ),
    const User(
      id: 'david_bernard',
      name: 'David Bernard',
      avatar: '👨‍🔬',
    ),
    const User(
      id: 'emma_dubois',
      name: 'Emma Dubois',
      avatar: '👩‍🏫',
    ),
    const User(
      id: 'felix_moreau',
      name: 'Félix Moreau',
      avatar: '👨‍🎨',
    ),
    const User(
      id: 'gabrielle_simon',
      name: 'Gabrielle Simon',
      avatar: '👩‍⚕️',
    ),
    const User(
      id: 'hugo_laurent',
      name: 'Hugo Laurent',
      avatar: '👨‍💼',
    ),
  ];

  // Messages mock pour différentes conversations
  static final Map<String, List<Message>> mockMessages = {
    'conv_alice': [
      Message(
        id: 'msg_alice_1',
        content: 'Salut ! Comment ça va ?',
        senderId: 'alice_martin',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isFromCurrentUser: false,
      ),
      Message(
        id: 'msg_alice_2',
        content: 'Ça va bien merci ! Et toi ?',
        senderId: currentUserId,
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 55)),
        isFromCurrentUser: true,
      ),
      Message(
        id: 'msg_alice_3',
        content: 'Super ! Tu es libre ce soir pour le projet ?',
        senderId: 'alice_martin',
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 50)),
        isFromCurrentUser: false,
      ),
      Message(
        id: 'msg_alice_4',
        content: 'Oui bien sûr ! À quelle heure ?',
        senderId: currentUserId,
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
        isFromCurrentUser: true,
      ),
      Message(
        id: 'msg_alice_5',
        content: 'Vers 19h ça te va ?',
        senderId: 'alice_martin',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        isFromCurrentUser: false,
      ),
      Message(
        id: 'msg_alice_6',
        content: 'Parfait ! À tout à l\'heure 👋',
        senderId: 'alice_martin',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        isFromCurrentUser: false,
      ),
    ],
    'conv_bob': [
      Message(
        id: 'msg_bob_1',
        content: 'Hey ! Tu as vu le nouveau framework ?',
        senderId: 'bob_dupont',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
        isFromCurrentUser: false,
      ),
      Message(
        id: 'msg_bob_2',
        content: 'Lequel ? Flutter ?',
        senderId: currentUserId,
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2, minutes: 55)),
        isFromCurrentUser: true,
      ),
      Message(
        id: 'msg_bob_3',
        content: 'Non, le nouveau React Native 0.75 !',
        senderId: 'bob_dupont',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2, minutes: 50)),
        isFromCurrentUser: false,
      ),
      Message(
        id: 'msg_bob_4',
        content: 'Ah intéressant ! Quoi de nouveau ?',
        senderId: currentUserId,
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2, minutes: 45)),
        isFromCurrentUser: true,
      ),
      Message(
        id: 'msg_bob_5',
        content: 'Beaucoup d\'améliorations de performance et une nouvelle architecture',
        senderId: 'bob_dupont',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2, minutes: 40)),
        isFromCurrentUser: false,
      ),
      Message(
        id: 'msg_bob_6',
        content: 'Je vais regarder ça ! Merci pour l\'info 🚀',
        senderId: currentUserId,
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2, minutes: 35)),
        isFromCurrentUser: true,
      ),
      Message(
        id: 'msg_bob_7',
        content: 'De rien ! On en discute demain ?',
        senderId: 'bob_dupont',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        isFromCurrentUser: false,
      ),
    ],
    'conv_claire': [
      Message(
        id: 'msg_claire_1',
        content: 'J\'ai terminé les maquettes pour le projet !',
        senderId: 'claire_rousseau',
        timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 4)),
        isFromCurrentUser: false,
      ),
      Message(
        id: 'msg_claire_2',
        content: 'Génial ! Tu peux me les envoyer ?',
        senderId: currentUserId,
        timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 3, minutes: 55)),
        isFromCurrentUser: true,
      ),
      Message(
        id: 'msg_claire_3',
        content: 'Bien sûr ! Je te les envoie par email',
        senderId: 'claire_rousseau',
        timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 3, minutes: 50)),
        isFromCurrentUser: false,
      ),
      Message(
        id: 'msg_claire_4',
        content: 'Super ! Hâte de voir ça 🎨',
        senderId: currentUserId,
        timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 3, minutes: 45)),
        isFromCurrentUser: true,
      ),
      Message(
        id: 'msg_claire_5',
        content: 'C\'est envoyé ! Dis-moi ce que tu en penses',
        senderId: 'claire_rousseau',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 5)),
        isFromCurrentUser: false,
      ),
    ],
    'conv_david': [
      Message(
        id: 'msg_david_1',
        content: 'Tu as des nouvelles du laboratoire ?',
        senderId: currentUserId,
        timestamp: DateTime.now().subtract(const Duration(days: 3, hours: 2)),
        isFromCurrentUser: true,
      ),
      Message(
        id: 'msg_david_2',
        content: 'Oui ! Les résultats sont très prometteurs',
        senderId: 'david_bernard',
        timestamp: DateTime.now().subtract(const Duration(days: 3, hours: 1, minutes: 55)),
        isFromCurrentUser: false,
      ),
      Message(
        id: 'msg_david_3',
        content: 'Excellent ! On peut en discuter demain ?',
        senderId: currentUserId,
        timestamp: DateTime.now().subtract(const Duration(days: 3, hours: 1, minutes: 50)),
        isFromCurrentUser: true,
      ),
      Message(
        id: 'msg_david_4',
        content: 'Absolument ! RDV à 14h en salle de réunion',
        senderId: 'david_bernard',
        timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 8)),
        isFromCurrentUser: false,
      ),
    ],
    'conv_emma': [
      Message(
        id: 'msg_emma_1',
        content: 'Les étudiants ont adoré le cours sur Flutter !',
        senderId: 'emma_dubois',
        timestamp: DateTime.now().subtract(const Duration(days: 4, hours: 6)),
        isFromCurrentUser: false,
      ),
      Message(
        id: 'msg_emma_2',
        content: 'C\'est fantastique ! Ils ont des questions ?',
        senderId: currentUserId,
        timestamp: DateTime.now().subtract(const Duration(days: 4, hours: 5, minutes: 55)),
        isFromCurrentUser: true,
      ),
      Message(
        id: 'msg_emma_3',
        content: 'Beaucoup ! Surtout sur la gestion d\'état avec BLoC',
        senderId: 'emma_dubois',
        timestamp: DateTime.now().subtract(const Duration(days: 4, hours: 5, minutes: 50)),
        isFromCurrentUser: false,
      ),
      Message(
        id: 'msg_emma_4',
        content: 'Je peux faire une session Q&A la semaine prochaine si tu veux',
        senderId: currentUserId,
        timestamp: DateTime.now().subtract(const Duration(days: 4, hours: 5, minutes: 45)),
        isFromCurrentUser: true,
      ),
      Message(
        id: 'msg_emma_5',
        content: 'Ce serait parfait ! Merci beaucoup 🙏',
        senderId: 'emma_dubois',
        timestamp: DateTime.now().subtract(const Duration(days: 3, hours: 10)),
        isFromCurrentUser: false,
      ),
    ],
  };

  // Conversations mock
  static final List<Conversation> mockConversations = [
    // Conversation avec le chatbot intelligent
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
      id: 'conv_alice',
      contactName: 'Alice Martin',
      contactAvatar: '👩‍💼',
      lastMessage: 'Parfait ! À tout à l\'heure 👋',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      unreadCount: 2,
      messages: mockMessages['conv_alice']!,
    ),
    Conversation(
      id: 'conv_bob',
      contactName: 'Bob Dupont',
      contactAvatar: '👨‍💻',
      lastMessage: 'De rien ! On en discute demain ?',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      unreadCount: 1,
      messages: mockMessages['conv_bob']!,
    ),
    Conversation(
      id: 'conv_claire',
      contactName: 'Claire Rousseau',
      contactAvatar: '👩‍🎨',
      lastMessage: 'C\'est envoyé ! Dis-moi ce que tu en penses',
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 5)),
      unreadCount: 1,
      messages: mockMessages['conv_claire']!,
    ),
    Conversation(
      id: 'conv_david',
      contactName: 'David Bernard',
      contactAvatar: '👨‍🔬',
      lastMessage: 'Absolument ! RDV à 14h en salle de réunion',
      timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 8)),
      unreadCount: 0,
      messages: mockMessages['conv_david']!,
    ),
    Conversation(
      id: 'conv_emma',
      contactName: 'Emma Dubois',
      contactAvatar: '👩‍🏫',
      lastMessage: 'Ce serait parfait ! Merci beaucoup 🙏',
      timestamp: DateTime.now().subtract(const Duration(days: 3, hours: 10)),
      unreadCount: 0,
      messages: mockMessages['conv_emma']!,
    ),
    Conversation(
      id: 'conv_felix',
      contactName: 'Félix Moreau',
      contactAvatar: '👨‍🎨',
      lastMessage: 'Nouvelle conversation',
      timestamp: DateTime.now().subtract(const Duration(days: 5)),
      unreadCount: 0,
      messages: [],
    ),
    Conversation(
      id: 'conv_gabrielle',
      contactName: 'Gabrielle Simon',
      contactAvatar: '👩‍⚕️',
      lastMessage: 'Nouvelle conversation',
      timestamp: DateTime.now().subtract(const Duration(days: 7)),
      unreadCount: 0,
      messages: [],
    ),
    Conversation(
      id: 'conv_hugo',
      contactName: 'Hugo Laurent',
      contactAvatar: '👨‍💼',
      lastMessage: 'Nouvelle conversation',
      timestamp: DateTime.now().subtract(const Duration(days: 10)),
      unreadCount: 0,
      messages: [],
    ),
  ];

  // Réponses automatiques variées
  static final List<String> autoReplies = [
    'Merci pour ton message ! 😊',
    'C\'est intéressant !',
    'Je vais y réfléchir.',
    'Parfait ! 👍',
    'D\'accord avec toi.',
    'Bonne idée ! 💡',
    'Absolument !',
    'Je ne suis pas sûr(e)...',
    'Peux-tu m\'en dire plus ?',
    'Super ! 🚀',
    'Hmm, laisse-moi vérifier.',
    'Ça marche pour moi !',
    'Excellente question !',
    'Je reviens vers toi bientôt.',
    'C\'est noté ! 📝',
    'Merci de m\'avoir prévenu(e).',
    'À bientôt ! 👋',
    'Pas de problème !',
    'Je suis d\'accord.',
    'Très bonne observation !',
  ];

  // Messages d'exemple pour les nouvelles conversations
  static final List<String> starterMessages = [
    'Salut ! Comment ça va ?',
    'Hey ! Quoi de neuf ?',
    'Bonjour ! J\'espère que tu vas bien.',
    'Coucou ! Tu as une minute ?',
    'Salut ! J\'ai une question pour toi.',
    'Hello ! Comment s\'est passée ta journée ?',
    'Salut ! Tu es disponible ?',
    'Hey ! J\'ai pensé à toi.',
    'Bonjour ! J\'espère ne pas te déranger.',
    'Salut ! Tu as vu les nouvelles ?',
  ];
}
