import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chat_template/widgets/message_bubble.dart';
import 'package:chat_template/models/chat_message.dart';

void main() {
  testWidgets('MessageBubble displays message text', (WidgetTester tester) async {
    final message = ChatMessage(
      id: '1',
      text: 'Test message',
      senderId: 'user1',
      timestamp: DateTime.now(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MessageBubble(
            message: message,
            isMe: true,
          ),
        ),
      ),
    );

    expect(find.text('Test message'), findsOneWidget);
  });

  testWidgets('MessageBubble displays as receiver', (WidgetTester tester) async {
    final message = ChatMessage(
      id: '1',
      text: 'Hello from other',
      senderId: 'user2',
      timestamp: DateTime.now(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MessageBubble(
            message: message,
            isMe: false,
          ),
        ),
      ),
    );

    expect(find.text('Hello from other'), findsOneWidget);
  });

  testWidgets('MessageBubble displays status icon for me', (WidgetTester tester) async {
    final message = ChatMessage(
      id: '1',
      text: 'Status test',
      senderId: 'user1',
      timestamp: DateTime.now(),
      status: MessageStatus.read,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MessageBubble(
            message: message,
            isMe: true,
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.done_all), findsOneWidget);
  });

  testWidgets('MessageBubble displays full date timestamp', (WidgetTester tester) async {
    final message = ChatMessage(
      id: '1',
      text: 'Timestamp test',
      senderId: 'user1',
      timestamp: DateTime(2025, 12, 21, 14, 30),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MessageBubble(
            message: message,
            isMe: true,
          ),
        ),
      ),
    );

    expect(find.text('21 Dec 14:30'), findsOneWidget);
  });
}
