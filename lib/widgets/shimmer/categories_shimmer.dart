import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesSectionShimmer extends StatelessWidget {
  const CategoriesSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: SizedBox(
            width: double.infinity,
            height: 90.h,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (BuildContext context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[200]!,
                    highlightColor: Colors.grey[300]!,
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: Container(
                        height: 90.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
