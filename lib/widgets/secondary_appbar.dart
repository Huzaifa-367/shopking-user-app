import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../config/theme/app_color.dart';
import '../utils/svg_icon.dart';

class SecondaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SecondaryAppBar({
    super.key,
    this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 54.w,
      backgroundColor: AppColor.primaryBackgroundColor,
      leading: Container(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: GestureDetector(
          onTap: () => Get.back(),
          child: SvgPicture.asset(
            SvgIcon.back,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(right: 16.w, left: 16.w),
            child: SvgPicture.asset(
              SvgIcon.search,
            ),
          ),
        )
      ],
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
