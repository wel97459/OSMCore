import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chat_template/widgets/chat_input.dart';

void main() {
  testWidgets('ChatInput limits input to 140 bytes', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: ChatInput(onSend: (_) {}),
          ),
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
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: ChatInput(onSend: (_) {}),
          ),
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
    expect(textField.controller?.text, thirtyFiveEmojis);
  });

  testWidgets('ChatInput displays byte counter', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: ChatInput(onSend: (_) {}),
          ),
        ),
      ),
    );

    // Initial state
    expect(find.text('0/140 bytes'), findsOneWidget);

    // Type some text
    await tester.enterText(find.byType(TextField), 'Hello');
    await tester.pump();
    expect(find.text('5/140 bytes'), findsOneWidget);

    // Type multi-byte characters
    await tester.enterText(find.byType(TextField), 'Café');
    await tester.pump();
    expect(find.text('5/140 bytes'), findsOneWidget); // 'Café' is 5 bytes

    // Type emoji
    await tester.enterText(find.byType(TextField), '😊');
    await tester.pump();
    expect(find.text('4/140 bytes'), findsOneWidget); // '😊' is 4 bytes
  });
}