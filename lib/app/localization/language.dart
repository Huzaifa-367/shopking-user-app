import 'package:get/get.dart';
import 'package:shopperz/app/localization/arabic.dart';
import 'package:shopperz/app/localization/bangla.dart';
import 'package:shopperz/app/localization/english.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': english,
        'ar': arabic,
        'bn': bangla,
      };
}
