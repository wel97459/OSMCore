import 'package:intl/intl.dart';

String formatMessageDate(DateTime date) {
  return DateFormat('d MMM HH:mm').format(date);
}
