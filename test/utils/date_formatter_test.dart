import 'package:flutter_test/flutter_test.dart';
import 'package:chat_template/utils/date_formatter.dart';

void main() {
  test('formatMessageDate returns correct format', () {
    // 21 Dec 2025 14:30
    final date = DateTime(2025, 12, 21, 14, 30);
    expect(formatMessageDate(date), '21 Dec 14:30');
  });

  test('formatMessageDate pads minutes correctly', () {
    // 5 Jan 2025 09:05
    final date = DateTime(2025, 1, 5, 9, 5);
    expect(formatMessageDate(date), '5 Jan 09:05');
  });
}
