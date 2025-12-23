import 'package:flutter/foundation.dart';
import 'package:chat_template/models/chat_message.dart';

class Conversation {
  final List<ChatMessage> messages = [];
  bool isGroupChat = false;
  String connectionPath = "Path: Direct";
  String currentHandle = "User";
}

class ChatProvider with ChangeNotifier {
  final Map<String, Conversation> _conversations = {};
  String _activeConversationId = 'default';

  ChatProvider() {
    _conversations[_activeConversationId] = Conversation();
  }

  Conversation get _activeConversation => _conversations[_activeConversationId]!;

  List<ChatMessage> get messages => List.unmodifiable(_activeConversation.messages);
  bool get isGroupChat => _activeConversation.isGroupChat;
  String get connectionPath => _activeConversation.connectionPath;
  String get currentHandle => _activeConversation.currentHandle;

  void setActiveConversation(String id) {
    if (!_conversations.containsKey(id)) {
      _conversations[id] = Conversation();
    }
    _activeConversationId = id;
    notifyListeners();
  }

  void setChatContext({
    bool? isGroupChat,
    String? connectionPath,
    String? currentHandle,
  }) {
    if (isGroupChat != null) _activeConversation.isGroupChat = isGroupChat;
    if (connectionPath != null) _activeConversation.connectionPath = connectionPath;
    if (currentHandle != null) _activeConversation.currentHandle = currentHandle;
    notifyListeners();
  }

  void addMessage(ChatMessage message) {
    _activeConversation.messages.add(message);
    notifyListeners();
  }

  void removeMessage(ChatMessage message) {
    _activeConversation.messages.remove(message);
    notifyListeners();
  }
}