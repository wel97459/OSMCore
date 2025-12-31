import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestPage extends ConsumerWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: ListTile(
          title: Text('OSMCore', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          subtitle: Text('Testing', style: TextStyle(fontSize: 14)),
        ),
      ),
      body: Center(
        child: Text('Nothing to see here yet!'),
      ),
    );
  }
}
