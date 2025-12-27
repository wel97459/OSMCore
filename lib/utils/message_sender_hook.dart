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
    final sendingMessages = chatState.messages.where((m) => m.status == MessageStatus.sending || m.status == MessageStatus.sent).toList();

    for (final message in sendingMessages) {
      _processSending(notifier, message, chatState.isGroupChat, chatState.isFlood);
    }

    return null;
  }, [chatState.messages.length]);
}

Future<void> _processSending(ChatSession notifier, ChatMessage message, bool isGroup, bool isFlood) async {
  // Simulate delay
  await Future.delayed(const Duration(seconds: 2));

  if (isGroup) {
    // Group logic: sent -> heard 1
    await notifier.updateMessageStatus(message.id, MessageStatus.heard, attempt: 1);
  } else if(isFlood) {
    // Direct logic: sending -> flood attempt 1 -> flood attempt 2 -> delivered
    await notifier.updateMessageStatus(message.id, MessageStatus.sendingFloodAttempt, attempt: 2);
    await Future.delayed(const Duration(seconds: 2));
    await notifier.updateMessageStatus(message.id, MessageStatus.sendingFloodAttempt, attempt: 3);
    await Future.delayed(const Duration(seconds: 2));
    await notifier.updateMessageStatus(message.id, MessageStatus.delivered);
  } else {
    await notifier.updateMessageStatus(message.id, MessageStatus.sendingAttempt, attempt: 2);
    await Future.delayed(const Duration(seconds: 2));
    await notifier.updateMessageStatus(message.id, MessageStatus.sendingAttempt, attempt: 3);
    await Future.delayed(const Duration(seconds: 2));
    await notifier.updateMessageStatus(message.id, MessageStatus.sendingAttempt, attempt: 4);
    await Future.delayed(const Duration(seconds: 2));
    await notifier.updateMessageStatus(message.id, MessageStatus.sendingAttempt, attempt: 5);
    await Future.delayed(const Duration(seconds: 2));
    await notifier.updateMessageStatus(message.id, MessageStatus.failed);
  }
}
