import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:intl/intl.dart' as intl;
import 'package:intl/date_symbol_data_local.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

class TimeFormat {
  static formatAgo(context, DateTime date, {bool allowFromNow = false}) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    if (isRTL)
      timeago.setLocaleMessages('ar', timeago.ArMessages());
    else
      timeago.setLocaleMessages('fr_short', timeago.FrShortMessages());
    return timeago
        .format(
          date,
          locale: isRTL ? 'ar' : 'fr_short',
          allowFromNow: allowFromNow,
        )
        .capitalize();
  }

  static format(context, DateTime date) {
    initializeDateFormatting();
    final locale =
        Directionality.of(context) == TextDirection.rtl ? 'ar_DZ' : 'fr_FR';

    final dateFormat = intl.DateFormat.yMMMMd(locale);

    final timeFormat = new intl.DateFormat.Hm(locale);

    return (dateFormat.format(date) + " - " + timeFormat.format(date))
        .replaceAll('٠', '0')
        .replaceAll('١', '1')
        .replaceAll('٢', '2')
        .replaceAll('٣', '3')
        .replaceAll('٤', '4')
        .replaceAll('٥', '5')
        .replaceAll('٦', '6')
        .replaceAll('٧', '7')
        .replaceAll('٨', '8')
        .replaceAll('٩', '9');
  }
}

enum Months { Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec }
