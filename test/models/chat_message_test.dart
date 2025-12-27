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
        status: MessageStatus.delivered,
      );

      expect(message.id, '1');
      expect(message.text, 'Hello');
      expect(message.senderId, 'user1');
      expect(message.timestamp, timestamp);
      expect(message.status, MessageStatus.delivered);
    });

    test('should default status to sending if not provided', () {
      final message = ChatMessage(
        id: '2',
        text: 'Hi',
        senderId: 'user2',
        timestamp: DateTime.now(),
      );

      expect(message.status, MessageStatus.sending);
    });

    test('should support failed status', () {
      final message = ChatMessage(
        id: '3',
        text: 'Failed Message',
        senderId: 'user1',
        timestamp: DateTime.now(),
        status: MessageStatus.failed,
      );

      expect(message.status, MessageStatus.failed);
    });
  });
}