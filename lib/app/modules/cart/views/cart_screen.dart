import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/auth/controller/auth_controler.dart';
import 'package:shopperz/app/modules/auth/views/sign_in.dart';
import 'package:shopperz/app/modules/cart/controller/cart_controller.dart';
import 'package:shopperz/app/modules/cart/widgets/cart_item.dart';
import 'package:shopperz/app/modules/product_details/controller/product_details_controller.dart';
import 'package:shopperz/app/modules/shipping/views/shipping_information_screen.dart';
import 'package:shopperz/main.dart';
import 'package:shopperz/utils/images.dart';
import 'package:shopperz/widgets/devider.dart';
import 'package:shopperz/widgets/primary_button.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../widgets/custom_snackbar.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cartController = Get.put(CartController());

  final authController = Get.put(AuthController());

  final productDetailsController = Get.put(ProductDetailsController());

  @override
  void dispose() {
    productDetailsController.resetProductState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.primaryBackgroundColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(48.h),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: Padding(
                padding: EdgeInsets.only(left: 16.w, top: 8.h, right: 16.w),
                child: Text(
                  "Shopping Cart".tr,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColor.textColor,
                  ),
                ),
              ),
              leadingWidth: double.infinity,
            ),
          ),
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(
                        () => cartController.cartItems.isEmpty
                            ? Padding(
                                padding: EdgeInsets.only(top: 60.h),
                                child: Center(
                                  child: Image.asset(
                                    AppImages.emptyIcon,
                                    height: 300.h,
                                    width: 300.w,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: cartController.cartItems.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final cartItem =
                                      cartController.cartItems[index];
                                  return Padding(
                                    padding: EdgeInsets.only(top: 16.h),
                                    child: Obx(
                                      () => CartWidget(
                                        productImage:
                                            cartItem.product.data!.image,
                                        title: cartItem.product.data!.name,
                                        finalVariation:
                                            cartItem.finalVariationString,
                                        currentPrice: cartItem
                                            .variationCurrencyPrice
                                            .toString(),
                                        discountPrice: cartItem
                                            .variationOldCurrencyPrice
                                            .toString(),
                                        decrement: () {
                                          cartController.decrementItem(
                                              cartController.cartItems[index]);
                                        },
                                        isOffer: cartItem.product.data!.isOffer,
                                        decrementIconvalue:
                                            cartController.totalItems,
                                        quantity: cartController
                                            .cartItems[index].quantity
                                            .toString(),
                                        increment: () {
                                          cartController.incrementItem(
                                              cartController.cartItems[index]);
                                        },
                                        remove: () {
                                          cartController.removeFromCart(
                                              cartController.cartItems[index]);
                                        },
                                        stock: cartItem.stock,
                                        incrementValue: cartItem.quantity.value,
                                      ),
                                    ),
                                  );
                                }),
                      ),
                      SizedBox(
                        height: 164.h,
                      )
                    ],
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const DeviderWidget(),
                      SizedBox(height: 16.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              text: 'Subtotal'.tr,
                              color: AppColor.textColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            Obx(
                              () => TextWidget(
                                text:
                                    '${authController.currency}${cartController.totalPrice.toStringAsFixed(2)}',
                                color: AppColor.textColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      InkWell(
                        onTap: () {
                          if (cartController.cartItems.isEmpty) {
                            customSnackbar(
                              "ERROR".tr,
                              "Your cart is empty",
                              AppColor.error,
                            );
                          } else {
                            Get.to(() => box.read("isLogedIn") != false
                                ? const ShippingInformationScreen()
                                : const SignInScreen());
                          }
                        },
                        child: const PrimaryButton(
                          text: 'Procced to Checkout',
                        ),
                      ),
                      SizedBox(height: 12.h),
                      TextWidget(
                        text:
                            'Shipping, Taxes & Discount Calculate at Checkout',
                        color: AppColor.textColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
