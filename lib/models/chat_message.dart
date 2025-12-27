enum MessageStatus {
  sending,
  sendingAttempt,
  sendingFloodAttempt,
  delivered,
  sent,
  heard,
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'senderId': senderId,
      'senderName': senderName,
      'timestamp': timestamp.toIso8601String(),
      'status': status.name,
      'attempt': attempt,
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      text: json['text'] as String,
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: MessageStatus.values.firstWhere((e) => e.name == json['status']),
      attempt: json['attempt'] as int? ?? 0,
    );
  }
}
