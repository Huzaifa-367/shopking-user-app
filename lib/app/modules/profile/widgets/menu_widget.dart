import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../../../../config/theme/app_color.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget(
      {super.key, required this.text, required this.icon, this.onTap});
  final String? text;
  final String? icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 52.h,
        width: double.infinity,
        child: Center(
          child: Row(
            children: [
              SvgPicture.asset(
                '$icon',
                height: 20.h,
                width: 20.w,
              ),
              SizedBox(
                width: 16.w,
              ),
              TextWidget(
                text: '$text',
                color: AppColor.textColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
