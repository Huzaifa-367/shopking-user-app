import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../config/theme/app_color.dart';
import '../utils/images.dart';
import '../utils/svg_icon.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.primaryBackgroundColor,
      elevation: 0,
      leadingWidth: 73.w,
      toolbarHeight: 48.h,
      leading: Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: Image.asset(
          AppImages.logo,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 4.w),
          child: GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(SvgIcon.search),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
