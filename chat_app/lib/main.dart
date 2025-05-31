import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/conversation_bloc.dart';
import 'bloc/conversation_event.dart';
import 'services/chat_service.dart';
import 'screens/conversation_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),
      home: BlocProvider(
        create: (context) => ConversationBloc(
          chatService: ChatService(),
        )..add(const LoadConversations()),
        child: const MainScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Widget content = _buildContent();

        // Vue mobile responsive
        if (constraints.maxWidth > 600) {
          // Vue desktop avec frame mobile
          return Scaffold(
            backgroundColor: const Color(0xFF1a1a1a),
            body: Center(
              child: Container(
                width: 375,
                height: 812,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Écran du téléphone
                    Positioned(
                      top: 8,
                      left: 8,
                      right: 8,
                      bottom: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: content,
                      ),
                    ),
                    // Encoche en haut
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 150,
                            height: 6,
                            margin: const EdgeInsets.only(top: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Bouton home
                    Positioned(
                      bottom: 8,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 134,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          // Vue mobile native
          return content;
        }
      },
    );
  }

  Widget _buildContent() {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const ConversationListScreen(),
          const ChatbotPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'Conversations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy_outlined),
            activeIcon: Icon(Icons.smart_toy),
            label: 'Assistant IA',
          ),
        ],
      ),
    );
  }
}

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    // Ajouter le message de bienvenue après un petit délai
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addMessage(
        'Salut ! Je suis ton assistant IA intelligent. Comment puis-je t\'aider ?',
        false,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _addMessage(String content, bool isUser) {
    if (mounted) {
      setState(() {
        _messages.add({
          'content': content,
          'isUser': isUser,
          'timestamp': DateTime.now(),
        });
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty || _isTyping) return;

    _addMessage(text, true);
    _controller.clear();

    setState(() {
      _isTyping = true;
    });

    // Simuler une réponse avec gestion d'erreur
    Future.delayed(const Duration(seconds: 2), () {
      try {
        if (mounted) {
          setState(() {
            _isTyping = false;
          });
          _addMessage(_generateResponse(text), false);
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _isTyping = false;
          });
          _addMessage('Désolé, j\'ai eu un petit problème. Peux-tu répéter ?', false);
        }
      }
    });
  }

  String _generateResponse(String message) {
    try {
      final msg = message.toLowerCase().trim();

      // Salutations
      if (msg.contains('salut') || msg.contains('hello') || msg.contains('bonjour') || msg.contains('hey')) {
        final responses = [
          'Salut ! Comment ça va ?',
          'Hey ! Ravi de te parler !',
          'Bonjour ! Comment puis-je t\'aider ?',
          'Salut ! Qu\'est-ce qui t\'amène ?'
        ];
        return responses[DateTime.now().millisecond % responses.length];
      }

      // Questions sur l'état
      else if (msg.contains('comment') || msg.contains('ça va') || msg.contains('ca va')) {
        final responses = [
          'Ça va super bien, merci ! Et toi ?',
          'Très bien ! Je suis là pour discuter !',
          'Parfait ! Toujours prêt à aider !'
        ];
        return responses[DateTime.now().millisecond % responses.length];
      }

      // Technologie
      else if (msg.contains('flutter') || msg.contains('dart') || msg.contains('code') || msg.contains('développement')) {
        final responses = [
          'Flutter est fantastique ! Tu développes quelque chose d\'intéressant ?',
          'J\'adore Flutter ! C\'est si puissant !',
          'Excellent choix ! Flutter rend le développement si fluide !',
          'Le développement, c\'est passionnant ! Raconte-moi ton projet !'
        ];
        return responses[DateTime.now().millisecond % responses.length];
      }

      // Aide
      else if (msg.contains('aide') || msg.contains('help') || msg.contains('problème') || msg.contains('question')) {
        final responses = [
          'Bien sûr ! Je suis là pour t\'aider ! Dis-moi tout !',
          'Avec plaisir ! Quel est le problème ?',
          'Pas de souci ! Explique-moi ce dont tu as besoin !',
          'Je suis là pour ça ! Comment puis-je t\'aider ?'
        ];
        return responses[DateTime.now().millisecond % responses.length];
      }

      // Remerciements
      else if (msg.contains('merci') || msg.contains('thanks')) {
        final responses = [
          'De rien ! C\'était un plaisir !',
          'Avec plaisir ! N\'hésite pas si tu as besoin !',
          'Content d\'avoir pu t\'aider ! 😊'
        ];
        return responses[DateTime.now().millisecond % responses.length];
      }

      // Réponses par défaut
      else {
        final responses = [
          'Intéressant ! Peux-tu m\'en dire plus ?',
          'Hmm, je vois ! Continue, ça m\'intéresse !',
          'C\'est fascinant ! Raconte-moi la suite !',
          'Je t\'écoute ! Développe un peu !',
          'Ah oui ? Dis-moi en plus !',
          'C\'est cool ! Tu peux détailler ?'
        ];
        return responses[DateTime.now().millisecond % responses.length];
      }
    } catch (e) {
      return 'Désolé, je n\'ai pas bien compris. Peux-tu reformuler ?';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('🤖'),
            SizedBox(width: 8),
            Text('Assistant IA'),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isTyping) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Text('🤖'),
                        SizedBox(width: 8),
                        Text('Assistant IA tape...'),
                        SizedBox(width: 8),
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ],
                    ),
                  );
                }

                final message = _messages[index];
                final isUser = message['isUser'] as bool;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: isUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      if (!isUser) ...[
                        const Text('🤖'),
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isUser
                                ? Theme.of(context).primaryColor
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            message['content'] as String,
                            style: TextStyle(
                              color: isUser ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      if (isUser) ...[
                        const SizedBox(width: 8),
                        const Text('👤'),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    enabled: !_isTyping,
                    decoration: InputDecoration(
                      hintText: _isTyping ? 'Assistant IA tape...' : 'Tapez votre message...',
                      border: const OutlineInputBorder(),
                      suffixIcon: _isTyping
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            )
                          : null,
                    ),
                    onSubmitted: (_) => _sendMessage(),
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _isTyping ? null : _sendMessage,
                  icon: const Icon(Icons.send),
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
