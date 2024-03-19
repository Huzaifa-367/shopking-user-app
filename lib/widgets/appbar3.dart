import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../config/theme/app_color.dart';

class AppBarWidget3 extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget3({super.key, required this.text});
  final String? text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.primaryBackgroundColor,
      elevation: 0,
      toolbarHeight: 48.h,
      leadingWidth: double.infinity,
      leading: Padding(
        padding: EdgeInsets.only(left: 8.w,top: 8.h),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: SvgPicture.asset(
                SvgIcon.back,
                height: 24.h,
                width: 24.w,
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            TextWidget(
              text: '$text',
              color: AppColor.textColor,
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
