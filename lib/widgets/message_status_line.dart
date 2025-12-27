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
    final isFailed = status == MessageStatus.failed;
    final color = isFailed ? theme.colorScheme.onError : theme.colorScheme.onSurfaceVariant;
    
    String text;
    IconData icon;

    switch (status) {
      case MessageStatus.sending:
        text = 'Sending ';
        icon = Icons.pending;
        break;
      case MessageStatus.sending_attempt1:
        text = 'Sending (attempt 2/5) ';
        icon = Icons.pending;
        break;
      case MessageStatus.sending_attempt2:
        text = 'Sending (attempt 3/5) ';
        icon = Icons.pending;
        break;
      case MessageStatus.sending_attempt3:
        text = 'Sending (attempt 4/5) ';
        icon = Icons.pending;
        break;
      case MessageStatus.sending_attempt4:
        text = 'Sending (attempt 5/5) ';
        icon = Icons.pending;
        break;
      case MessageStatus.sending_flood_attempt1:
        text = 'Sending (attempt 2/3) ';
        icon = Icons.pending;
        break;
      case MessageStatus.sending_flood_attempt2:
        text = 'Sending (attempt 3/3) ';
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
