import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chat_template/widgets/message_status_line.dart';
import 'package:chat_template/models/chat_message.dart';

void main() {
  testWidgets('MessageStatusLine displays Sent status correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MessageStatusLine(status: MessageStatus.sent),
        ),
      ),
    );

    expect(find.text('Sent'), findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);
  });

  testWidgets('MessageStatusLine displays Delivered status correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MessageStatusLine(status: MessageStatus.delivered),
        ),
      ),
    );

    expect(find.text('Delivered'), findsOneWidget);
    expect(find.byIcon(Icons.done_all), findsOneWidget);
  });

  testWidgets('MessageStatusLine displays Read status correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MessageStatusLine(status: MessageStatus.read),
        ),
      ),
    );

    expect(find.text('Read'), findsOneWidget);
    expect(find.byIcon(Icons.done_all), findsOneWidget);
  });
}
