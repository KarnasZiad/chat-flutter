import 'dart:math';

class ChatbotService {
  static final ChatbotService _instance = ChatbotService._internal();
  factory ChatbotService() => _instance;
  ChatbotService._internal();

  // Contexte de conversation pour chaque utilisateur
  final Map<String, List<String>> _conversationHistory = {};
  final Map<String, String> _userContext = {};

  // Base de connaissances du chatbot
  final Map<String, List<String>> _responses = {
    // Salutations
    'salut': [
      'Salut ! Comment ça va aujourd\'hui ?',
      'Hey ! Ravi de te parler !',
      'Salut ! Qu\'est-ce qui t\'amène ?',
      'Coucou ! Comment puis-je t\'aider ?',
    ],
    'bonjour': [
      'Bonjour ! J\'espère que tu passes une excellente journée !',
      'Bonjour ! Comment puis-je t\'aider aujourd\'hui ?',
      'Salut ! Quoi de neuf ?',
      'Bonjour ! Ravi de te voir !',
    ],
    'bonsoir': [
      'Bonsoir ! Comment s\'est passée ta journée ?',
      'Bonsoir ! Tu as passé une bonne journée ?',
      'Salut ! La soirée commence bien !',
    ],

    // Questions sur l'état
    'comment': [
      'Ça va super bien, merci ! Et toi ?',
      'Très bien ! Je suis là pour discuter avec toi !',
      'Parfait ! Toujours prêt à aider !',
      'Excellente forme ! Et toi, comment ça se passe ?',
    ],
    'ça va': [
      'Tant mieux ! Moi aussi ça va bien !',
      'Super ! Qu\'est-ce qu\'on fait aujourd\'hui ?',
      'Parfait ! Tu as des projets intéressants ?',
    ],

    // Technologie et développement
    'flutter': [
      'Flutter est fantastique ! Tu développes quelque chose d\'intéressant ?',
      'J\'adore Flutter ! C\'est si puissant pour créer des apps multiplateformes !',
      'Flutter + Dart = combo parfait ! Tu travailles sur quel type d\'app ?',
      'Excellent choix ! Flutter rend le développement mobile si fluide !',
    ],
    'développement': [
      'Le développement, c\'est passionnant ! Tu codes dans quels langages ?',
      'Super ! Moi j\'adore parler de programmation ! Quel est ton projet actuel ?',
      'Génial ! Tu préfères le front-end ou le back-end ?',
    ],
    'code': [
      'Le code, c\'est de la poésie ! Tu travailles sur quoi en ce moment ?',
      'Coder, c\'est créer ! Quel est ton langage préféré ?',
      'J\'adore parler code ! Tu as des défis techniques intéressants ?',
    ],

    // Projets et travail
    'projet': [
      'Un nouveau projet ? Raconte-moi ça !',
      'Super ! J\'adore entendre parler de nouveaux projets !',
      'Intéressant ! C\'est dans quel domaine ?',
      'Génial ! Tu peux me donner plus de détails ?',
    ],
    'travail': [
      'Le travail, ça se passe bien ?',
      'Tu aimes ce que tu fais ?',
      'Raconte-moi ton travail, ça m\'intéresse !',
      'Tu travailles dans quel secteur ?',
    ],

    // Aide et questions
    'aide': [
      'Bien sûr ! Je suis là pour t\'aider ! Dis-moi tout !',
      'Avec plaisir ! Quel est le problème ?',
      'Pas de souci ! Explique-moi ce dont tu as besoin !',
      'Je suis là pour ça ! Comment puis-je t\'aider ?',
    ],
    'question': [
      'Vas-y, pose ta question ! Je suis tout ouïe !',
      'J\'adore les questions ! Qu\'est-ce que tu veux savoir ?',
      'Parfait ! Quelle est ta question ?',
    ],
    'problème': [
      'Oh non ! Raconte-moi ce qui ne va pas.',
      'Pas de panique ! On va résoudre ça ensemble !',
      'Dis-moi tout, je vais t\'aider !',
      'Quel type de problème ? Je suis là pour aider !',
    ],

    // Émotions positives
    'merci': [
      'De rien ! C\'était un plaisir !',
      'Avec plaisir ! N\'hésite pas si tu as besoin !',
      'Pas de quoi ! Je suis là pour ça !',
      'Content d\'avoir pu t\'aider ! 😊',
    ],
    'super': [
      'Génial ! Ça fait plaisir à entendre !',
      'Excellent ! Continue comme ça !',
      'Fantastique ! Tu as l\'air en forme !',
    ],
    'parfait': [
      'Tant mieux ! Tout roule alors !',
      'Excellent ! C\'est ce qu\'on aime entendre !',
      'Super ! Les choses se passent bien !',
    ],

    // Loisirs et intérêts
    'musique': [
      'J\'adore la musique ! Tu écoutes quoi en ce moment ?',
      'La musique, c\'est la vie ! Quel est ton style préféré ?',
      'Super ! Tu joues d\'un instrument ?',
    ],
    'sport': [
      'Le sport, c\'est important ! Tu pratiques quoi ?',
      'Génial ! Rester actif, c\'est essentiel !',
      'Super ! Quel est ton sport préféré ?',
    ],
    'lecture': [
      'J\'adore lire ! Tu lis quoi en ce moment ?',
      'La lecture, c\'est fantastique ! Quel genre tu préfères ?',
      'Excellent ! Un bon livre à recommander ?',
    ],

    // Réponses par défaut
    'default': [
      'Intéressant ! Peux-tu m\'en dire plus ?',
      'Hmm, je vois ! Continue, ça m\'intéresse !',
      'C\'est fascinant ! Raconte-moi la suite !',
      'Je t\'écoute ! Développe un peu !',
      'Ah oui ? Dis-moi en plus !',
      'C\'est cool ! Tu peux détailler ?',
      'Je comprends ! Et après ?',
      'Très bien ! Qu\'est-ce que tu en penses ?',
    ],
  };

