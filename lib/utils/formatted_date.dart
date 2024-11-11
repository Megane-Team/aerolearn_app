import 'package:flutter_datetime_format/flutter_datetime_format.dart';

class FormattedDate {
  static String formatDate(DateTime date) {
    return FLDateTime.formatWithNames(date, 'DD MMMM YYYY');
  }
}
