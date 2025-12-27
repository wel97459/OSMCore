import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chat_template/widgets/message_bubble.dart';
import 'package:chat_template/models/chat_message.dart';

void main() {
  testWidgets('MessageBubble shows red background and white text when status is failed', (WidgetTester tester) async {
    final message = ChatMessage(
      id: '1',
      text: 'Failed Message',
      senderId: 'user1',
      timestamp: DateTime.now(),
      status: MessageStatus.failed,
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(
          body: MessageBubble(
            message: message,
            isMe: true,
          ),
        ),
      ),
    );

    // Find the Container that acts as the bubble
    final containerFinder = find.byType(Container).first;
    final container = tester.widget<Container>(containerFinder);
    final decoration = container.decoration as BoxDecoration;

    // Check background color (should be theme.colorScheme.error)
    final BuildContext context = tester.element(containerFinder);
    final theme = Theme.of(context);
    expect(decoration.color, theme.colorScheme.error);

    // Check text color (should be theme.colorScheme.onError)
    final text = tester.widget<Text>(find.text('Failed Message'));
    expect(text.style?.color, theme.colorScheme.onError);

    // Check status text color
    final statusText = tester.widget<Text>(find.text('Failed '));
    expect(statusText.style?.color, theme.colorScheme.onError);
  });

  testWidgets('MessageBubble calls onRetry when tapped and status is failed', (WidgetTester tester) async {
    bool retryCalled = false;
    final message = ChatMessage(
      id: '1',
      text: 'Failed Message',
      senderId: 'user1',
      timestamp: DateTime.now(),
      status: MessageStatus.failed,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MessageBubble(
            message: message,
            isMe: true,
            onRetry: () => retryCalled = true,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Failed Message'));
    await tester.pump();

    expect(retryCalled, isTrue);
  });
}
