import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final Function(String) onScenarioSelected;

  const AppDrawer({
    super.key,
    required this.onScenarioSelected,
  });

  @override
  Widget build(BuildContext context) {
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
            onTap: () => onScenarioSelected('group'),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Direct Chat (Direct)'),
            onTap: () => onScenarioSelected('direct_direct'),
          ),
          ListTile(
            leading: const Icon(Icons.waves),
            title: const Text('Direct Chat (Flood)'),
            onTap: () => onScenarioSelected('direct_flood'),
          ),
          ListTile(
            leading: const Icon(Icons.reorder),
            title: const Text('Direct Chat (3 Hops)'),
            onTap: () => onScenarioSelected('direct_3hops'),
          ),
        ],
      ),
    );
  }
}
