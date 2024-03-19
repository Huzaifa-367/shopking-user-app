import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/theme/app_color.dart';

class PopularSectionShimmer extends StatelessWidget {
  const PopularSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 24.h, bottom: 13.h),
          child: Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[200]!,
                highlightColor: Colors.grey[300]!,
                child: Container(
                  height: 30.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[200]!,
          highlightColor: Colors.grey[300]!,
          child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, index) {
                return GridView.count(crossAxisCount: 2, children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[200]!,
                    highlightColor: Colors.grey[300]!,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Container(
                        height: 100.h,
                        width: 328.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: Colors.white,
                          border: Border.all(
                              color: AppColor.primaryBackgroundColor),
                        ),
                      ),
                    ),
                  ),
                ]);
              }),
        ),
      ],
    );
  }
}
