import 'package:get/get.dart';
import 'package:shopperz/app/modules/cart/controller/cart_controller.dart';

class CartControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());
  }
}
