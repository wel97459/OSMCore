import 'package:flutter_test/flutter_test.dart';
import 'package:chat_template/models/chat_message.dart';

void main() {
  group('ChatMessage', () {
    test('should have correct properties initialized', () {
      final timestamp = DateTime.now();
      final message = ChatMessage(
        id: '1',
        text: 'Hello',
        senderId: 'user1',
        timestamp: timestamp,
        status: MessageStatus.sent,
      );

      expect(message.id, '1');
      expect(message.text, 'Hello');
      expect(message.senderId, 'user1');
      expect(message.timestamp, timestamp);
      expect(message.status, MessageStatus.sent);
    });

    test('should default status to sent if not provided', () {
      final message = ChatMessage(
        id: '2',
        text: 'Hi',
        senderId: 'user2',
        timestamp: DateTime.now(),
      );

      expect(message.status, MessageStatus.sent);
    });
  });
}
