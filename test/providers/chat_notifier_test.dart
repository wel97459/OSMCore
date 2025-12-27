import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chat_template/providers/chat_notifier.dart';
import 'package:chat_template/models/chat_message.dart';

void main() {
  group('ChatNotifier', () {
    test('should start with default conversation and empty messages', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(chatSessionProvider);
      
      expect(state.activeConversationId, 'default');
      expect(state.conversations.containsKey('default'), isTrue);
      expect(state.messages, isEmpty);
      expect(state.isGroupChat, isFalse);
    });

    test('addMessage should add a message to active conversation', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final message = ChatMessage(
        id: '1',
        text: 'Test message',
        senderId: 'user1',
        timestamp: DateTime.now(),
      );

      container.read(chatSessionProvider.notifier).addMessage(message);
      
      final state = container.read(chatSessionProvider);
      expect(state.messages.length, 1);
      expect(state.messages.first, message);
    });

    test('setActiveConversation should switch and create if missing', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(chatSessionProvider.notifier).setActiveConversation('conv1');
      
      final state = container.read(chatSessionProvider);
      expect(state.activeConversationId, 'conv1');
      expect(state.messages, isEmpty);
    });

    test('setChatContext should update active conversation metadata', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(chatSessionProvider.notifier).setChatContext(
        isGroupChat: true,
        connectionPath: 'Path: Flood',
        currentHandle: 'Test Channel',
      );
      
      final state = container.read(chatSessionProvider);
      expect(state.isGroupChat, isTrue);
      expect(state.connectionPath, 'Path: Flood');
      expect(state.currentHandle, 'Test Channel');
    });

    test('should support multiple independent conversations', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      
      final notifier = container.read(chatSessionProvider.notifier);

      // Setup conversation 1
      notifier.setActiveConversation('conv1');
      notifier.setChatContext(currentHandle: 'User 1', isGroupChat: false);
      notifier.addMessage(ChatMessage(id: '1', text: 'Msg 1', senderId: 'u1', timestamp: DateTime.now()));

      // Setup conversation 2
      notifier.setActiveConversation('conv2');
      notifier.setChatContext(currentHandle: 'User 2', isGroupChat: true);
      notifier.addMessage(ChatMessage(id: '2', text: 'Msg 2', senderId: 'u2', timestamp: DateTime.now()));

      // Check isolation
      notifier.setActiveConversation('conv1');
      var state = container.read(chatSessionProvider);
      expect(state.currentHandle, 'User 1');
      expect(state.messages.length, 1);
      expect(state.messages.first.text, 'Msg 1');

      notifier.setActiveConversation('conv2');
      state = container.read(chatSessionProvider);
      expect(state.currentHandle, 'User 2');
      expect(state.messages.length, 1);
      expect(state.messages.first.text, 'Msg 2');
    });

    test('retryMessage should update status from failed to sending', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      
      final notifier = container.read(chatSessionProvider.notifier);
      
      final failedMessage = ChatMessage(
        id: 'fail1',
        text: 'Failed',
        senderId: 'user1',
        timestamp: DateTime.now(),
        status: MessageStatus.failed,
      );

      notifier.addMessage(failedMessage);
      
      var state = container.read(chatSessionProvider);
      expect(state.messages.first.status, MessageStatus.failed);

      notifier.retryMessage(failedMessage);
      
      state = container.read(chatSessionProvider);
      expect(state.messages.first.status, MessageStatus.sending);
    });
  });
}
