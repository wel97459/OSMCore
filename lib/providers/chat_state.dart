import 'package:chat_template/models/chat_message.dart';

class ConversationState {
  final List<ChatMessage> messages;
  final bool isGroupChat;
  final bool isFlood;
  final String connectionPath;
  final String currentHandle;
  final String draft;

  const ConversationState({
    required this.messages,
    this.isGroupChat = false,
    this.isFlood = false,
    this.connectionPath = "Path: Direct",
    this.currentHandle = "User",
    this.draft = "",
  });

  ConversationState copyWith({
    List<ChatMessage>? messages,
    bool? isGroupChat,
    bool? isFlood,
    String? connectionPath,
    String? currentHandle,
    String? draft,
  }) {
    return ConversationState(
      messages: messages ?? this.messages,
      isGroupChat: isGroupChat ?? this.isGroupChat,
      isFlood: isFlood ?? this.isFlood,
      connectionPath: connectionPath ?? this.connectionPath,
      currentHandle: currentHandle ?? this.currentHandle,
      draft: draft ?? this.draft,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messages': messages.map((m) => m.toJson()).toList(),
      'isGroupChat': isGroupChat,
      'isGroupChat': isGroupChat,
      'isFlood': isFlood,
      'connectionPath': connectionPath,
      'currentHandle': currentHandle,
      'draft': draft,
    };
  }

  factory ConversationState.fromJson(Map<String, dynamic> json) {
    return ConversationState(
      messages: (json['messages'] as List)
          .map((m) => ChatMessage.fromJson(m as Map<String, dynamic>))
          .toList(),
      isGroupChat: json['isGroupChat'] as bool,
      isFlood: json['isFlood'] as bool,
      connectionPath: json['connectionPath'] as String,
      currentHandle: json['currentHandle'] as String,
      draft: json['draft'] as String,
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
  bool get isFlood => conversations[activeConversationId]?.isFlood ?? false;
  String get connectionPath => conversations[activeConversationId]?.connectionPath ?? "Path: Direct";
  String get currentHandle => conversations[activeConversationId]?.currentHandle ?? "User";
  String get currentDraft => conversations[activeConversationId]?.draft ?? "";

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
