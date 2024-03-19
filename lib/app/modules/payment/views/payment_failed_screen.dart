import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/navbar/views/navbar_view.dart';
import 'package:shopperz/config/theme/app_color.dart';
import 'package:shopperz/widgets/textwidget.dart'; 

class PaymentFailedView extends GetView {
  const PaymentFailedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.h,
      child: Padding(
        padding: EdgeInsets.all(8.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(
              text: "ARE_YOU_SURE_WANT_TO_CLOSE_THIS_PAYMENT_SESSION".tr,
              textAlign: TextAlign.center,
                color: AppColor.textColor,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp
              ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.offAll(() => const NavBarView());
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 1,
                      backgroundColor: AppColor.cartColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                    ),
                    child: TextWidget(
                      text: "YES_CLOSE".tr,
                      color: AppColor.textColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 1,
                      backgroundColor: AppColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                    ),
                    child: TextWidget(
                      text:"RETRY".tr,
                      color: AppColor.whiteColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                      ),
                    ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}