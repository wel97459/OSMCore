import 'package:flutter/foundation.dart';
import 'package:chat_template/models/chat_message.dart';

class ChatProvider with ChangeNotifier {
  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => List.unmodifiable(_messages);

  void addMessage(ChatMessage message) {
    _messages.add(message);
    notifyListeners();
  }

  void removeMessage(ChatMessage message) {
    _messages.remove(message);
    notifyListeners();
  }
}
