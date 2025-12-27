import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:chat_template/models/chat_message.dart';
import 'package:chat_template/providers/chat_state.dart';

part 'chat_notifier.g.dart';

@riverpod
class ChatSession extends _$ChatSession {
  @override
  ChatState build() {
    const initialId = 'default';
    return const ChatState(
      conversations: {
        initialId: ConversationState(messages: []),
      },
      activeConversationId: initialId,
    );
  }

  void setActiveConversation(String id) {
    if (!state.conversations.containsKey(id)) {
      final newConversations = Map<String, ConversationState>.from(state.conversations);
      newConversations[id] = const ConversationState(messages: []);
      state = state.copyWith(
        conversations: newConversations,
        activeConversationId: id,
      );
    } else {
      state = state.copyWith(activeConversationId: id);
    }
  }

  void setChatContext({
    bool? isGroupChat,
    String? connectionPath,
    String? currentHandle,
  }) {
    final activeConv = state.conversations[state.activeConversationId]!;
    final updatedConv = activeConv.copyWith(
      isGroupChat: isGroupChat,
      connectionPath: connectionPath,
      currentHandle: currentHandle,
    );

    final newConversations = Map<String, ConversationState>.from(state.conversations);
    newConversations[state.activeConversationId] = updatedConv;
    
    state = state.copyWith(conversations: newConversations);
  }

  void addMessage(ChatMessage message) {
    final activeConv = state.conversations[state.activeConversationId]!;
    final updatedMessages = List<ChatMessage>.from(activeConv.messages)..add(message);
    final updatedConv = activeConv.copyWith(messages: updatedMessages);

    final newConversations = Map<String, ConversationState>.from(state.conversations);
    newConversations[state.activeConversationId] = updatedConv;

    state = state.copyWith(conversations: newConversations);
  }

  void removeMessage(ChatMessage message) {
    final activeConv = state.conversations[state.activeConversationId]!;
    final updatedMessages = List<ChatMessage>.from(activeConv.messages)..remove(message);
    final updatedConv = activeConv.copyWith(messages: updatedMessages);

    final newConversations = Map<String, ConversationState>.from(state.conversations);
    newConversations[state.activeConversationId] = updatedConv;

    state = state.copyWith(conversations: newConversations);
  }

  void updateDraft(String text) {
    final activeConv = state.conversations[state.activeConversationId]!;
    final updatedConv = activeConv.copyWith(draft: text);

    final newConversations = Map<String, ConversationState>.from(state.conversations);
    newConversations[state.activeConversationId] = updatedConv;

    state = state.copyWith(conversations: newConversations);
  }
}
