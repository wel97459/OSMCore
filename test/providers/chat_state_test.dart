import 'package:flutter_test/flutter_test.dart';
import 'package:chat_template/providers/chat_state.dart';
import 'package:chat_template/models/chat_message.dart';

void main() {
  group('ConversationState', () {
    test('should support serialization to/from JSON', () {
      final messages = [
        ChatMessage(
          id: '1',
          text: 'Msg 1',
          senderId: 'u1',
          timestamp: DateTime.now(),
        ),
      ];
      final state = ConversationState(
        messages: messages,
        isGroupChat: true,
        connectionPath: 'Path: Test',
        currentHandle: 'Handle',
        draft: 'Draft',
      );

      final json = state.toJson();
      expect(json['isGroupChat'], true);
      expect(json['connectionPath'], 'Path: Test');
      expect(json['currentHandle'], 'Handle');
      expect(json['draft'], 'Draft');
      expect((json['messages'] as List).length, 1);

      final fromJson = ConversationState.fromJson(json);
      expect(fromJson.isGroupChat, state.isGroupChat);
      expect(fromJson.connectionPath, state.connectionPath);
      expect(fromJson.currentHandle, state.currentHandle);
      expect(fromJson.draft, state.draft);
      expect(fromJson.messages.length, 1);
      expect(fromJson.messages.first.text, 'Msg 1');
    });
  });
}
