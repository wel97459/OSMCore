import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chat_template/widgets/chat_input.dart';

void main() {
  testWidgets('ChatInput calls onSend and clears text', (WidgetTester tester) async {
    String? sentText;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChatInput(
            onSend: (text) => sentText = text,
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Hello');
    await tester.pump(); // Ensure _onTextChanged is called and UI updates
    await tester.tap(find.byType(IconButton));
    await tester.pump();

    expect(sentText, 'Hello');
    expect(find.text('Hello'), findsNothing); // Should be cleared
  });

  testWidgets('ChatInput send button is disabled when text is empty', (WidgetTester tester) async {
    // This depends on implementation, let's see.
  });
}
