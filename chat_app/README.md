# 💬 Application de Chat Flutter avec BLoC

Une application de chat moderne développée avec Flutter et le pattern BLoC, offrant une interface utilisateur intuitive pour la messagerie instantanée.

## ✨ Fonctionnalités

### 📱 Écran Liste des Conversations
- **Liste des conversations** avec avatar, nom du contact et dernier message
- **Badge de messages non lus** avec compteur
- **Navigation** vers l'écran de conversation détaillée
- **Création de nouvelles conversations** avec sélection d'avatar
- **Pull-to-refresh** pour actualiser la liste
- **Interface vide** avec invitation à créer une conversation

### 💬 Écran de Conversation Détaillée
- **Affichage des messages** de la conversation sélectionnée
- **Champ de saisie** pour envoyer des messages
- **Messages différenciés visuellement** (utilisateur/contact)
- **Horodatage** des messages
- **Défilement automatique** vers les nouveaux messages
- **Marquage automatique** des messages comme lus

## 🏗️ Architecture

### 📁 Structure du Projet
```
lib/
├── bloc/                    # Gestion d'état BLoC
│   ├── conversation_bloc.dart
│   ├── conversation_event.dart
│   └── conversation_state.dart
├── models/                  # Modèles de données
│   ├── conversation.dart
│   ├── message.dart
│   └── user.dart
├── screens/                 # Écrans de l'application
│   ├── conversation_list_screen.dart
│   └── chat_detail_screen.dart
├── services/                # Services métier
│   └── chat_service.dart
├── widgets/                 # Widgets réutilisables
│   ├── conversation_tile.dart
│   ├── message_bubble.dart
│   └── chat_input.dart
└── main.dart               # Point d'entrée
```

### 🔄 Pattern BLoC
- **States immutables** avec `equatable`
- **Events** : LoadConversations, SendMessage, ReceiveMessage, CreateConversation
- **States** : ConversationInitial, ConversationLoading, ConversationLoaded, ConversationError
- **Gestion centralisée** de l'état de l'application

### 📊 Modèles de Données

#### Conversation
```dart
class Conversation {
  final String id;
  final String contactName;
  final String contactAvatar;
  final String lastMessage;
  final DateTime timestamp;
  final int unreadCount;
  final List<Message> messages;
}
```

#### Message
```dart
class Message {
  final String id;
  final String content;
  final String senderId;
  final DateTime timestamp;
  final bool isRead;
  final bool isFromCurrentUser;
}
```

## 🚀 Fonctionnalités Techniques

### 📱 Interface Utilisateur
- **Material Design 3** avec thème personnalisé
- **Responsive design** adaptatif
- **Animations fluides** pour les transitions
- **Gestion des états de chargement** et d'erreur

### 🔧 Gestion d'État
- **BLoC Pattern** pour une architecture propre
- **States immutables** pour la prévisibilité
- **Séparation des responsabilités** entre UI et logique métier

### 🎯 Fonctionnalités Avancées
- **Réponses automatiques** simulées
- **Horodatage intelligent** (aujourd'hui, hier, date)
- **Compteur de messages non lus**
- **Simulation de délais réseau** réalistes

## 📦 Dépendances

```yaml
dependencies:
  flutter_bloc: ^8.1.6    # Gestion d'état BLoC
  equatable: ^2.0.5       # Comparaison d'objets immutables
  intl: ^0.19.0          # Formatage des dates
```

## 🎨 Design

### 🎨 Thème
- **Couleur principale** : Bleu
- **Material Design 3** activé
- **AppBar centrée** pour une meilleure UX

### 📱 Composants UI
- **ConversationTile** : Élément de liste avec avatar et badge
- **MessageBubble** : Bulle de message avec style différencié
- **ChatInput** : Champ de saisie avec bouton d'envoi

## 🔮 Améliorations Futures

- [ ] **Persistance des données** avec base de données locale
- [ ] **Notifications push** pour les nouveaux messages
- [ ] **Envoi de médias** (images, fichiers)
- [ ] **Messages vocaux**
- [ ] **Statuts de lecture** (envoyé, reçu, lu)
- [ ] **Recherche** dans les conversations
- [ ] **Thème sombre**
- [ ] **Synchronisation cloud**

## 🚀 Lancement de l'Application

```bash
# Installer les dépendances
flutter pub get

# Lancer l'application
flutter run

# Analyser le code
flutter analyze
```

## 📱 Test

L'application peut être testée sur :
- **Web** (Edge/Chrome)
- **Android** (avec débogage USB)
- **iOS** (avec Xcode)
- **Desktop** (Windows/macOS/Linux)

---

*Développé avec ❤️ en Flutter et BLoC*
