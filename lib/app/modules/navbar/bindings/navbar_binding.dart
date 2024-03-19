import 'package:get/get.dart';

import '../controller/navbar_controller.dart';

class NavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavbarController());
  }
}
