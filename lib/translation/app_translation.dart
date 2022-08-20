import 'intl_en.dart';
import 'intl_id.dart';
import 'package:get/get.dart';

/*
https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPInternational/LanguageandLocaleIDs/LanguageandLocaleIDs.html
https://www.ibabbleon.com/iOS-Language-Codes-ISO-639.html
*/
class AppTranslation extends Translations {

  //feedback page
  static const String pageTitle = "pageTitle";
  static const String title = "title";
  static const String description = "description";
  static const String feedbackCategory = "feedbackCategory";
  static const String actualBehaviour = "actualBehaviour";
  static const String expectedBehaviour = "expectedBehaviour";
  static const String errorFeedback = "errorFeedback";
  static const String submit = "submit";

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enTranslation,
        'id_ID': idTranslation,
      };
}
