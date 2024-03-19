import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/theme/app_color.dart';
import 'custom_text.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.onTap,
    required this.text,
    this.height = 48,
    this.width = 328,
  });

  final void Function()? onTap;
  final String text;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
        child: Ink(
          height: height?.h,
          width: width?.w,
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Center(
              child: CustomText(
            text: text,
            color: Colors.white,
            weight: FontWeight.w700,
            size: 16.sp,
          )),
        ),
      ),
    );
  }
}
