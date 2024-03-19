import 'package:get/get.dart';
import 'package:shopperz/app/modules/cart/controller/cart_controller.dart';
import 'package:shopperz/app/modules/home/controller/brand_controller.dart';
import 'package:shopperz/app/modules/home/controller/category_controller.dart';
import 'package:shopperz/app/modules/home/controller/flash_sale_controller.dart';
import 'package:shopperz/app/modules/home/controller/product_section_controller.dart';
import 'package:shopperz/app/modules/home/controller/promotion_controller.dart';
import 'package:shopperz/app/modules/home/controller/slider_controller.dart';
import 'package:shopperz/app/modules/wishlist/controller/wishlist_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SliderController());
    Get.lazyPut(() => CategoryController());
    Get.lazyPut(() => ProductSectionController());
    Get.lazyPut(() => PromotionalController());
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => WishlistController());
    Get.lazyPut(() => BrandController());
    Get.lazyPut(() => FlashSaleControlelr());
  }
}
