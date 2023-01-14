import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateUtil {
  static String formatDate(String dateString) {
    if (dateString.isEmpty) return '';
    if (kDebugMode) print('locale : ${Get.deviceLocale?.toString()}');
    var dateFormat = DateFormat.yMMMMd(Get.deviceLocale?.toString());
    return dateFormat.format(DateTime.parse(dateString));
  }
}
