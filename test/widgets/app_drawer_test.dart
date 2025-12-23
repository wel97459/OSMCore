import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chat_template/widgets/app_drawer.dart';

void main() {
  testWidgets('AppDrawer should display all scenario items', (WidgetTester tester) async {
    String? selectedScenario;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          drawer: AppDrawer(
            onScenarioSelected: (scenario) => selectedScenario = scenario,
          ),
        ),
      ),
    );

    // Open drawer
    final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    expect(find.text('Group Chat'), findsOneWidget);
    expect(find.text('Direct Chat (Direct)'), findsOneWidget);
    expect(find.text('Direct Chat (Flood)'), findsOneWidget);
    expect(find.text('Direct Chat (3 Hops)'), findsOneWidget);

    // Tap an item
    await tester.tap(find.text('Direct Chat (Flood)'));
    await tester.pumpAndSettle();

    expect(selectedScenario, 'direct_flood');
  });
}
