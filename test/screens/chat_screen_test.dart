import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:chat_template/screens/chat_screen.dart';
import 'package:chat_template/providers/chat_provider.dart';
import 'package:chat_template/widgets/message_list.dart';
import 'package:chat_template/widgets/chat_input.dart';

void main() {
  testWidgets('ChatScreen shows MessageList and ChatInput', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ChatProvider(),
        child: const MaterialApp(
          home: ChatScreen(),
        ),
      ),
    );

    expect(find.byType(MessageList), findsOneWidget);
    expect(find.byType(ChatInput), findsOneWidget);
  });

  testWidgets('Sending a message from ChatScreen adds it to the list', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ChatProvider(),
        child: const MaterialApp(
          home: ChatScreen(),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Hello Screen');
    await tester.pump();
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();

    expect(find.text('Hello Screen'), findsOneWidget);
  });
}
