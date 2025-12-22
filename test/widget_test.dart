import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:chat_template/providers/chat_provider.dart';
import 'package:chat_template/screens/chat_screen.dart';

void main() {
  testWidgets('ChatApp starts with ChatScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ChatProvider(),
        child: const MaterialApp(
          home: ChatScreen(),
        ),
      ),
    );
    expect(find.byType(ChatScreen), findsOneWidget);
  });
}
