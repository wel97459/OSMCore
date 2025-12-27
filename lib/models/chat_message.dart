enum MessageStatus {
  sending,
  sendingAttempt,
  sendingFloodAttempt,
  delivered,
  failed,
}

class ChatMessage {
  final String id;
  final String text;
  final String senderId;
  final String senderName;
  final DateTime timestamp;
  final MessageStatus status;
  final int attempt;

  ChatMessage({
    required this.id,
    required this.text,
    required this.senderId,
    this.senderName = "User",
    required this.timestamp,
    this.status = MessageStatus.sending,
    this.attempt = 0,
  });

  ChatMessage copyWith({
    String? id,
    String? text,
    String? senderId,
    String? senderName,
    DateTime? timestamp,
    MessageStatus? status,
    int? attempt,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      attempt: attempt ?? this.attempt,
    );
  }
}
