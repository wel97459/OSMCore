import 'dart:async';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chat_template/models/chat_message.dart';
import 'package:chat_template/providers/chat_notifier.dart';

void useMessageSender(WidgetRef ref) {
  final chatState = ref.watch(chatSessionProvider);
  final notifier = ref.read(chatSessionProvider.notifier);

  useEffect(() {
    // Find messages in 'sending' status
    final sendingMessages = chatState.messages.where((m) => m.status == MessageStatus.sending).toList();

    for (final message in sendingMessages) {
      _processSending(notifier, message, chatState.isGroupChat);
    }
    return null;
  }, [chatState.messages.length]);
}

Future<void> _processSending(ChatSession notifier, ChatMessage message, bool isGroup) async {
  // Simulate delay
  await Future.delayed(const Duration(milliseconds: 100));

  if (isGroup) {
    // Group logic: sending -> attempt 1 -> attempt 2 -> delivered
    await notifier.updateMessageStatus(message.id, MessageStatus.sendingAttempt, attempt: 1);
    await Future.delayed(const Duration(milliseconds: 100));
    await notifier.updateMessageStatus(message.id, MessageStatus.sendingAttempt, attempt: 2);
    await Future.delayed(const Duration(milliseconds: 100));
    await notifier.updateMessageStatus(message.id, MessageStatus.delivered);
  } else {
    // Direct logic: sending -> flood attempt 1 -> flood attempt 2 -> delivered
    await notifier.updateMessageStatus(message.id, MessageStatus.sendingFloodAttempt, attempt: 1);
    await Future.delayed(const Duration(milliseconds: 100));
    await notifier.updateMessageStatus(message.id, MessageStatus.sendingFloodAttempt, attempt: 2);
    await Future.delayed(const Duration(milliseconds: 100));
    await notifier.updateMessageStatus(message.id, MessageStatus.delivered);
  }
}
