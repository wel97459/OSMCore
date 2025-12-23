import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chat_template/widgets/user_avatar.dart';
import 'package:chat_template/utils/avatar_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  group('UserAvatar', () {
    testWidgets('should display first letter if no emoji', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserAvatar(handle: 'Winston'),
          ),
        ),
      );

      expect(find.text('W'), findsOneWidget);
      
      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, AvatarUtils.getColorFromString('Winston'));
    });

    testWidgets('should display emoji if present', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserAvatar(handle: 'CoolCat 😺'),
          ),
        ),
      );

      expect(find.text('😺'), findsOneWidget);
    });

    testWidgets('should display Font Awesome icon if iconData is provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserAvatar(
              handle: 'Channel',
              iconData: FontAwesomeIcons.lightbulb,
            ),
          ),
        ),
      );

      expect(find.byType(FaIcon), findsOneWidget);
      expect(find.text('C'), findsNothing); // Icon should take precedence or handle should be ignored for content
    });
   group('deterministic color', () {
      testWidgets('should have same color for same handle', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  UserAvatar(handle: 'Same'),
                  UserAvatar(handle: 'Same'),
                ],
              ),
            ),
          ),
        );

        final avatars = tester.widgetList<Container>(find.byType(Container));
        final color1 = (avatars.elementAt(0).decoration as BoxDecoration).color;
        final color2 = (avatars.elementAt(1).decoration as BoxDecoration).color;
        expect(color1, equals(color2));
      });
    });
  });
}
