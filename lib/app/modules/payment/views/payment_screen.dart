import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/auth/controller/auth_controler.dart';
import 'package:shopperz/app/modules/payment/controller/payment_controller.dart';
import 'package:shopperz/app/modules/payment/widgets/payment.dart';
import 'package:shopperz/app/modules/profile/controller/profile_controller.dart';
import 'package:shopperz/app/modules/shipping/controller/show_address_controller.dart';
import 'package:shopperz/widgets/appbar3.dart';
import 'package:shopperz/widgets/custom_snackbar.dart';
import 'package:shopperz/widgets/devider.dart';
import 'package:shopperz/widgets/loader/loader.dart';
import 'package:shopperz/widgets/textwidget.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../main.dart';
import '../../../../utils/svg_icon.dart';
import '../../cart/controller/cart_controller.dart';
import '../../coupon/controller/coupon_controller.dart';
import '../../coupon/views/apply_coupon_screen.dart';
import '../../shipping/widgets/order_summary.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen(this.isDelivery, {super.key});
  final bool? isDelivery;
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool paymentSelected = false;

  final cartController = Get.find<CartController>();
    final couponController = Get.put(CouponController());
    final paymentController = Get.put(PaymentControllr());
    final showAddressController = Get.find<ShowAddressController>();
    final authController = Get.put(AuthController());
    final profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    paymentController.fetchPaymentMethods();
    profileController.getProfile();
    paymentController.paymentMethodIndex.value = -1;
  }

  
  openCoupon() {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const ApplyCouponScreen(),
      ),
    );
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
      child: Stack(
        alignment: Alignment.center,
        children: [
          Scaffold(
            backgroundColor: AppColor.primaryBackgroundColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(48.h),
              child: AppBarWidget3(text: 'Payment Information'.tr),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 26.h, left: 16.w, right: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'Select Payment Method'.tr,
                      color: AppColor.textColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Obx(
                      () => paymentController.paymentModel.value.data == null
                          ? const SizedBox()
                          : 
                          StaggeredGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.h,
                        crossAxisSpacing: 10.w,
                        children: [
                          for (int i = 0; i < paymentController.paymentModel.value.data!.length; i++)
                          GestureDetector(
                                  onTap: () {
                                    paymentController.paymentMethodIndex.value = i;
                              
                                    paymentController.paymentMethodId.value = paymentController.paymentModel.value.data![i].id!;
                                    
                                  },
                                  child: Obx(
                                    () => PaymentWidget(
                                      name: paymentController.paymentModel.value.data![i].name,
                                      image: paymentController.paymentModel.value.data![i].image,
                                      selected: paymentController
                                                  .paymentMethodIndex.value == i
                                          ? true
                                          : false,
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    const DeviderWidget(),
                    SizedBox(
                      height: 24.h,
                    ),
                    InkWell(
                      onTap: () {
                        openCoupon();
                      },
                      child: Obx(
                        () => Container(
                          height: 67.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                                color: AppColor.blueBorderColor, width: 1.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.r),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        SvgIcon.coupon,
                                        height: 24.h,
                                        width: 24.h,
                                      ),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          couponController
                                                      .applyCouponStatus.value ==
                                                  false
                                              ? TextWidget(
                                                  text:
                                                      'Apply Promo, Coupon or Voucher'
                                                          .tr,
                                                  color: AppColor.blueBorderColor,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                )
                                              :
                                              TextWidget(
                                                  text: 'Coupon Applied'.tr,
                                                  color: AppColor.greenColor,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          couponController
                                                      .applyCouponStatus.value ==
                                                  false
                                              ? TextWidget(
                                                  text:
                                                      'Get discount with your order'
                                                          .tr,
                                                  color: AppColor.textColor,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                )
                                              :
                                              TextWidget(
                                                  text: '${'You saved'.tr} ${authController.settingModel!.data!
                                        .siteDefaultCurrencySymbol
                                        .toString()}${couponController.applyCouponModel.value.data?.convertDiscount!.toStringAsFixed(int.parse(authController.settingModel!.data!.siteDigitAfterDecimalPoint.toString())) ?? 0}',
                                                  color: AppColor.textColor,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  couponController.applyCouponStatus.value == false
                                      ? SvgPicture.asset(
                                          SvgIcon.forwardCoupon,
                                          height: 24.h,
                                          width: 24.h,
                                        )
                                      :
                                      InkWell(
                                          onTap: () {
                                            box.write("applyCoupon", false);
                                            couponController.applyCouponStatus
                                                .value = box.read("applyCoupon");
                                          },
                                          child: SvgPicture.asset(
                                            SvgIcon.remove,
                                            height: 24.h,
                                            width: 24.h,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Obx(
                      () => OrderSummay(
                        subTotal: cartController.totalPrice,
                        tax: cartController.totalTax,
                        shippingCharge: widget.isDelivery == false
                            ? "0"
                            : (cartController.productShippingCharge +
                                    cartController.shippingAreaCost.value)
                                .toString(),
                        discount: couponController.applyCouponStatus.value == false
                            ? 0
                            : couponController
                                    .applyCouponModel.value.data?.convertDiscount ??
                                "0",
                        total: cartController.totalPrice > 0 &&
                                couponController.applyCouponStatus.value == true
                            ? ((cartController.totalPrice +
                                    cartController.totalTax +
                                    (widget.isDelivery == false
                                        ? 0
                                        : (cartController.productShippingCharge +
                                            cartController
                                                .shippingAreaCost.value))) -
                                (double.parse(couponController
                                    .applyCouponModel.value.data!.convertDiscount
                                    .toString())))
                            : (cartController.totalPrice +
                                    cartController.totalTax) +
                                (widget.isDelivery == false
                                    ? 0
                                    : (cartController.productShippingCharge +
                                        cartController.shippingAreaCost.value)),
                        buttonText: "Confirm Order".tr,
                        onTap: () async {

                          if (paymentController.paymentMethodIndex.value ==
                            -1) {
                          customSnackbar(
                              "ERROR".tr,
                              "Please select payment method.".tr,
                              AppColor.error);
                            }
                            else{
                          var confirmJsonData = cartController.cartItems.map((e) {
                            return {
                              "name": e.product.data!.name,
                              "product_id": e.product.data!.id!.toInt(),
                              "image": e.product.data!.image,
                              "variation_names": e.finalVariationString,
                              "variation_id": e.variationId.toInt(),
                              "sku": e.sku, 
                              "stock": e.stock,
                              "taxes": e.taxObject,
                              "shipping": e.shippingObject,
                              "quantity": e.quantity.value,
                              "discount": e.product.data!.discount,
                              "price": e.variationPrice,
                              "old_price": e.variationOldPrice,
                              "total_tax": e.totalProductTax,
                              "subtotal":
                                  ((double.parse(
                                                  e.variationPrice.toString()) *
                                              int.parse(
                                                  e.quantity.value.toString())) +
                                          double.parse(
                                              e.totalProductTax.toString()) +
                                          double.parse(e.shippingCharge)).toDouble() -
                                      double.parse(
                                          e.product.data!.discount.toString()),
                              "total":
                                  double.parse(e.variationPrice.toString()) *
                                      double.parse(e.quantity.value.toString()),
                              "total_price": ((double.parse(
                                                  e.variationPrice.toString()) *
                                              int.parse(
                                                  e.quantity.value.toString())) +
                                          double.parse(
                                              e.totalProductTax.toString()) +
                                          double.parse(e.shippingCharge)).toDouble() -
                                      double.parse(
                                          e.product.data!.discount.toString()),
                              
                            };
                          }).toList();
          
                          var data = jsonEncode(confirmJsonData);

                          if(paymentController.paymentModel.value.data![paymentController.paymentMethodIndex.value].id!.toInt() == 2)
                          {
                            if(profileController.accountBalance.value > (cartController.totalPrice > 0 && couponController.applyCouponStatus.value == true
                                  ? ((cartController.totalPrice + cartController.totalTax + (widget.isDelivery == false ? 0 : (cartController.productShippingCharge + cartController.shippingAreaCost.value))).toDouble() - (double.parse(couponController.applyCouponModel.value.data!.convertDiscount.toString())))
                                      
                                  : ((cartController.totalPrice +
                                              cartController.totalTax) +
                                          (widget.isDelivery == false
                                              ? 0
                                              : (cartController.productShippingCharge +
                                                  cartController
                                                      .shippingAreaCost.value)))))
                            {
                              paymentController.confirmOrder(
                            discount: couponController.applyCouponStatus.value == false
                            ? 0.toDouble()
                            : double.parse(couponController.applyCouponModel.value.data!.convertDiscount.toString()),
                              subTotal: cartController.totalPrice.toDouble(), 
                              shippingCharge: widget.isDelivery == false
                                  ? 0
                                  : (cartController.productShippingCharge +
                                          cartController.shippingAreaCost.value).toDouble(),
                              tax: cartController.totalTax,
                              total: cartController.totalPrice > 0 && couponController.applyCouponStatus.value == true
                                  ? ((cartController.totalPrice + cartController.totalTax + (widget.isDelivery == false ? 0 : (cartController.productShippingCharge + cartController.shippingAreaCost.value))).toDouble() - (double.parse(couponController.applyCouponModel.value.data!.convertDiscount.toString())))
                                      
                                  : ((cartController.totalPrice +
                                              cartController.totalTax) +
                                          (widget.isDelivery == false
                                              ? 0
                                              : (cartController.productShippingCharge +
                                                  cartController
                                                      .shippingAreaCost.value))),
                                      
                              shippingId: widget.isDelivery == true
                                  ? showAddressController
                                      .addressList
                                      .value
                                      .data![showAddressController.selectedAddressIndex.value]
                                      .id!.toInt()
                                  : 0,
                              billingId: widget.isDelivery == true
                                  ? showAddressController.billingAddressSelected.value == true
                                      ? showAddressController.addressList.value.data![showAddressController.selectedAddressIndex.value].id!.toInt()
                                      : showAddressController.addressList.value.data![showAddressController.selectedBillingAddressIndex.value].id!.toInt()
                                  : 0,
                              outletId: widget.isDelivery == false ? showAddressController.outlestModel.value.data![showAddressController.selectedOutletIndex.value].id!.toInt() : 0,
                              couponId: couponController.applyCouponModel.value.data?.id?.toInt() ?? 0,
                              orderType: widget.isDelivery == false ? 10 : 5,
                              source: 10.toInt(),
                              paymentMethod: paymentController.paymentModel.value.data![paymentController.paymentMethodIndex.value].id!.toInt(),
                              slug: paymentController.paymentModel.value.data![paymentController.paymentMethodIndex.value].slug.toString(), 
                              products: data.toString());
                            }
                            else
                            {
                              customSnackbar('ERROR'.tr, 'Insufficient balance', AppColor.error);
                            }
                          }
                          else
                          {
                            paymentController.confirmOrder(
                            discount: couponController.applyCouponStatus.value == false
                            ? 0.toDouble()
                            : double.parse(couponController.applyCouponModel.value.data!.convertDiscount.toString()),
                              subTotal: cartController.totalPrice.toDouble(), 
                              shippingCharge: widget.isDelivery == false
                                  ? 0
                                  : (cartController.productShippingCharge +
                                          cartController.shippingAreaCost.value).toDouble(),
                              tax: cartController.totalTax,
                              total: cartController.totalPrice > 0 && couponController.applyCouponStatus.value == true
                                  ? ((cartController.totalPrice + cartController.totalTax + (widget.isDelivery == false ? 0 : (cartController.productShippingCharge + cartController.shippingAreaCost.value))).toDouble() - (double.parse(couponController.applyCouponModel.value.data!.convertDiscount.toString())))
                                      
                                  : ((cartController.totalPrice +
                                              cartController.totalTax) +
                                          (widget.isDelivery == false
                                              ? 0
                                              : (cartController.productShippingCharge +
                                                  cartController
                                                      .shippingAreaCost.value))),
                                      
                              shippingId: widget.isDelivery == true
                                  ? showAddressController
                                      .addressList
                                      .value
                                      .data![showAddressController.selectedAddressIndex.value]
                                      .id!.toInt()
                                  : 0,
                              billingId: widget.isDelivery == true
                                  ? showAddressController.billingAddressSelected.value == true
                                      ? showAddressController.addressList.value.data![showAddressController.selectedAddressIndex.value].id!.toInt()
                                      : showAddressController.addressList.value.data![showAddressController.selectedBillingAddressIndex.value].id!.toInt()
                                  : 0,
                              outletId: widget.isDelivery == false ? showAddressController.outlestModel.value.data![showAddressController.selectedOutletIndex.value].id!.toInt() : 0,
                              couponId: couponController.applyCouponModel.value.data?.id?.toInt() ?? 0,
                              orderType: widget.isDelivery == false ? 10 : 5,
                              source: 10.toInt(),
                              paymentMethod: paymentController.paymentModel.value.data![paymentController.paymentMethodIndex.value].id!.toInt(),
                              slug: paymentController.paymentModel.value.data![paymentController.paymentMethodIndex.value].slug.toString(), 
                              products: data.toString());
                          }
                            }                  
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
          paymentController.isLoading.value ?
          const LoaderCircle() :const SizedBox()
        ],
      ),
    );
  }
}
