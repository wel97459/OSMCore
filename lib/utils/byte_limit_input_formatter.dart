import 'package:flutter/services.dart';
import 'byte_counter.dart';

class ByteLimitInputFormatter extends TextInputFormatter {
  final int maxBytes;

  ByteLimitInputFormatter(this.maxBytes);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (ByteCounter.countBytes(newValue.text) <= maxBytes) {
      return newValue;
    }

    // If new value exceeds limit, truncate it.
    final truncatedText = ByteCounter.truncateToByteLimit(newValue.text, maxBytes);
    
    // We need to adjust the selection as well, though truncateToByteLimit 
    // usually removes from the end, if the user was typing in the middle 
    // it might be tricky. But for a simple chat input, usually they type at the end.
    
    // Simplest is to keep the selection within bounds.
    return TextEditingValue(
      text: truncatedText,
      selection: TextSelection.collapsed(offset: truncatedText.length),
    );
  }
}
