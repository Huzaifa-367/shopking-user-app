import 'package:get/get.dart';

import '../controller/category_wise_product_controller.dart';

class CategoryWiseProductBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryWiseProductController());
  }
}
