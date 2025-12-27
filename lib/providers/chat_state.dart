import 'package:chat_template/models/chat_message.dart';

class ConversationState {
  final List<ChatMessage> messages;
  final bool isGroupChat;
  final String connectionPath;
  final String currentHandle;

  const ConversationState({
    required this.messages,
    this.isGroupChat = false,
    this.connectionPath = "Path: Direct",
    this.currentHandle = "User",
  });

  ConversationState copyWith({
    List<ChatMessage>? messages,
    bool? isGroupChat,
    String? connectionPath,
    String? currentHandle,
  }) {
    return ConversationState(
      messages: messages ?? this.messages,
      isGroupChat: isGroupChat ?? this.isGroupChat,
      connectionPath: connectionPath ?? this.connectionPath,
      currentHandle: currentHandle ?? this.currentHandle,
    );
  }
}

class ChatState {
  final Map<String, ConversationState> conversations;
  final String activeConversationId;

  const ChatState({
    required this.conversations,
    required this.activeConversationId,
  });

  List<ChatMessage> get messages => conversations[activeConversationId]?.messages ?? [];
  bool get isGroupChat => conversations[activeConversationId]?.isGroupChat ?? false;
  String get connectionPath => conversations[activeConversationId]?.connectionPath ?? "Path: Direct";
  String get currentHandle => conversations[activeConversationId]?.currentHandle ?? "User";

  ChatState copyWith({
    Map<String, ConversationState>? conversations,
    String? activeConversationId,
  }) {
    return ChatState(
      conversations: conversations ?? this.conversations,
      activeConversationId: activeConversationId ?? this.activeConversationId,
    );
  }
}
