import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:chat_template/screens/chat_screen.dart';
import 'package:chat_template/providers/chat_provider.dart';
import 'package:chat_template/widgets/app_drawer.dart';
import 'package:chat_template/widgets/message_bubble.dart';

void main() {
  testWidgets('Navigation and isolation test', (WidgetTester tester) async {
    final chatProvider = ChatProvider();

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<ChatProvider>.value(
          value: chatProvider,
          child: const ChatScreen(),
        ),
      ),
    );

    // Initial state
    expect(find.text('User'), findsWidgets);

    // Helper to switch scenario
    Future<void> switchScenario(String name) async {
      final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold));
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();
      await tester.tap(find.text(name));
      await tester.pumpAndSettle();
    }

    // 1. Switch to Group Chat
    await switchScenario('Group Chat');
    expect(find.text('Channel Alpha'), findsWidgets);

    // Send message
    await tester.enterText(find.byType(TextField), 'Hello Group');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();
    expect(find.text('Hello Group'), findsWidgets);

    // 2. Switch to Direct Chat (Flood)
    await switchScenario('Direct Chat (Flood)');
    expect(find.text('Winston'), findsWidgets);
    expect(find.text('Path: Flood'), findsOneWidget);
    
    // Verify isolation (messages from Group Chat should not be here)
    expect(find.byType(MessageBubble), findsNothing);

    // Send message in Direct Chat
    await tester.enterText(find.byType(TextField), 'Hello Winston');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();
    expect(find.text('Hello Winston'), findsWidgets);

    // 3. Switch back to Group Chat
    await switchScenario('Group Chat');
    
    // Verify persistence and isolation
    expect(find.text('Hello Group'), findsWidgets);
    expect(find.text('Hello Winston'), findsNothing);
  });
}
