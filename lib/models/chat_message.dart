enum MessageStatus {
  sending,
  sending_attempt1,
  sending_attempt2,
  sending_attempt3,
  sending_attempt4,
  sending_flood_attempt1,
  sending_flood_attempt2,
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

  ChatMessage({
    required this.id,
    required this.text,
    required this.senderId,
    this.senderName = "User",
    required this.timestamp,
    this.status = MessageStatus.sending,
  });

  ChatMessage copyWith({
    String? id,
    String? text,
    String? senderId,
    String? senderName,
    DateTime? timestamp,
    MessageStatus? status,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
    );
  }
}
