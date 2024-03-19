import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/theme/app_color.dart';

class BottomNavItem extends StatelessWidget {
  final String? imageData;
  final String? tittle;
  final VoidCallback? onTap;
  final bool isSelected;
  const BottomNavItem(
      {super.key,
      this.imageData,
      this.tittle,
      this.onTap,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imageData!,
                colorFilter: ColorFilter.mode(
                    isSelected
                        ? AppColor.primaryColor
                        : AppColor.deSelectedColor,
                    BlendMode.srcIn),
                height: 20.h,
                width: 20.w,
              ),
              Padding(
                padding: EdgeInsets.only(top: 4.h, bottom: 2.h),
                child: Text(
                  tittle!,
                  maxLines: 1,
                  style: GoogleFonts.urbanist(
                    fontSize: 12.sp,
                    color: isSelected
                        ? AppColor.primaryColor
                        : AppColor.deSelectedColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
