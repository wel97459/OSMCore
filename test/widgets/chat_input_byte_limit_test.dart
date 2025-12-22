import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chat_template/widgets/chat_input.dart';

void main() {
  testWidgets('ChatInput limits input to 140 bytes', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChatInput(onSend: (_) {}),
        ),
      ),
    );

    // 140 'a's is 140 bytes
    final longText = 'a' * 150;
    await tester.enterText(find.byType(TextField), longText);
    await tester.pump();

    final textField = tester.widget<TextField>(find.byType(TextField));
    expect(textField.controller?.text.length, 140);
  });

  testWidgets('ChatInput handles emojis in byte limit correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChatInput(onSend: (_) {}),
        ),
      ),
    );

    // '😊' is 4 bytes. 35 emojis = 140 bytes.
    final thirtyFiveEmojis = '😊' * 35;
    final thirtySixEmojis = '😊' * 36;

    await tester.enterText(find.byType(TextField), thirtySixEmojis);
    await tester.pump();

    final textField = tester.widget<TextField>(find.byType(TextField));
    // It should be truncated to exactly 35 emojis.
    // Note: Emoji length in String might be 2 (surrogate pair).
    expect(textField.controller?.text, thirtyFiveEmojis);
  });
}
