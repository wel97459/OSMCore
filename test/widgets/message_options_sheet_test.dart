import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chat_template/widgets/message_options_sheet.dart';
import 'package:chat_template/models/chat_message.dart';

void main() {
  testWidgets('MessageOptionsSheet displays message text and options', (WidgetTester tester) async {
    final message = ChatMessage(
      id: '1',
      text: 'Options test',
      senderId: 'user1',
      timestamp: DateTime.now(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MessageOptionsSheet(
            message: message,
            isMe: true,
            onDelete: () {},
            onCopy: () {},
          ),
        ),
      ),
    );

    expect(find.text('Options test'), findsOneWidget);
    expect(find.text('Delete message'), findsOneWidget);
    expect(find.text('Copy text'), findsOneWidget);
  });
}
