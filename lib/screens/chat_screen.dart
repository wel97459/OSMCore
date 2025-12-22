import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:chat_template/providers/chat_provider.dart';
import 'package:chat_template/widgets/message_list.dart';
import 'package:chat_template/widgets/chat_input.dart';
import 'package:chat_template/widgets/message_options_sheet.dart';
import 'package:chat_template/models/chat_message.dart';

class ChatScreen extends StatefulWidget {
  static const String currentUserId = 'user1';

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Template'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: 'Simulate Receive',
            onPressed: () {
              final newMessage = ChatMessage(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                text: 'This is a received message!',
                senderId: 'user2',
                timestamp: DateTime.now(),
              );
              context.read<ChatProvider>().addMessage(newMessage);
            },
          ),
        ],
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
