import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/images.dart';

class HomeOfferSectionShimmer extends StatelessWidget {
  const HomeOfferSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (BuildContext context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[300]!,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Container(
                height: 84.h,
                width: 328.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.asset(
                    height: 84.h,
                    width: 328.w,
                    AppImages.offer2,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
