import 'package:flutter/material.dart';
import 'package:chat_template/models/chat_message.dart';

class MessageStatusLine extends StatelessWidget {
  final MessageStatus status;

  const MessageStatusLine({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onSurfaceVariant;
    
    String text;
    IconData icon;

    switch (status) {
      case MessageStatus.sent:
        text = 'Sent';
        icon = Icons.check;
        break;
      case MessageStatus.delivered:
        text = 'Delivered';
        icon = Icons.done_all;
        break;
      case MessageStatus.read:
        text = 'Read';
        icon = Icons.done_all;
        break;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: theme.textTheme.labelSmall?.copyWith(color: color),
        ),
        const SizedBox(width: 4),
        Icon(
          icon,
          size: 14,
          color: color,
        ),
      ],
    );
  }
}
