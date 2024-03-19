import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class PromotionBannerShimmer extends StatelessWidget {
  const PromotionBannerShimmer({super.key, this.width});
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey[200]!,
          highlightColor: Colors.grey[300]!,
          child: Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Container(
              height: 138.h,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
