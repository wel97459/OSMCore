import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_template/providers/chat_provider.dart';
import 'package:chat_template/widgets/message_list.dart';
import 'package:chat_template/widgets/chat_input.dart';
import 'package:chat_template/models/chat_message.dart';

class ChatScreen extends StatelessWidget {
  static const String currentUserId = 'user1';

  const ChatScreen({super.key});

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
                return MessageList(
                  messages: chatProvider.messages,
                  currentUserId: currentUserId,
                );
              },
            ),
          ),
          ChatInput(
            onSend: (text) {
              final newMessage = ChatMessage(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                text: text,
                senderId: currentUserId,
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
