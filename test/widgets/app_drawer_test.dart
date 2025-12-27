import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chat_template/widgets/app_drawer.dart';
import 'package:chat_template/providers/chat_notifier.dart';
import 'package:chat_template/providers/chat_state.dart';

void main() {
  testWidgets('AppDrawer should display all scenario items and update state', (WidgetTester tester) async {
    ChatState? capturedState;

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            drawer: const AppDrawer(),
            body: Consumer(
              builder: (context, ref, child) {
                capturedState = ref.watch(chatSessionProvider);
                return const Text('Body');
              },
            ),
          ),
        ),
      ),
    );

    // Open drawer
    final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    // Tap an item
    await tester.tap(find.text('Direct Chat (Flood)'));
    await tester.pumpAndSettle();

    // Verify state updated via consumer
    expect(capturedState?.activeConversationId, 'direct_flood');
    expect(capturedState?.connectionPath, 'Path: Flood');
  });
}
