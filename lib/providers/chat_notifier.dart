import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:chat_template/models/chat_message.dart';
import 'package:chat_template/providers/chat_state.dart';
import 'package:chat_template/database/db_service.dart';

part 'chat_notifier.g.dart';

@riverpod
class ChatSession extends _$ChatSession {
  late ChatDatabase _database;

  @override
  ChatState build() {
    _database = ref.watch(chatDatabaseProvider);
    
    const initialId = 'default';
    
    // We can't use await in build directly without changing return type to Future
    // So we provide an initial empty state and trigger a load
    _initDatabase();

    return const ChatState(
      conversations: {
        initialId: ConversationState(messages: []),
      },
      activeConversationId: initialId,
    );
  }

  Future<void> _initDatabase() async {
    await _database.init();
    await loadFromDatabase();
  }

  Future<void> loadFromDatabase() async {
    final conversations = await _database.getAllConversations();
    if (conversations.isNotEmpty) {
      // Find the last active one or default to the first one
      final activeId = conversations.keys.first;
      state = state.copyWith(
        conversations: conversations,
        activeConversationId: activeId,
      );
    } else {
      // If empty, persist the default one we just created in build()
      await _database.saveConversation(state.activeConversationId, state.conversations[state.activeConversationId]!);
      await _database.updateConversationIndex([state.activeConversationId]);
    }
  }

  Future<void> setActiveConversation(String id) async {
    final newConversations = Map<String, ConversationState>.from(state.conversations);
    if (!newConversations.containsKey(id)) {
      newConversations[id] = const ConversationState(messages: []);
      state = state.copyWith(
        conversations: newConversations,
        activeConversationId: id,
      );
      // Persist new conversation and update index
      await _database.saveConversation(id, newConversations[id]!);
      await _database.updateConversationIndex(newConversations.keys.toList());
    } else {
      state = state.copyWith(activeConversationId: id);
    }
  }

  Future<void> setChatContext({
    bool? isGroupChat,
    String? connectionPath,
    String? currentHandle,
  }) async {
    final activeConv = state.conversations[state.activeConversationId]!;
    final updatedConv = activeConv.copyWith(
      isGroupChat: isGroupChat,
      connectionPath: connectionPath,
      currentHandle: currentHandle,
    );

    final newConversations = Map<String, ConversationState>.from(state.conversations);
    newConversations[state.activeConversationId] = updatedConv;
    
    state = state.copyWith(conversations: newConversations);
    
    // Persist
    await _database.saveConversation(state.activeConversationId, updatedConv);
  }

  Future<void> addMessage(ChatMessage message) async {
    final activeConv = state.conversations[state.activeConversationId]!;
    final updatedMessages = List<ChatMessage>.from(activeConv.messages)..add(message);
    final updatedConv = activeConv.copyWith(messages: updatedMessages);

    final newConversations = Map<String, ConversationState>.from(state.conversations);
    newConversations[state.activeConversationId] = updatedConv;

    state = state.copyWith(conversations: newConversations);
    
    // Persist
    await _database.saveConversation(state.activeConversationId, updatedConv);
  }

  Future<void> removeMessage(ChatMessage message) async {
    final activeConv = state.conversations[state.activeConversationId]!;
    final updatedMessages = List<ChatMessage>.from(activeConv.messages)..removeWhere((m) => m.id == message.id);
    final updatedConv = activeConv.copyWith(messages: updatedMessages);

    final newConversations = Map<String, ConversationState>.from(state.conversations);
    newConversations[state.activeConversationId] = updatedConv;

    state = state.copyWith(conversations: newConversations);
    
    // Persist
    await _database.saveConversation(state.activeConversationId, updatedConv);
  }

  Future<void> updateDraft(String text) async {
    final activeConv = state.conversations[state.activeConversationId]!;
    if (activeConv.draft == text) return;

    final updatedConv = activeConv.copyWith(draft: text);

    final newConversations = Map<String, ConversationState>.from(state.conversations);
    newConversations[state.activeConversationId] = updatedConv;

    state = state.copyWith(conversations: newConversations);
    
    // Persist draft
    await _database.saveConversation(state.activeConversationId, updatedConv);
  }

  Future<void> retryMessage(ChatMessage message) async {
    final activeConv = state.conversations[state.activeConversationId]!;
    final index = activeConv.messages.indexWhere((m) => m.id == message.id);
    
    if (index != -1) {
      final updatedMessage = activeConv.messages[index].copyWith(status: MessageStatus.sending);
      final updatedMessages = List<ChatMessage>.from(activeConv.messages)..[index] = updatedMessage;
      final updatedConv = activeConv.copyWith(messages: updatedMessages);

      final newConversations = Map<String, ConversationState>.from(state.conversations);
      newConversations[state.activeConversationId] = updatedConv;

      state = state.copyWith(conversations: newConversations);
      
      // Persist status update
      await _database.saveConversation(state.activeConversationId, updatedConv);
        }
      }
    
      Future<void> updateMessageStatus(String messageId, MessageStatus status, {int? attempt}) async {
        final activeConv = state.conversations[state.activeConversationId]!;
        final index = activeConv.messages.indexWhere((m) => m.id == messageId);
        
        if (index != -1) {
          final updatedMessage = activeConv.messages[index].copyWith(
            status: status,
            attempt: attempt,
          );
          final updatedMessages = List<ChatMessage>.from(activeConv.messages)..[index] = updatedMessage;
          final updatedConv = activeConv.copyWith(messages: updatedMessages);
    
          final newConversations = Map<String, ConversationState>.from(state.conversations);
          newConversations[state.activeConversationId] = updatedConv;
    
          state = state.copyWith(conversations: newConversations);
          
          // Persist status update
          await _database.saveConversation(state.activeConversationId, updatedConv);
        }
      }
    }
    