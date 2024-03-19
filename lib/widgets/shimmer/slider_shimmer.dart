import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopperz/config/theme/app_color.dart';

class SliderSectionShimmer extends StatelessWidget {
  const SliderSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 132.h,
            width: 328.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
        Positioned(
          bottom: 10.h,
          left: 0,
          right: 0,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 10.h,
                      width: 10.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        //color: Colors.white,
                        border: Border.all(
                          color: AppColor.borderColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5), // Adjust spacing as needed
                  Shimmer.fromColors(
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 10.h,
                      width: 10.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
