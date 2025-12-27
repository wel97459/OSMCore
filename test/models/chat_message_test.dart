import 'package:flutter_test/flutter_test.dart';
import 'package:chat_template/models/chat_message.dart';

void main() {
  group('ChatMessage', () {
    test('should have correct properties initialized', () {
      final timestamp = DateTime.now();
      final message = ChatMessage(
        id: '1',
        text: 'Hello',
        senderId: 'user1',
        timestamp: timestamp,
        status: MessageStatus.delivered,
      );

      expect(message.id, '1');
      expect(message.text, 'Hello');
      expect(message.senderId, 'user1');
      expect(message.timestamp, timestamp);
      expect(message.status, MessageStatus.delivered);
    });

    test('should default status to sending if not provided', () {
      final message = ChatMessage(
        id: '2',
        text: 'Hi',
        senderId: 'user2',
        timestamp: DateTime.now(),
      );

      expect(message.status, MessageStatus.sending);
    });

    test('should support failed status', () {
      final message = ChatMessage(
        id: '3',
        text: 'Failed Message',
        senderId: 'user1',
        timestamp: DateTime.now(),
        status: MessageStatus.failed,
      );

            expect(message.status, MessageStatus.failed);

          });

      

          test('should support serialization to/from JSON', () {

            final timestamp = DateTime(2025, 12, 26, 15, 0);

            final message = ChatMessage(

              id: '4',

              text: 'Json Test',

              senderId: 'user1',

              senderName: 'Winston',

              timestamp: timestamp,

              status: MessageStatus.delivered,

              attempt: 2,

            );

      

            final json = message.toJson();

            expect(json['id'], '4');

            expect(json['text'], 'Json Test');

            expect(json['senderId'], 'user1');

            expect(json['senderName'], 'Winston');

            expect(json['timestamp'], timestamp.toIso8601String());

            expect(json['status'], 'delivered');

            expect(json['attempt'], 2);

      

            final fromJson = ChatMessage.fromJson(json);

            expect(fromJson.id, message.id);

            expect(fromJson.text, message.text);

            expect(fromJson.senderId, message.senderId);

            expect(fromJson.senderName, message.senderName);

            expect(fromJson.timestamp, message.timestamp);

            expect(fromJson.status, message.status);

            expect(fromJson.attempt, message.attempt);

          });

        });

      }

      