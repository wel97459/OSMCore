import 'package:flutter/material.dart';
import 'package:chat_template/models/chat_message.dart';
import 'package:chat_template/widgets/message_bubble.dart';

class MessageList extends StatelessWidget {
  final List<ChatMessage> messages;
  final String currentUserId;
  final ScrollController? scrollController;

  const MessageList({
    super.key,
    required this.messages,
    required this.currentUserId,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return MessageBubble(
          message: message,
          isMe: message.senderId == currentUserId,
        );
      },
    );
  }
}
