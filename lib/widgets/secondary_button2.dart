import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';

class SecondaryButton2 extends StatelessWidget {
  const SecondaryButton2(
      {super.key,
      required this.height,
      required this.width,
      required this.text,
      this.onTap,
      this.buttonColor,
      this.textColor});

  final double height;
  final double width;
  final String text;
  final void Function()? onTap;
  final Color? buttonColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.r),
      child: Ink(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            color: buttonColor,
          ),
          child: Center(
            child: CustomText(
              text: text,
              size: 16.sp,
              weight: FontWeight.w700,
              color: textColor,
            ),
          )),
    );
  }
}
