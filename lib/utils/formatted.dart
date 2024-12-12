import 'package:flutter_datetime_format/flutter_datetime_format.dart';
import 'package:intl/intl.dart';

class Formatted {
  static String formatDate(DateTime date) {
    return FLDateTime.formatWithNames(date, 'DD MMMM YYYY');
  }
  static String formatTime(String time) {
    final DateFormat inputFormat = DateFormat('HH:mm:ss');
    final DateFormat outputFormat = DateFormat('HH:mm');
    final DateTime dateTime = inputFormat.parse(time);
    return outputFormat.format(dateTime);
  }
}

