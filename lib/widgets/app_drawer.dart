import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chat_template/providers/chat_notifier.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  void _handleScenarioSelected(BuildContext context, WidgetRef ref, String scenarioId) {
    final notifier = ref.read(chatSessionProvider.notifier);
    notifier.setActiveConversation(scenarioId);

    // Initialize scenario metadata if not already set
    switch (scenarioId) {
      case 'group':
        notifier.setChatContext(
          isGroupChat: true,
          currentHandle: 'Public',
        );
        break;
      case 'direct_direct':
        notifier.setChatContext(
          isGroupChat: false,
          currentHandle: 'NU6O',
          connectionPath: 'Path: Direct',
        );
        break;
      case 'direct_flood':
        notifier.setChatContext(
          isGroupChat: false,
          isFlood: true,
          currentHandle: 'sard',
          connectionPath: 'Path: Flood',
        );
        break;
      case 'direct_3hops':
        notifier.setChatContext(
          isGroupChat: false,
          currentHandle: 'Test',
          connectionPath: 'Path: 3 Hops',
        );
        break;
    }

    Navigator.pop(context); // Close drawer
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
            ),
            child: Center(
              child: Text(
                'Test Scenarios',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Group Chat'),
            onTap: () => _handleScenarioSelected(context, ref, 'group'),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Direct Chat (Direct)'),
            onTap: () => _handleScenarioSelected(context, ref, 'direct_direct'),
          ),
          ListTile(
            leading: const Icon(Icons.waves),
            title: const Text('Direct Chat (Flood)'),
            onTap: () => _handleScenarioSelected(context, ref, 'direct_flood'),
          ),
          ListTile(
            leading: const Icon(Icons.reorder),
            title: const Text('Direct Chat (3 Hops)'),
            onTap: () => _handleScenarioSelected(context, ref, 'direct_3hops'),
          ),
        ],
      ),
    );
  }
}