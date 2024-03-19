import 'package:get/get.dart';
import 'package:shopperz/app/modules/auth/controller/auth_controler.dart';
import 'package:shopperz/app/modules/cart/model/product_model.dart';
import 'package:shopperz/app/modules/shipping/controller/show_address_controller.dart';
import '../model/cart_model.dart';

class CartController extends GetxController {
  final showAddressController = Get.put(ShowAddressController());
  final authController = Get.put(AuthController());
  final cartItems = <CartModel>[].obs;
  final numOfItems = 1.obs;
  final quantityTax = 0.0.obs;
  final taxRate = 0.0.obs;
  double productShippingCharge = 0.0;
  String shippingMethod = "0";
  final shippingAreaCost = 0.0.obs;
  double totalIndividualProductTax = 0.0;
  double flatRateShippingCost = 0.0;
  double multiplyShippingAmount = 0.0;

  @override
  onInit() {
    authController.getSetting();
    super.onInit();
  }

  decrement() {
    if (numOfItems.value > 1) {
      numOfItems.value--;
    }
  }

  void addItem(
      {required ProductModel product,
      int? variationId,
      String? shippingAmount,
      String? finalVariation,
      String? sku,
      dynamic taxJson,
      dynamic stock,
      dynamic shipping,
      double? totalTax,
      double? totalPrice,
      dynamic productVariationPrice,
      dynamic productVariationOldPrice,
      dynamic productVariationCurrencyPrice,
      dynamic productVariationOldCurrencyPrice,
      int? variationStock,
      String? flatShippingCost}) {
    for (var item in cartItems) {
      if (item.product.data?.id == product.data?.id &&
          item.variationId == variationId) {
        item.quantity.value += numOfItems.value;
        return;
      }
    }

    cartItems.add(
      CartModel(
          product: product,
          variationId: variationId ?? 0,
          quantity: numOfItems.value,
          shippingCharge: shippingAmount ?? "0",
          finalVariationString: finalVariation ?? "null",
          sku: sku ?? "null",
          taxObject: taxJson,
          stock: stock,
          variationPrice: productVariationPrice,
          variationOldPrice: productVariationOldPrice,
          variationCurrencyPrice: productVariationCurrencyPrice,
          variationOldCurrencyPrice: productVariationOldCurrencyPrice,
          shippingObject: shipping,
          totalProductTax: totalTax,
          flatShippingCharge: flatShippingCost,
          variationStock: variationStock),
    );
  }

  void incrementItem(CartModel cartItem) {
    if (cartItem.variationStock!.toInt() > cartItem.quantity.value) {
      cartItem.quantity.value++;
      incrementShippingCharge(cartItem);
    } else {}
  }

