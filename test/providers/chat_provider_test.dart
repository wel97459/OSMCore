import 'package:flutter_test/flutter_test.dart';
import 'package:chat_template/providers/chat_provider.dart';
import 'package:chat_template/models/chat_message.dart';

void main() {
  group('ChatProvider', () {
    test('should start with an empty list of messages', () {
      final provider = ChatProvider();
      expect(provider.messages, isEmpty);
    });

    test('addMessage should add a message and notify listeners', () {
      final provider = ChatProvider();
      bool notified = false;
      provider.addListener(() {
        notified = true;
      });

      final message = ChatMessage(
        id: '1',
        text: 'Test message',
        senderId: 'user1',
        timestamp: DateTime.now(),
      );

      provider.addMessage(message);

      expect(provider.messages.length, 1);
      expect(provider.messages.first, message);
      expect(notified, isTrue);
    });

    test('removeMessage should remove a message and notify listeners', () {
      final provider = ChatProvider();
      bool notified = false;
      provider.addListener(() {
        notified = true;
      });

      final message = ChatMessage(
        id: '1',
        text: 'Test message',
        senderId: 'user1',
        timestamp: DateTime.now(),
      );

      provider.addMessage(message);
      provider.removeMessage(message);

      expect(provider.messages, isEmpty);
      expect(notified, isTrue);
    });
  });
}
