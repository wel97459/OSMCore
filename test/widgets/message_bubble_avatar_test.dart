import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chat_template/widgets/message_bubble.dart';
import 'package:chat_template/models/chat_message.dart';
import 'package:chat_template/widgets/user_avatar.dart';

void main() {
  final message = ChatMessage(
    id: '1',
    text: 'Hello',
    senderId: 'user1',
    senderName: 'Winston',
    timestamp: DateTime.now(),
  );

  group('MessageBubble updates', () {
    testWidgets('should NOT show avatar for sent messages', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageBubble(
              message: message,
              isMe: true,
              showAvatar: true, // Even if requested, sent messages don't show avatar
            ),
          ),
        ),
      );

      expect(find.byType(UserAvatar), findsNothing);
    });

    testWidgets('should show avatar for received messages when showAvatar is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageBubble(
              message: message,
              isMe: false,
              showAvatar: true,
            ),
          ),
        ),
      );

      expect(find.byType(UserAvatar), findsOneWidget);
    });

    testWidgets('should NOT show avatar for received messages when showAvatar is false', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageBubble(
              message: message,
              isMe: false,
              showAvatar: false,
            ),
          ),
        ),
      );

      expect(find.byType(UserAvatar), findsNothing);
    });
  });
}
