import 'package:flutter_test/flutter_test.dart';
import 'package:chat_template/database/db_service.dart';
import 'package:chat_template/providers/chat_state.dart';
import 'package:chat_template/models/chat_message.dart';
import 'dart:io';

void main() {
  late ChatDatabase db;
  late String dbName;

  setUp(() async {
    dbName = 'test_db_${DateTime.now().microsecondsSinceEpoch}';
    db = ChatDatabase();
    await db.init(dbName);
  });

  tearDown(() {
    final dir = Directory(dbName);
    if (dir.existsSync()) {
      try {
        dir.deleteSync(recursive: true);
      } catch (e) {
        print('Cleanup failed for $dbName: $e');
      }
    }
  });

  group('ChatDatabase', () {
    test('should save and retrieve a conversation', () async {
      final conv = ConversationState(
        messages: [
          ChatMessage(
            id: '1',
            text: 'Test message',
            senderId: 'user1',
            timestamp: DateTime.now(),
          ),
        ],
        isGroupChat: true,
        currentHandle: 'Test Handle',
      );

      await db.saveConversation('test_id', conv);
      final retrieved = await db.getConversation('test_id');

      expect(retrieved, isNotNull);
      expect(retrieved!.currentHandle, 'Test Handle');
      expect(retrieved.isGroupChat, isTrue);
      expect(retrieved.messages.length, 1);
      expect(retrieved.messages.first.text, 'Test message');
    });

    test('should update and retrieve conversation index', () async {
      final ids = ['conv1', 'conv2'];
      await db.updateConversationIndex(ids);
      
      var retrieved = await db.getAllConversations();
      expect(retrieved, isEmpty);

      // Save them
      await db.saveConversation('conv1', const ConversationState(messages: []));
      await db.saveConversation('conv2', const ConversationState(messages: []));

      retrieved = await db.getAllConversations();
      expect(retrieved.length, 2);
      expect(retrieved.containsKey('conv1'), isTrue);
      expect(retrieved.containsKey('conv2'), isTrue);
    });
   group('Serialization', () {
    test('ChatMessage should support serialization', () {
      final msg = ChatMessage(
        id: '1', 
        text: 'Hi', 
        senderId: 'u1', 
        timestamp: DateTime.now(),
        status: MessageStatus.failed,
        attempt: 3,
      );
      final json = msg.toJson();
      final fromJson = ChatMessage.fromJson(json);
      expect(fromJson.id, msg.id);
      expect(fromJson.status, msg.status);
      expect(fromJson.attempt, 3);
    });
  });
  });
}