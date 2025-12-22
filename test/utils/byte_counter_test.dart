import 'package:flutter_test/flutter_test.dart';
import 'package:chat_template/utils/byte_counter.dart';

void main() {
  group('ByteCounter', () {
    test('countBytes returns 0 for empty string', () {
      expect(ByteCounter.countBytes(''), 0);
    });

    test('countBytes returns correct count for ASCII characters', () {
      expect(ByteCounter.countBytes('Hello'), 5);
    });

    test('countBytes returns correct count for multi-byte characters', () {
      // 'é' is 2 bytes in UTF-8
      expect(ByteCounter.countBytes('Café'), 5);
    });

    test('countBytes returns correct count for emojis', () {
      // '😊' is 4 bytes in UTF-8
      expect(ByteCounter.countBytes('😊'), 4);
    });

    test('truncateToByteLimit returns original string if within limit', () {
      expect(ByteCounter.truncateToByteLimit('Hello', 10), 'Hello');
    });

    test('truncateToByteLimit truncates string to limit', () {
      expect(ByteCounter.truncateToByteLimit('Hello World', 5), 'Hello');
    });

    test('truncateToByteLimit handles multi-byte characters correctly when truncating', () {
      // 'Café' is 5 bytes. Truncating to 4 bytes should return 'Caf'
      expect(ByteCounter.truncateToByteLimit('Café', 4), 'Caf');
    });

    test('truncateToByteLimit does not split multi-byte characters', () {
      // '😊' is 4 bytes. Truncating to 3 bytes should return empty string or previous characters
      expect(ByteCounter.truncateToByteLimit('Hi😊', 3), 'Hi');
      expect(ByteCounter.truncateToByteLimit('Hi😊', 5), 'Hi');
    });
  });
}
