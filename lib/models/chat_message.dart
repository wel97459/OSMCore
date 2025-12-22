enum MessageStatus {
  sent,
  delivered,
  read,
}

class ChatMessage {
  final String id;
  final String text;
  final String senderId;
  final DateTime timestamp;
  final MessageStatus status;

  ChatMessage({
    required this.id,
    required this.text,
    required this.senderId,
    required this.timestamp,
    this.status = MessageStatus.sent,
  });
}
