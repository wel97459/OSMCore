import 'package:flutter/material.dart';

class AvatarUtils {
  /// Generates a deterministic color based on the provided string.
  static Color getColorFromString(String text) {
    var hash = 0;
    for (var i = 0; i < text.length; i++) {
      hash = text.codeUnitAt(i) + ((hash << 5) - hash);
    }
    
    final r = (hash & 0xFF0000) >> 16;
    final g = (hash & 0x00FF00) >> 8;
    final b = hash & 0x0000FF;
    
    // Ensure the color is not too dark or too light
    // We can use HSL to adjust brightness if needed, but for now simple RGB is fine.
    return Color.fromARGB(255, r, g, b);
  }

  /// Extracts the first emoji from a string if present.
  static String? getFirstEmoji(String text) {
    for (var char in text.characters) {
      if (_isEmoji(char)) return char;
    }
    return null;
  }

  static bool _isEmoji(String char) {
    if (char.isEmpty) return false;
    final rune = char.runes.first;
    // Common emoji ranges
    return (rune >= 0x1F300 && rune <= 0x1F9FF) || 
           (rune >= 0x1F600 && rune <= 0x1F64F) ||
           (rune >= 0x1F680 && rune <= 0x1F6FF) ||
           (rune >= 0x2600 && rune <= 0x26FF) ||
           (rune >= 0x2700 && rune <= 0x27BF) ||
           (rune >= 0xFE00 && rune <= 0xFE0F) ||
           (rune >= 0x1F1E6 && rune <= 0x1F1FF);
  }

  /// Returns the text to display in the avatar: the first emoji or the first letter.
  static String getAvatarText(String text) {
    final emoji = getFirstEmoji(text);
    if (emoji != null) return emoji;

    final trimmed = text.trim();
    if (trimmed.isEmpty) return '?';

    // Find first alphanumeric character
    for (var char in trimmed.characters) {
      if (RegExp(r'[a-zA-Z0-9]').hasMatch(char)) {
        return char.toUpperCase();
      }
    }

    return '?';
  }
}