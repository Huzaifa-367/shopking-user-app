import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../widgets/textwidget.dart';

class SeeAllButton extends StatelessWidget {
  const SeeAllButton({
    super.key,
    this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15.r),
      onTap: onTap,
      child: Ink(
        height: 30.h,
        width: 70.h,
        decoration: BoxDecoration(
          color: const Color(0xffFFF4F1),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Center(
            child: TextWidget(
          text: "See All".tr,
          fontSize: 12.sp,
          color: AppColor.primaryColor,
          fontWeight: FontWeight.w600,
        )),
      ),
    );
  }
}
