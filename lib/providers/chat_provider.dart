import 'package:flutter/foundation.dart';
import 'package:chat_template/models/chat_message.dart';

class ChatProvider with ChangeNotifier {
  final List<ChatMessage> _messages = [];
  bool _isGroupChat = false;
  String _connectionPath = "Path: Direct";
  String _currentHandle = "User";

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get isGroupChat => _isGroupChat;
  String get connectionPath => _connectionPath;
  String get currentHandle => _currentHandle;

  void setChatContext({
    bool? isGroupChat,
    String? connectionPath,
    String? currentHandle,
  }) {
    if (isGroupChat != null) _isGroupChat = isGroupChat;
    if (connectionPath != null) _connectionPath = connectionPath;
    if (currentHandle != null) _currentHandle = currentHandle;
    notifyListeners();
  }

  void addMessage(ChatMessage message) {
    _messages.add(message);
    notifyListeners();
  }

  void removeMessage(ChatMessage message) {
    _messages.remove(message);
    notifyListeners();
  }
}
