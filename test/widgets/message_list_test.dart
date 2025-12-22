import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chat_template/widgets/message_list.dart';
import 'package:chat_template/widgets/message_bubble.dart';
import 'package:chat_template/models/chat_message.dart';

void main() {
  testWidgets('MessageList displays all messages', (WidgetTester tester) async {
    final messages = [
      ChatMessage(id: '1', text: 'Msg 1', senderId: 'user1', timestamp: DateTime.now()),
      ChatMessage(id: '2', text: 'Msg 2', senderId: 'user2', timestamp: DateTime.now()),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MessageList(
            messages: messages,
            currentUserId: 'user1',
          ),
        ),
      ),
    );

    expect(find.byType(MessageBubble), findsNWidgets(2));
    expect(find.text('Msg 1'), findsOneWidget);
    expect(find.text('Msg 2'), findsOneWidget);
  });
}
