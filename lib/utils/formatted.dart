import 'package:intl/intl.dart';

class Formatted {
  static String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(date);
  }

  static String formatTime(String time) {
    final DateFormat inputFormat = DateFormat('HH:mm:ss');
    final DateFormat outputFormat = DateFormat('HH:mm');
    final DateTime dateTime = inputFormat.parse(time);
    return outputFormat.format(dateTime);
  }
}
