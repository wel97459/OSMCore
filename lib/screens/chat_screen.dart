import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:chat_template/providers/chat_notifier.dart';
import 'package:chat_template/widgets/message_list.dart';
import 'package:chat_template/widgets/chat_input.dart';
import 'package:chat_template/widgets/message_options_sheet.dart';
import 'package:chat_template/models/chat_message.dart';
import 'package:chat_template/widgets/user_avatar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chat_template/widgets/app_drawer.dart';
import 'package:chat_template/utils/message_sender_hook.dart';

class ChatScreen extends HookConsumerWidget {
  static const String currentUserId = 'user1';

  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final chatState = ref.watch(chatSessionProvider);
    final scrollController = useScrollController();

    useMessageSender(ref);

    void scrollToBottom() {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }

    // Scroll to bottom after the widget is built with new messages
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());
      return null;
    }, [chatState.messages.length]);

    void showOptionsSheet(ChatMessage message) {
      showModalBottomSheet(
        context: context,
        builder: (context) => MessageOptionsSheet(
          message: message,
          isMe: message.senderId == ChatScreen.currentUserId,
          onDelete: () {
            ref.read(chatSessionProvider.notifier).removeMessage(message);
            Navigator.pop(context);
          },
          onCopy: () {
            Clipboard.setData(ClipboardData(text: message.text)).then((_) {
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Copied to clipboard'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            });
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            UserAvatar(
              handle: chatState.currentHandle,
              iconData: chatState.isGroupChat ? FontAwesomeIcons.peopleGroup : null,
              size: 36,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    chatState.currentHandle,
                    style: theme.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    chatState.isGroupChat ? "Channel Messages" : chatState.connectionPath,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: 'Simulate Receive',
            onPressed: () {
              final newMessage = ChatMessage(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                text: 'This is a received message!',
                senderId: 'user2',
                senderName: chatState.isGroupChat ? 'Baddie' : chatState.currentHandle,
                timestamp: DateTime.now(),
              );
              ref.read(chatSessionProvider.notifier).addMessage(newMessage);
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Expanded(
            child: MessageList(
              messages: chatState.messages,
              currentUserId: ChatScreen.currentUserId,
              showAvatars: chatState.isGroupChat,
              scrollController: scrollController,
              onMessageLongPress: showOptionsSheet,
              onMessageRetry: (message) {
                ref.read(chatSessionProvider.notifier).retryMessage(message);
              },
            ),
          ),
          ChatInput(
            onSend: (text) {
              final newMessage = ChatMessage(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                text: text,
                senderId: ChatScreen.currentUserId,
                timestamp: DateTime.now(),
                status: MessageStatus.failed,
              );
              ref.read(chatSessionProvider.notifier).addMessage(newMessage);
            },
          ),
        ],
      ),
    );
  }
}
