import 'package:get/get.dart';

import '../controller/language_controller.dart';

class LanguageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LanguageController());
  }
}
