import 'package:intl/intl.dart';

class DateTimeUtil {
  static String formatPtBRDate({required dynamic date}) {
    try {
      String dateFormatted = '';
      DateTime? dateTime;

      if (date is String) {
        dateTime = DateTime.tryParse(date);
      }

      if (date is DateTime) {
        dateTime = date;
      }

      final format = DateFormat('dd/MM/y');
      dateFormatted = format.format(dateTime!);

      return dateFormatted;
    } catch (e) {
      return '';
    }
  }
}
