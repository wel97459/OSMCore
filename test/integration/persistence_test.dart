import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chat_template/providers/chat_notifier.dart';
import 'package:chat_template/database/db_service.dart';
import 'package:chat_template/models/chat_message.dart';
import 'dart:io';

void main() {
  late String dbName;

  setUp(() {
    dbName = 'integration_test_db_${DateTime.now().microsecondsSinceEpoch}';
  });

  tearDown(() {
    final dir = Directory(dbName);
    if (dir.existsSync()) {
      try { dir.deleteSync(recursive: true); } catch(_) {}
    }
  });

  test('ChatSession should persist and load messages from ReaxDB', () async {
    final db = ChatDatabase();
    await db.init(dbName);

    final container = ProviderContainer(
      overrides: [
        chatDatabaseProvider.overrideWith((ref) => db),
      ],
    );
    addTearDown(container.dispose);

    final notifier = container.read(chatSessionProvider.notifier);
    
    // 1. Add a message
    final msg = ChatMessage(
      id: 'p1',
      text: 'Persist Me',
      senderId: 'u1',
      timestamp: DateTime.now(),
    );
    await notifier.addMessage(msg);

    // Verify in current state
    expect(container.read(chatSessionProvider).messages.length, 1);

    // 2. Create a new container to simulate app restart
    final db2 = ChatDatabase();
    await db2.init(dbName);

    final container2 = ProviderContainer(
      overrides: [
        chatDatabaseProvider.overrideWith((ref) => db2),
      ],
    );
    addTearDown(container2.dispose);

    final notifier2 = container2.read(chatSessionProvider.notifier);
    await notifier2.loadFromDatabase();

    final state2 = container2.read(chatSessionProvider);
    expect(state2.messages.length, 1);
    expect(state2.messages.first.text, 'Persist Me');
  });
}
