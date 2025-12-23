import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:chat_template/screens/chat_screen.dart';
import 'package:chat_template/providers/chat_provider.dart';
import 'package:chat_template/widgets/user_avatar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  group('ChatScreen AppBar', () {
    testWidgets('should show direct chat UI in AppBar when NOT group chat', (WidgetTester tester) async {
      final chatProvider = ChatProvider();
      chatProvider.setChatContext(
        isGroupChat: false,
        connectionPath: 'Path: Direct',
        currentHandle: 'Winston',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<ChatProvider>.value(
            value: chatProvider,
            child: const ChatScreen(),
          ),
        ),
      );

      expect(find.text('Winston'), findsOneWidget);
      expect(find.text('Path: Direct'), findsOneWidget);
      expect(find.byType(UserAvatar), findsOneWidget);
      // Verify Font Awesome icon NOT shown in AppBar (UserAvatar should show letter/emoji)
      expect(find.byType(FaIcon), findsNothing);
    });

    testWidgets('should show group chat UI in AppBar when is group chat', (WidgetTester tester) async {
      final chatProvider = ChatProvider();
      chatProvider.setChatContext(
        isGroupChat: true,
        connectionPath: 'N/A',
        currentHandle: 'Channel Alpha',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<ChatProvider>.value(
            value: chatProvider,
            child: const ChatScreen(),
          ),
        ),
      );

      expect(find.text('Channel Alpha'), findsOneWidget);
      expect(find.text('Channel Messages'), findsOneWidget);
      // In group mode, AppBar should show FA Icon
      expect(find.byType(FaIcon), findsOneWidget);
    });
  });
}
