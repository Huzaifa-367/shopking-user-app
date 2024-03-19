import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopperz/app/modules/auth/views/sign_in.dart';
import 'package:shopperz/app/modules/cart/controller/cart_controller.dart';
import 'package:shopperz/app/modules/coupon/widgets/coupon.dart';
import 'package:shopperz/main.dart';
import 'package:shopperz/widgets/textwidget.dart';
import '../../../../config/theme/app_color.dart';
import '../controller/coupon_controller.dart';

class ApplyCouponScreen extends StatefulWidget {
  const ApplyCouponScreen({super.key});

  @override
  State<ApplyCouponScreen> createState() => _ApplyCouponScreenState();
}

class _ApplyCouponScreenState extends State<ApplyCouponScreen> {
  final couponController = Get.put(CouponController());
  final cartController = Get.find<CartController>();

  @override
  void dispose() {
    couponController.couponTextController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r)),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: 'Enter Code'.tr,
                  color: AppColor.textColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Stack(
                  children: [
                    Form(
                      key: couponController.couponFormKey,
                      child: Container(
                        height: 44.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                              color: AppColor.borderColor, width: 1.r),
                        ),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: couponController.couponTextController,
                          validator: (couponField) {
                            if (couponField == null || couponField.isEmpty) {
                              return "Please enter a valid coupon".tr;
                            }
                            return null;
                          },
                          style: GoogleFonts.urbanist(
                              color: AppColor.textColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.urbanist(
                                color: AppColor.textColor1,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400),
                            hintText: 'Promo, Coupon or Voucher'.tr,
                            filled: true,
                            suffix: Padding(
                              padding: EdgeInsets.only(right: 70.w),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10.h),
                            fillColor: AppColor.whiteColor,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: InkWell(
                        onTap: () {
                          if (box.read("isLogedIn") == false) {
                            Get.off(() => const SignInScreen());
                          }
                          if (couponController.couponFormKey.currentState!
                              .validate()) {
                            couponController.submitCoupon(
                                code:
                                    couponController.couponTextController.text,
                                total: cartController.totalPrice.toString());
                            Get.back();
                          }
                        },
                        child: Container(
                          height: 44.h,
                          width: 75.w,
                          decoration: BoxDecoration(
                            color: AppColor.applyCouponColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8.r),
                              bottomRight: Radius.circular(8.r),
                            ),
                          ),
                          child: Center(
                            child: Obx(
                              () => couponController.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : TextWidget(
                                      text: 'Apply'.tr,
                                      color: AppColor.whiteColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24.h,
                ),
                TextWidget(
                  text: 'Coupon & Vouchers for you'.tr,
                  color: AppColor.textColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Obx(
                  () => ListView.builder(
                    itemCount:
                        couponController.couponModel.value.data?.length ?? 0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final coupon = couponController.couponModel.value.data;
                      couponController.discountPrice.value =
                          coupon![index].convertDiscount.toString();
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: Obx(
                          () => couponController.isLoading.value
                              ? const CircularProgressIndicator()
                              : CouponWidget(
                                  name: coupon[index].name,
                                  description: coupon[index].description,
                                  startDate: coupon[index].convertStartDate,
                                  endDate: coupon[index].convertEndDate,
                                  onTap: () {
                                    if (box.read("isLogedIn") == false) {
                                      Get.off(() => const SignInScreen());
                                    }
                                    couponController.setCoupon(
                                        coupon[index].code.toString());

                                    couponController.couponTextController.text =
                                        couponController.couponCode.value;
                                    couponController.discountPrice.value =
                                        coupon[index]
                                            .convertDiscount
                                            .toString();
                                  },
                                ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
