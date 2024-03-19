import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopperz/utils/svg_icon.dart';

import '../../config/theme/app_color.dart';

class LoaderCircle extends StatelessWidget {
  const LoaderCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: const SizedBox(),
          ),
        ),
        Container(
          height: 100.r,
          width: 100.r,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              height: 100.r,
              width: 100.r,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Padding(
                    padding: EdgeInsets.all(5.r),
                    child: SvgPicture.asset(
                      SvgIcon.logo,
                      height: 60.h,
                      width: 80.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const Positioned(
          top: 2,
          left: 2,
          right: 2,
          bottom: 2,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            backgroundColor: AppColor.primaryColor,
          ),
        ),
      ],
    );
  }
}
