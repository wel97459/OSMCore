import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chat_template/utils/avatar_utils.dart';

void main() {
  group('AvatarUtils', () {
    test('getColorFromString should return consistent color for same string', () {
      final color1 = AvatarUtils.getColorFromString('User1');
      final color2 = AvatarUtils.getColorFromString('User1');
      final color3 = AvatarUtils.getColorFromString('User2');

      expect(color1, equals(color2));
      expect(color1, isNot(equals(color3)));
    });

    test('getFirstEmoji should return the first emoji if present', () {
      expect(AvatarUtils.getFirstEmoji('Hello 😊 World'), '😊');
      expect(AvatarUtils.getFirstEmoji('🚀 Launch'), '🚀');
      expect(AvatarUtils.getFirstEmoji('No emoji here'), isNull);
    });

    test('getAvatarText should return first emoji if present', () {
      expect(AvatarUtils.getAvatarText('CoolCat 😺'), '😺');
    });

    test('getAvatarText should return first uppercase letter if no emoji', () {
      expect(AvatarUtils.getAvatarText('coolcat'), 'C');
      expect(AvatarUtils.getAvatarText('  winston  '), 'W');
    });

    test('getAvatarText should return ? for empty or non-alphanumeric string without emoji', () {
      expect(AvatarUtils.getAvatarText(''), '?');
      expect(AvatarUtils.getAvatarText('   '), '?');
      expect(AvatarUtils.getAvatarText('!!!'), '?');
    });
  });
}
