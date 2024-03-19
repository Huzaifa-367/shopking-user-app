import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../utils/svg_icon.dart';
import '../../../../widgets/textwidget.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    this.onTap,
    this.text,
  });

  final void Function()? onTap;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Ink(
        height: 30.h,
        width: 55.w,
        decoration: BoxDecoration(
            color: AppColor.primaryColor1,
            borderRadius: BorderRadius.circular(20.r)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                SvgIcon.cart2,
                height: 12.h,
                width: 12.w,
                colorFilter: const ColorFilter.mode(
                    AppColor.primaryColor, BlendMode.srcIn),
              ),
              SizedBox(
                width: 4.w,
              ),
              TextWidget(
                text: text,
                color: AppColor.primaryColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              )
            ],
          ),
        ),
      ),
    );
  }
}
