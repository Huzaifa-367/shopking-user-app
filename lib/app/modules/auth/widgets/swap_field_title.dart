import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../widgets/custom_text.dart';
import '../controller/swap_title_controller.dart';

class SwapFieldTitle extends StatelessWidget {
  const SwapFieldTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final fieldSwapController = Get.put(SwapTitleController());
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text:
                fieldSwapController.isShowEmailField.value ? "Email".tr : "Phone".tr,
            size: 14.sp,
            weight: FontWeight.w500,
          ),
          GestureDetector(
            onTap: fieldSwapController.showEmailField,
            child: CustomText(
              text: fieldSwapController.isShowEmailField.value
                  ? "*Use Phone Instead".tr
                  : "*Use Email Instead".tr,
              color: AppColor.primaryColor,
              weight: FontWeight.w500,
              decoration: true,
            ),
          )
        ],
      );
    });
  }
}
