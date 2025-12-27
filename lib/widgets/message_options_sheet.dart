import 'package:flutter/material.dart';
import 'package:chat_template/models/chat_message.dart';
import 'package:chat_template/widgets/message_bubble.dart';

class MessageOptionsSheet extends StatelessWidget {
  final ChatMessage message;
  final bool isMe;
  final VoidCallback onDelete;
  final VoidCallback onCopy;

  const MessageOptionsSheet({
    super.key,
    required this.message,
    required this.isMe,
    required this.onDelete,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: MessageBubble(
              message: message,
              isMe: isMe,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.copy),
            title: const Text('Copy text'),
            onTap: onCopy,
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline, color: Colors.red),
            title: const Text('Delete message', style: TextStyle(color: Colors.red)),
            onTap: onDelete,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
