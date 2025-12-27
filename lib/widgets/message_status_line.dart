import 'package:flutter/material.dart';
import 'package:chat_template/models/chat_message.dart';

class MessageStatusLine extends StatelessWidget {
  final MessageStatus status;
  final int attempt;

  const MessageStatusLine({
    super.key,
    required this.status,
    required this.attempt,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isFailed = status == MessageStatus.failed;
    final color = isFailed ? theme.colorScheme.error : theme.colorScheme.onSurfaceVariant;
    
    String text;
    IconData icon;

    switch (status) {
      case MessageStatus.sending:
        text = 'Sending ';
        icon = Icons.pending;
        break;
      case MessageStatus.sendingAttempt:
        text = 'Sending (attempt $attempt/5) ';
        icon = Icons.pending;
        break;
      case MessageStatus.sendingFloodAttempt:
        text = 'Sending (attempt $attempt/5) ';
        icon = Icons.pending;
        break;
      case MessageStatus.delivered:
        text = 'Delivered ';
        icon = Icons.check_circle;
        break;
      case MessageStatus.failed:
        text = 'Failed ';
        icon = Icons.error;
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
