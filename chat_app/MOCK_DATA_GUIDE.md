# 📊 Guide des Données Mock - Application de Chat

Ce guide explique la structure et l'utilisation des données simulées dans l'application de chat Flutter.

## 🗂️ Structure des Données Mock

### 📁 Fichier Principal : `lib/data/mock_data.dart`

Ce fichier contient toutes les données simulées utilisées dans l'application pour créer une expérience réaliste sans backend.

## 👥 Utilisateurs Mock (`mockUsers`)

### 📋 Liste des Utilisateurs Disponibles

| ID | Nom | Avatar | Rôle/Profession |
|---|---|---|---|
| `alice_martin` | Alice Martin | 👩‍💼 | Responsable projet |
| `bob_dupont` | Bob Dupont | 👨‍💻 | Développeur |
| `claire_rousseau` | Claire Rousseau | 👩‍🎨 | Designer |
| `david_bernard` | David Bernard | 👨‍🔬 | Chercheur |
| `emma_dubois` | Emma Dubois | 👩‍🏫 | Professeure |
| `felix_moreau` | Félix Moreau | 👨‍🎨 | Artiste |
| `gabrielle_simon` | Gabrielle Simon | 👩‍⚕️ | Médecin |
| `hugo_laurent` | Hugo Laurent | 👨‍💼 | Manager |

## 💬 Conversations Mock (`mockConversations`)

### 🔄 États des Conversations

#### 🟢 Conversations Actives (avec messages récents)
- **Alice Martin** : Conversation de travail récente (5 min)
- **Bob Dupont** : Discussion technique (3h)
- **Claire Rousseau** : Échange créatif (1 jour)

#### 🟡 Conversations Modérées
- **David Bernard** : Discussion scientifique (2 jours)
- **Emma Dubois** : Échange éducatif (3 jours)

#### 🔵 Conversations Dormantes
- **Félix Moreau** : Nouvelle conversation (5 jours)
- **Gabrielle Simon** : Nouvelle conversation (7 jours)
- **Hugo Laurent** : Nouvelle conversation (10 jours)

### 📊 Statistiques des Messages Non Lus

```
Alice Martin    : 2 messages non lus
Bob Dupont      : 1 message non lu
Claire Rousseau : 1 message non lu
Autres          : 0 message non lu
```

## 📝 Messages Mock (`mockMessages`)

### 🎯 Types de Conversations Simulées

#### 💼 **Conversation Professionnelle** (Alice)
- Planification de projet
- Coordination d'équipe
- Messages récents et urgents

#### 💻 **Discussion Technique** (Bob)
- Échange sur les technologies
- Partage de connaissances
- Veille technologique

#### 🎨 **Échange Créatif** (Claire)
- Partage de maquettes
- Feedback créatif
- Collaboration artistique

#### 🔬 **Discussion Scientifique** (David)
- Résultats de recherche
- Planification de réunions
- Échanges académiques

#### 🏫 **Échange Éducatif** (Emma)
- Retours sur cours
- Questions d'étudiants
- Planification pédagogique

### ⏰ Chronologie Réaliste

Les messages sont distribués sur différentes périodes :
- **Récent** : 5 minutes à 3 heures
- **Aujourd'hui** : 3 à 24 heures
- **Hier** : 1 à 2 jours
- **Cette semaine** : 3 à 7 jours
- **Plus ancien** : 7+ jours

## 🤖 Réponses Automatiques (`autoReplies`)

### 📱 20 Réponses Variées

Les réponses automatiques incluent :
- **Remerciements** : "Merci pour ton message ! 😊"
- **Approbation** : "Parfait ! 👍", "Super ! 🚀"
- **Réflexion** : "Je vais y réfléchir.", "Hmm, laisse-moi vérifier."
- **Questions** : "Peux-tu m'en dire plus ?"
- **Confirmation** : "C'est noté ! 📝", "Ça marche pour moi !"

## 🚀 Messages de Démarrage (`starterMessages`)

### 💬 10 Messages d'Ouverture

Pour initier de nouvelles conversations :
- Salutations variées
- Questions ouvertes
- Messages contextuels

## 🔧 Utilisation dans l'Application

### 📊 ChatService Integration

```dart
// Chargement des conversations
final conversations = List.from(MockData.mockConversations);

// Réponses automatiques
final randomResponse = MockData.autoReplies[Random().nextInt(MockData.autoReplies.length)];

// Messages de démarrage
final starterMessage = MockData.starterMessages[Random().nextInt(MockData.starterMessages.length)];
```

### 🎲 Fonctionnalités Dynamiques

#### 🔄 Simulation de Messages Entrants
- Timer périodique (2 minutes)
- Messages aléatoires
- Conversations vivantes

#### 🎯 Création de Nouvelles Conversations
- Sélection de contacts disponibles
- Attribution automatique d'avatars
- Initialisation avec messages de base

## 📈 Avantages des Données Mock

### ✅ **Développement**
- Test sans backend
- Données cohérentes
- Scénarios variés

### ✅ **Démonstration**
- Expérience réaliste
- Cas d'usage multiples
- Interface vivante

### ✅ **Tests**
- Données prévisibles
- États variés
- Couverture complète

## 🔮 Extensions Possibles

### 📊 **Données Supplémentaires**
- Groupes de discussion
- Messages multimédias
- Statuts de présence

### 🎯 **Fonctionnalités Avancées**
- Historique de messages
- Recherche dans les conversations
- Notifications personnalisées

---

*Les données mock permettent une expérience utilisateur riche et réaliste tout en gardant l'application autonome et facilement testable.*
