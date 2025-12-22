import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_template/providers/chat_provider.dart';
import 'package:chat_template/widgets/message_list.dart';
import 'package:chat_template/widgets/chat_input.dart';
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