  // Mots-clés pour détecter l'intention
  final Map<String, List<String>> _keywords = {
    'salut': ['salut', 'hello', 'hey', 'coucou', 'yo'],
    'bonjour': ['bonjour', 'bonsoir', 'bonne nuit'],
    'comment': ['comment', 'ça va', 'comment ça va', 'comment tu vas'],
    'ça va': ['ça va', 'ca va', 'bien', 'très bien', 'super bien'],
    'flutter': ['flutter', 'dart', 'widget', 'app', 'application'],
    'développement': ['développement', 'dev', 'programmation', 'coding'],
    'code': ['code', 'coder', 'programmer', 'script'],
    'projet': ['projet', 'app', 'application', 'site', 'logiciel'],
    'travail': ['travail', 'job', 'boulot', 'bureau', 'entreprise'],
    'aide': ['aide', 'aider', 'help', 'assistance', 'support'],
    'question': ['question', 'demande', 'interrogation'],
    'problème': ['problème', 'souci', 'bug', 'erreur', 'issue'],
    'merci': ['merci', 'thanks', 'remercie'],
    'super': ['super', 'génial', 'excellent', 'fantastique', 'top'],
    'parfait': ['parfait', 'perfect', 'nickel', 'impeccable'],
    'musique': ['musique', 'chanson', 'album', 'concert', 'son'],
    'sport': ['sport', 'fitness', 'gym', 'course', 'match'],
    'lecture': ['livre', 'lire', 'lecture', 'roman', 'bouquin'],
  };

  String generateResponse(String userMessage, String userId) {
    // Ajouter le message à l'historique
    _conversationHistory.putIfAbsent(userId, () => []);
    _conversationHistory[userId]!.add(userMessage.toLowerCase());

    // Analyser le message pour détecter l'intention
    String intent = _detectIntent(userMessage.toLowerCase());
    
    // Générer une réponse contextuelle
    String response = _generateContextualResponse(intent, userId, userMessage);
    
    return response;
  }

  String _detectIntent(String message) {
    // Chercher des mots-clés dans le message
    for (String intent in _keywords.keys) {
      for (String keyword in _keywords[intent]!) {
        if (message.contains(keyword)) {
          return intent;
        }
      }
    }
    return 'default';
  }

  String _generateContextualResponse(String intent, String userId, String originalMessage) {
    List<String> possibleResponses = _responses[intent] ?? _responses['default']!;
    
    // Éviter de répéter la même réponse
    List<String> history = _conversationHistory[userId] ?? [];
    
    // Ajouter du contexte basé sur l'historique
    if (history.length > 1) {
      String lastMessage = history[history.length - 2];
      
      // Réponses contextuelles spéciales
      if (lastMessage.contains('ça va') && intent == 'comment') {
        return 'Content que ça aille bien ! Qu\'est-ce que tu fais de beau ?';
      }
      
      if (lastMessage.contains('merci') && intent == 'default') {
        return 'De rien ! Y a-t-il autre chose dont tu veux parler ?';
      }
      
      if (lastMessage.contains('projet') && intent == 'flutter') {
        return 'Ah, ton projet est en Flutter ? C\'est génial ! Raconte-moi plus !';
      }
    }
    
    // Sélectionner une réponse aléatoire
    String response = possibleResponses[Random().nextInt(possibleResponses.length)];
    
    // Personnaliser certaines réponses
    if (intent == 'salut' && history.length > 5) {
      response = 'Re-salut ! On se retrouve ! Comment ça va depuis tout à l\'heure ?';
    }
    
    return response;
  }

  // Réinitialiser le contexte pour un utilisateur
  void resetContext(String userId) {
    _conversationHistory.remove(userId);
    _userContext.remove(userId);
  }

  // Obtenir l'historique de conversation
  List<String> getConversationHistory(String userId) {
    return _conversationHistory[userId] ?? [];
  }
}
