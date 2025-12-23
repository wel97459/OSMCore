import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:chat_template/providers/chat_provider.dart';
import 'package:chat_template/widgets/message_list.dart';
import 'package:chat_template/widgets/chat_input.dart';
import 'package:chat_template/widgets/message_options_sheet.dart';
import 'package:chat_template/models/chat_message.dart';

import 'package:chat_template/widgets/user_avatar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:chat_template/widgets/app_drawer.dart';

class ChatScreen extends StatefulWidget {
  static const String currentUserId = 'user1';

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();

  void _handleScenarioSelected(String scenarioId) {
    final provider = context.read<ChatProvider>();
    provider.setActiveConversation(scenarioId);

    // Initialize scenario metadata if not already set
    switch (scenarioId) {
      case 'group':
        provider.setChatContext(
          isGroupChat: true,
          currentHandle: 'Public',
        );
        break;
      case 'direct_direct':
        provider.setChatContext(
          isGroupChat: false,
          currentHandle: 'NU6O',
          connectionPath: 'Path: Direct',
        );
        break;
      case 'direct_flood':
        provider.setChatContext(
          isGroupChat: false,
          currentHandle: 'sard',
          connectionPath: 'Path: Flood',
        );
        break;
      case 'direct_3hops':
        provider.setChatContext(
          isGroupChat: false,
          currentHandle: 'Test',
          connectionPath: 'Path: 3 Hops',
        );
        break;
    }

    Navigator.pop(context); // Close drawer
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _showOptionsSheet(ChatMessage message) {
    showModalBottomSheet(
      context: context,
      builder: (context) => MessageOptionsSheet(
        message: message,
        isMe: message.senderId == ChatScreen.currentUserId,
        onDelete: () {
          context.read<ChatProvider>().removeMessage(message);
          Navigator.pop(context);
        },
        onCopy: () {
          Clipboard.setData(ClipboardData(text: message.text)).then((_) {
            if (mounted) {
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chatProvider = context.watch<ChatProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            UserAvatar(
              handle: chatProvider.currentHandle,
              iconData: chatProvider.isGroupChat ? FontAwesomeIcons.peopleGroup : null,
              size: 36,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    chatProvider.currentHandle,
                    style: theme.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    chatProvider.isGroupChat ? "Channel Messages" : chatProvider.connectionPath,
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
                senderName: chatProvider.isGroupChat ? 'Baddie' : chatProvider.currentHandle,
                timestamp: DateTime.now(),
              );
              context.read<ChatProvider>().addMessage(newMessage);
            },
          ),
        ],
      ),
      drawer: AppDrawer(
        onScenarioSelected: _handleScenarioSelected,
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, chatProvider, child) {
                // Scroll to bottom after the widget is built with new messages
                WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

                return MessageList(
                  messages: chatProvider.messages,
                  currentUserId: ChatScreen.currentUserId,
                  showAvatars: chatProvider.isGroupChat,
                  scrollController: _scrollController,
                  onMessageLongPress: _showOptionsSheet,
                );
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
              );
              context.read<ChatProvider>().addMessage(newMessage);
            },
          ),
        ],
      ),
    );
  }
}
