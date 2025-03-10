import 'package:intl/intl.dart';

class NumberFormatUtil {
  static String formatReal({required double value}) => NumberFormat.currency(
        locale: 'pt_BR',
        symbol: 'R\$',
        decimalDigits: 2,
      ).format(value);
}
