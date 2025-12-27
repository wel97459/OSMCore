import 'package:reaxdb_dart/reaxdb_dart.dart';
import 'package:chat_template/providers/chat_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'db_service.g.dart';

@riverpod
ChatDatabase chatDatabase(Ref ref) {
  return ChatDatabase();
}

class ChatDatabase {
  late final SimpleReaxDB _db;
  bool _isInitialized = false;

  Future<void> init([String name = 'chat_database']) async {
    if (_isInitialized) return;
    _db = await ReaxDB.simple(name);
    _isInitialized = true;
  }

  Future<void> saveConversation(String id, ConversationState state) async {
    await _db.put('conversation:$id', state.toJson());
  }

  Future<ConversationState?> getConversation(String id) async {
    final data = await _db.get('conversation:$id');
    if (data == null) return null;
    return ConversationState.fromJson(data);
  }

  Future<Map<String, ConversationState>> getAllConversations() async {
    // Note: ReaxDB.simple might not have a direct way to get all keys with prefix easily 
    // depending on version, but usually we can track session IDs elsewhere or use a known set.
    // For this template, we'll assume a fixed set of IDs or store an index.
    final indexData = await _db.get('conversation_index');
    final List<String> ids = indexData != null ? List<String>.from(indexData['ids']) : [];
    
    final Map<String, ConversationState> conversations = {};
    for (final id in ids) {
      final conv = await getConversation(id);
      if (conv != null) {
        conversations[id] = conv;
      }
    }
    return conversations;
  }

  Future<void> updateConversationIndex(List<String> ids) async {
    await _db.put('conversation_index', {'ids': ids});
  }
}
