import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopperz/utils/svg_icon.dart';

import '../config/theme/app_color.dart';

class AppBarWidget2 extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.primaryBackgroundColor,
      elevation: 0,
      toolbarHeight: 48.h,
      leadingWidth: 56.w,
      leading: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: SvgPicture.asset(
            SvgIcon.back,
            height: 24.h,
            width: 24.w,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.w, left: 16.w),
          child: SvgPicture.asset(
            SvgIcon.search,
            height: 24.h,
            width: 24.w,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
