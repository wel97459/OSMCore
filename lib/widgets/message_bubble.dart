import 'package:flutter/material.dart';
import 'package:chat_template/models/chat_message.dart';
import 'package:chat_template/utils/date_formatter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isMe;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              color: isMe ? colorScheme.primaryContainer : colorScheme.surfaceVariant,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(isMe ? 16 : 0),
                bottomRight: Radius.circular(isMe ? 0 : 16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.text,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: isMe
                        ? colorScheme.onPrimaryContainer
                        : colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      formatMessageDate(message.timestamp),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: (isMe
                                ? colorScheme.onPrimaryContainer
                                : colorScheme.onSurfaceVariant)
                            .withOpacity(0.7),
                      ),
                    ),
                    if (isMe) ...[
                      const SizedBox(width: 4),
                      _getStatusIcon(colorScheme),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getStatusIcon(ColorScheme colorScheme) {
    IconData icon;
    Color color = colorScheme.onPrimaryContainer.withOpacity(0.7);

    switch (message.status) {
      case MessageStatus.sent:
        icon = Icons.check;
        break;
      case MessageStatus.delivered:
        icon = Icons.done_all;
        break;
      case MessageStatus.read:
        icon = Icons.done_all;
        color = colorScheme.primary;
        break;
    }

    return Icon(
      icon,
      size: 12,
      color: color,
    );
  }
}