  void decrementItem(CartModel cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity.value--;
      decrementShippingCharge(cartItem);
    }
  }

  int getQuantityForProduct(ProductModel product) {
    int quantity = 0;

    for (CartModel cartItem in cartItems) {
      if (cartItem.product.data?.id == product.data?.id) {
        quantity = cartItem.quantity.value;
        break;
      }
    }
    return quantity;
  }

  void removeFromCart(CartModel cartModel) {
    cartItems.remove(cartModel);
    quantityTax.value = 0.0;
    removeProductWiseShippingCharge(cartModel);
  }

  int get totalItems {
    return cartItems.fold(0, (sum, item) => sum + item.quantity.value);
  }

  double get totalPrice {
    final totalPrice = 0.0.obs;
    for (var item in cartItems) {
      totalPrice.value +=
          (item.quantity * double.parse(item.variationPrice.toString()));
    }
    return totalPrice.value;
  }

  double get totalTax {
    double tTax = 0.0;
    for (var item in cartItems) {
      tTax += ((item.quantity * double.parse(item.variationPrice.toString())) /
              100) *
          item.totalProductTax!.toDouble();
    }
    return tTax;
  }

  calculateShippingCharge(
      {required String shippingMethodStatus,
      String? shippingType,
      String? isProductQntyMultiply,
      String? flatShippingCharge}) {
    productShippingCharge = 0;
    for (var item in cartItems) {
      if (shippingMethodStatus == "5") {
        shippingMethod = "5";
        if (item.product.data?.shipping?.shippingType == 10 &&
            item.product.data?.shipping?.isProductQuantityMultiply == 5) {
          productShippingCharge +=
              double.parse(item.shippingCharge) * item.quantity.value;
        }
        if (item.product.data?.shipping?.shippingType == 5) {}
        if (item.product.data?.shipping?.shippingType == 10 &&
            item.product.data?.shipping?.isProductQuantityMultiply == 10) {
          productShippingCharge += double.parse(item.shippingCharge);
        }
      }
      if (shippingMethodStatus == "10") {
        shippingMethod = "10";

        productShippingCharge +=
            double.parse(item.flatShippingCharge.toString());
      }
      if (shippingMethodStatus == "15") {
        shippingMethod = "15";
      }
    }
  }

  areaWiseShippingCal() {
    if (shippingMethod == "15") {
      final selectedAddress = showAddressController.addressList.value.data?[
          showAddressController.selectedAddressIndex.value == -1
              ? 0
              : showAddressController.selectedAddressIndex.value];

      for (var area in showAddressController.areaShippingModel.value.data!) {
        if (selectedAddress!.country!.contains(area.country!) &&
            selectedAddress.state!.contains(area.state!) &&
            selectedAddress.city!.contains(area.city!)) {
          shippingAreaCost.value =
              double.parse(area.shippingCost?.toString() ?? "0");
          break;
        } else {
          shippingAreaCost.value = 0;
          shippingAreaCost.value = double.parse(authController
                  .settingModel?.data?.shippingSetupAreaWiseDefaultCost
                  .toString() ??
              "0");
        }
      }
    }
  }

  removeProductWiseShippingCharge(CartModel cartModel) {
    if (shippingMethod == "5") {
      if (cartModel.product.data?.shipping?.shippingType == 10 &&
          cartModel.product.data?.shipping?.isProductQuantityMultiply == 5) {
        productShippingCharge -=
            double.parse(cartModel.shippingCharge) * cartModel.quantity.value;
      }
      if (cartModel.product.data?.shipping?.shippingType == 5) {}
      if (cartModel.product.data?.shipping?.shippingType == 10 &&
          cartModel.product.data?.shipping?.isProductQuantityMultiply == 10) {
        productShippingCharge -= double.parse(cartModel.shippingCharge);
      }
    }
    if (shippingMethod == "10") {
      productShippingCharge -=
          double.parse(cartModel.flatShippingCharge.toString());
    }
  }

  incrementShippingCharge(CartModel cartModel) {
    if (shippingMethod == "5") {
      if (cartModel.product.data?.shipping?.shippingType == 10 &&
          cartModel.product.data?.shipping?.isProductQuantityMultiply == 5) {
        multiplyShippingAmount = double.parse(cartModel.shippingCharge);
        productShippingCharge += multiplyShippingAmount;
      }
      if (cartModel.product.data?.shipping?.shippingType == 5) {}
      if (cartModel.product.data?.shipping?.shippingType == 10 &&
          cartModel.product.data?.shipping?.isProductQuantityMultiply == 10) {}
    }
    if (shippingMethod == "10") {}
  }

  decrementShippingCharge(CartModel cartModel) {
    if (shippingMethod == "5") {
      if (cartModel.product.data?.shipping?.shippingType == 10 &&
          cartModel.product.data?.shipping?.isProductQuantityMultiply == 5) {
        productShippingCharge -= double.parse(cartModel.shippingCharge);
      }
      if (cartModel.product.data?.shipping?.shippingType == 5) {}
      if (cartModel.product.data?.shipping?.shippingType == 10 &&
          cartModel.product.data?.shipping?.isProductQuantityMultiply == 10) {}
    }
    if (shippingMethod == "10") {}
  }
}
