import 'package:get/get.dart';

import '../controller/category_tree_controller.dart';

class CategoryTreeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryTreeController());
  }
}
