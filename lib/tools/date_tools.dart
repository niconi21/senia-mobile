import 'package:intl/date_symbol_data_local.dart';

import 'package:intl/intl.dart';

class DateTools {
  static String getDate(DateTime date) {
    initializeDateFormatting();
    Intl.defaultLocale = 'es';
    final DateFormat formatter = DateFormat('MMMM d, yyyy hh:mm:s a');
    return formatter.format(date);
  }
}
