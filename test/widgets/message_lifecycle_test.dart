import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chat_template/screens/chat_screen.dart';
import 'package:chat_template/models/chat_message.dart';
import 'package:chat_template/database/db_service.dart';
import 'dart:io';

void main() {
  testWidgets('Message lifecycle: transitions through sending states to delivered', (WidgetTester tester) async {
    final dbName = 'lifecycle_test_db_${DateTime.now().microsecondsSinceEpoch}';
    final db = ChatDatabase();
    await db.init(dbName);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          chatDatabaseProvider.overrideWith((ref) => db),
        ],
        child: const MaterialApp(
          home: ChatScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // 1. Send a message
    await tester.enterText(find.byType(TextField), 'Lifecycle Test');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump(); // Initial state: sending

    expect(find.text('Sending '), findsOneWidget);

    // 2. Wait for first transition (attempt 1)
    bool foundAttempt1 = false;
    for (int i = 0; i < 50; i++) { // Wait up to 5 seconds (50 * 100ms)
      await tester.pump(const Duration(milliseconds: 100));
      if (find.text('Sending (attempt 2/3) ').evaluate().isNotEmpty) {
        foundAttempt1 = true;
        break;
      }
    }
    expect(foundAttempt1, isTrue, reason: 'Failed to transition to attempt 1');

    // 3. Wait for second transition (attempt 2)
    bool foundAttempt2 = false;
    for (int i = 0; i < 50; i++) {
      await tester.pump(const Duration(milliseconds: 100));
      if (find.text('Sending (attempt 3/3) ').evaluate().isNotEmpty) {
        foundAttempt2 = true;
        break;
      }
    }
    expect(foundAttempt2, isTrue, reason: 'Failed to transition to attempt 2');

    // 4. Wait for delivered
    bool foundDelivered = false;
    for (int i = 0; i < 50; i++) {
      await tester.pump(const Duration(milliseconds: 100));
      if (find.text('Delivered ').evaluate().isNotEmpty) {
        foundDelivered = true;
        break;
      }
    }
    expect(foundDelivered, isTrue, reason: 'Failed to transition to delivered');

    // Cleanup
    final dir = Directory(dbName);
    if (dir.existsSync()) {
      try { dir.deleteSync(recursive: true); } catch(_) {}
    }
  }, timeout: const Timeout(Duration(seconds: 30)));
}
