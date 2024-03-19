import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/auth/controller/auth_controler.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../widgets/devider.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/textwidget.dart';

class OrderSummay extends StatelessWidget {
  OrderSummay({
    super.key,
    this.subTotal,
    this.tax,
    this.shippingCharge,
    this.discount,
    this.total,
    this.onTap,
    this.buttonText,
  });

  final double? subTotal;
  final double? tax;
  final String? shippingCharge;
  final dynamic discount;
  final double? total;
  final void Function()? onTap;
  final String? buttonText;

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          boxShadow: [
            BoxShadow(
                color: AppColor.blackColor.withOpacity(0.04),
                offset: const Offset(0, 0),
                blurRadius: 10.r)
          ],
          borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: TextWidget(
                text: 'Order Summary'.tr,
                color: AppColor.textColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            const DeviderWidget(),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Subtotal'.tr,
                    color: AppColor.textColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  TextWidget(
                    text: '${authController.settingModel!.data!
                                        .siteDefaultCurrencySymbol
                                        .toString()}${subTotal!.toStringAsFixed(int.parse(authController.settingModel!.data!.siteDigitAfterDecimalPoint.toString()))}',
                    color: AppColor.textColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: "Tax".tr,
                    color: AppColor.textColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  TextWidget(
                    text: '${authController.settingModel!.data!
                                        .siteDefaultCurrencySymbol
                                        .toString()}${tax!.toStringAsFixed(int.parse(authController.settingModel!.data!.siteDigitAfterDecimalPoint.toString()))}',
                    color: AppColor.textColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Shipping Charge'.tr,
                    color: AppColor.textColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  TextWidget(
                    text: '${authController.settingModel!.data!
                                        .siteDefaultCurrencySymbol
                                        .toString()}${double.parse(shippingCharge.toString()).toStringAsFixed(int.parse(authController.settingModel!.data!.siteDigitAfterDecimalPoint.toString()))}',
                    color: AppColor.textColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Discount'.tr,
                    color: AppColor.textColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  TextWidget(
                    text: '${authController.settingModel!.data!
                                        .siteDefaultCurrencySymbol
                                        .toString()}${discount!.toStringAsFixed(int.parse(authController.settingModel!.data!.siteDigitAfterDecimalPoint.toString()))}',
                    color: AppColor.textColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            const DeviderWidget(),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Total'.tr,
                    color: AppColor.textColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  TextWidget(
                    text: '${authController.settingModel!.data!
                                        .siteDefaultCurrencySymbol
                                        .toString()}${total!.toStringAsFixed(int.parse(authController.settingModel!.data!.siteDigitAfterDecimalPoint.toString()))}',
                    color: AppColor.textColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: InkWell(
                onTap: onTap,
                child: PrimaryButton(text: buttonText ?? ""),
              ),
            )
          ],
        ),
      ),
    );
  }
}
