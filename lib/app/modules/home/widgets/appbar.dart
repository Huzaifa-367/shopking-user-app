import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopperz/utils/svg_icon.dart';

import '../../../../config/theme/app_color.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    this.onTap,
    this.svgIcon,
    this.title,
  });

  final void Function()? onTap;
  final String? svgIcon;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.primaryBackgroundColor,
      elevation: 0,
      toolbarHeight: 48.h,
      leadingWidth: 130.w,
      leading: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: SvgPicture.asset(
          SvgIcon.logo,
          height: 20.h,
          width: 73.w,
        ),
      ),
      title: Text(
        title ?? "",
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: AppColor.textColor,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(right: 16.w, left: 16.w),
            child: SvgPicture.asset(
              svgIcon ?? "",
              height: 24.h,
              width: 24.w,
            ),
          ),
        ),
      ],
    );
  }
}
