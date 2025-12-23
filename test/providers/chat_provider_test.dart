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

    test('should update chat context and notify listeners', () {
      final provider = ChatProvider();
      bool notified = false;
      provider.addListener(() {
        notified = true;
      });

      provider.setChatContext(
        isGroupChat: true,
        connectionPath: 'Path: Flood',
        currentHandle: 'Test Channel',
      );

      expect(provider.isGroupChat, isTrue);
      expect(provider.connectionPath, 'Path: Flood');
      expect(provider.currentHandle, 'Test Channel');
      expect(notified, isTrue);
    });

    test('should support multiple independent conversations', () {
      final provider = ChatProvider();
      
      // Setup conversation 1
      provider.setActiveConversation('conv1');
      provider.setChatContext(currentHandle: 'User 1', isGroupChat: false);
      provider.addMessage(ChatMessage(id: '1', text: 'Msg 1', senderId: 'u1', timestamp: DateTime.now()));

      // Setup conversation 2
      provider.setActiveConversation('conv2');
      provider.setChatContext(currentHandle: 'User 2', isGroupChat: true);
      provider.addMessage(ChatMessage(id: '2', text: 'Msg 2', senderId: 'u2', timestamp: DateTime.now()));

      // Check isolation
      provider.setActiveConversation('conv1');
      expect(provider.currentHandle, 'User 1');
      expect(provider.messages.length, 1);
      expect(provider.messages.first.text, 'Msg 1');

      provider.setActiveConversation('conv2');
      expect(provider.currentHandle, 'User 2');
      expect(provider.messages.length, 1);
      expect(provider.messages.first.text, 'Msg 2');
    });
  });
}
