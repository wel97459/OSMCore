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

    // 1. Initial State (default)
    expect(find.text('User'), findsWidgets);

    // 2. Switch to Group Chat via Drawer
    final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Group Chat'));
    await tester.pumpAndSettle();

    expect(find.text('Channel Alpha'), findsWidgets);
    expect(find.text('Channel Messages'), findsOneWidget);

    // Send a message in Group Chat
    await tester.enterText(find.byType(TextField), 'Hello Group');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();
    
    // Check for message bubble text
    expect(find.text('Hello Group'), findsWidgets);

    // 3. Switch to Direct Flood via Drawer
    final scaffoldState2 = tester.state<ScaffoldState>(find.byType(Scaffold));
    scaffoldState2.openDrawer();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Direct Chat (Flood)'));
    await tester.pumpAndSettle();

    expect(find.text('Winston'), findsWidgets);
    expect(find.text('Path: Flood'), findsOneWidget);
    
    // Verify isolation - 'Hello Group' should not be visible in this session
    expect(find.byType(MessageBubble), findsNothing);

    // Send a message in Direct Chat
    await tester.enterText(find.byType(TextField), 'Hello Winston');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();
    expect(find.text('Hello Winston'), findsWidgets);

    // 4. Switch back to Group Chat
    final scaffoldState3 = tester.state<ScaffoldState>(find.byType(Scaffold));
    scaffoldState3.openDrawer();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Group Chat'));
    await tester.pumpAndSettle();

    // Verify persistence of Group Chat messages
    // We use find.text with findsWidgets because the text might be in the list
    expect(find.text('Hello Group'), findsWidgets);
    expect(find.text('Hello Winston'), findsNothing);
  });
}