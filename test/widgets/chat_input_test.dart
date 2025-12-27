import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chat_template/widgets/chat_input.dart';

void main() {
  testWidgets('ChatInput calls onSend and clears text', (WidgetTester tester) async {
    String? sentText;
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: ChatInput(
              onSend: (text) => sentText = text,
            ),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Hello');
    await tester.pump(); 
    await tester.tap(find.byType(IconButton));
    await tester.pump();

    expect(sentText, 'Hello');
    expect(find.text('Hello'), findsNothing); // Should be cleared
  });

  testWidgets('ChatInput send button is disabled when text is empty', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: ChatInput(
              onSend: (_) {},
            ),
          ),
        ),
      ),
    );

    final sendButton = tester.widget<IconButton>(find.byType(IconButton));
    expect(sendButton.onPressed, isNull);

    await tester.enterText(find.byType(TextField), '  ');
    await tester.pump();
    
    final sendButtonAfterEmpty = tester.widget<IconButton>(find.byType(IconButton));
    expect(sendButtonAfterEmpty.onPressed, isNull);
  });
}