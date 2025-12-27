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
  });
}
