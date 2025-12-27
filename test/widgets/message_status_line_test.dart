import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chat_template/widgets/message_status_line.dart';
import 'package:chat_template/models/chat_message.dart';

void main() {
  testWidgets('MessageStatusLine displays Sending status correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MessageStatusLine(status: MessageStatus.sending),
        ),
      ),
    );

    expect(find.text('Sending '), findsOneWidget);
    expect(find.byIcon(Icons.pending), findsOneWidget);
  });

  testWidgets('MessageStatusLine displays Delivered status correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MessageStatusLine(status: MessageStatus.delivered),
        ),
      ),
    );

    expect(find.text('Delivered '), findsOneWidget);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
  });

  testWidgets('MessageStatusLine displays Failed status correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MessageStatusLine(status: MessageStatus.failed),
        ),
      ),
    );

    expect(find.text('Failed '), findsOneWidget);
    expect(find.byIcon(Icons.error), findsOneWidget);
  });
}