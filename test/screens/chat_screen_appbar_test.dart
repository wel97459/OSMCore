import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chat_template/screens/chat_screen.dart';
import 'package:chat_template/providers/chat_notifier.dart';
import 'package:chat_template/widgets/user_avatar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  group('ChatScreen AppBar', () {
    testWidgets('should show direct chat UI in AppBar when NOT group chat', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            chatSessionProvider.overrideWith(() {
              final notifier = ChatSession();
              // We can't easily call methods on notifier before build is done in overrideWith
              // unless we use a provider that we can initialize.
              return notifier;
            }),
          ],
          child: const MaterialApp(
            home: ChatScreen(),
          ),
        ),
      );

      // Alternative: Use the default container and update state after pump
      final element = tester.element(find.byType(ChatScreen));
      final container = ProviderScope.containerOf(element);
      
      container.read(chatSessionProvider.notifier).setChatContext(
        isGroupChat: false,
        connectionPath: 'Path: Direct',
        currentHandle: 'Winston',
      );
      await tester.pump();

      expect(find.text('Winston'), findsOneWidget);
      expect(find.text('Path: Direct'), findsOneWidget);
      expect(find.byType(UserAvatar), findsOneWidget);
      expect(find.byType(FaIcon), findsNothing);
    });

    testWidgets('should show group chat UI in AppBar when is group chat', (WidgetTester tester) async {
       await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ChatScreen(),
          ),
        ),
      );

      final element = tester.element(find.byType(ChatScreen));
      final container = ProviderScope.containerOf(element);
      
      container.read(chatSessionProvider.notifier).setChatContext(
        isGroupChat: true,
        connectionPath: 'N/A',
        currentHandle: 'Channel Alpha',
      );
      await tester.pump();

      expect(find.text('Channel Alpha'), findsOneWidget);
      expect(find.text('Channel Messages'), findsOneWidget);
      expect(find.byType(FaIcon), findsOneWidget);
    });
  });
}