import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:grimoire/core/errors/catcher.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:intl/intl.dart';

class DateUtil {
  static String formatDate(String dateString) {
    try {
      if (dateString.isEmpty) return '';
      if (kDebugMode) print('locale : ${Get.deviceLocale?.toString()}');
      initializeDateFormatting(Get.deviceLocale?.toString() ?? 'en_ID', null);
      var dateFormat = DateFormat.yMMMMd(Get.deviceLocale?.toString());
      return dateFormat.format(DateTime.parse(dateString));
    } catch (e) {
      Catcher.captureException(e);
      return dateString;
    }
  }
}
