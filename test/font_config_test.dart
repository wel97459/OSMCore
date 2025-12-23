import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:chat_template/main.dart';
import 'package:chat_template/providers/chat_provider.dart';

void main() {
  testWidgets('ChatApp theme includes NotoColorEmoji in fontFamilyFallback and Roboto as primary', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ChatProvider()),
        ],
        child: const ChatApp(),
      ),
    );
    
    await tester.pumpAndSettle();
    
    // Get context from a widget INSIDE the MaterialApp
    final BuildContext context = tester.element(find.byType(Scaffold).first);
    final ThemeData theme = Theme.of(context);
    
    // Check primary font
    expect(theme.textTheme.bodyLarge?.fontFamily, 'Roboto');
    
    // Check fallback
    expect(theme.textTheme.bodyLarge?.fontFamilyFallback, contains('NotoColorEmoji'));
    expect(theme.textTheme.bodyMedium?.fontFamilyFallback, contains('NotoColorEmoji'));
    expect(theme.textTheme.labelSmall?.fontFamilyFallback, contains('NotoColorEmoji'));
  });
}
