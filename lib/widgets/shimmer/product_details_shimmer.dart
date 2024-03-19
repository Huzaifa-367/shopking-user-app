import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/theme/app_color.dart';
import '../../utils/svg_icon.dart';
import '../custom_text.dart';
import '../secondary_button.dart';

class ProductDetailsShimmer extends StatelessWidget {
  const ProductDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[200]!,
          highlightColor: Colors.grey[300]!,
          child: Container(
            height: 346.h,
            width: 328.w,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColor.borderColor),
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        ),
        SizedBox(height: 10.h),

        SizedBox(
          height: 80.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[200]!,
                highlightColor: Colors.grey[300]!,
                child: Container(
                  margin: EdgeInsets.only(right: 18.w),
                  height: 76.h,
                  width: 76.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 20.h),

        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[300]!,
                  child: Container(
                    height: 20.h,
                    width: 100.w,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[300]!,
                  child: Container(
                    height: 20.h,
                    width: 100.w,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 16.w),
                Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[300]!,
                  child: Container(
                    height: 20.h,
                    width: 100.w,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[300]!,
                  child: RatingBarIndicator(
                    rating: 5,
                    itemSize: 10.h,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 1.w),
                      child: SvgPicture.asset(
                        SvgIcon.star,
                        colorFilter: const ColorFilter.mode(
                            AppColor.whiteColor, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                SizedBox(
                  child: Row(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[200]!,
                        highlightColor: Colors.grey[300]!,
                        child: Container(
                          height: 20.h,
                          width: 100.w,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: 15.h),
        Divider(
          height: 1.h,
          color: const Color(0xFFEFF0F6),
        ),
        SizedBox(height: 15.h),

        Shimmer.fromColors(
          baseColor: Colors.grey[200]!,
          highlightColor: Colors.grey[300]!,
          child: Container(
            height: 20.h,
            width: 100.w,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 36,
          child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[200]!,
                    highlightColor: Colors.grey[300]!,
                    child: Container(
                      height: 30.h,
                      width: 30.w,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                    ),
                  ),
                );
              }),
        ),
        SizedBox(height: 24.h),

        Shimmer.fromColors(
          baseColor: Colors.grey[200]!,
          highlightColor: Colors.grey[300]!,
          child: Container(
            height: 20.h,
            width: 100.w,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 32.h,
          child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[200]!,
                    highlightColor: Colors.grey[300]!,
                    child: Container(
                      height: 30.h,
                      width: 52.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                  ),
                );
              }),
        ),
        SizedBox(height: 24.h),

        Shimmer.fromColors(
          baseColor: Colors.grey[200]!,
          highlightColor: Colors.grey[300]!,
          child: Container(
            height: 20.h,
            width: 100.w,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Shimmer.fromColors(
          baseColor: Colors.grey[200]!,
          highlightColor: Colors.grey[300]!,
          child: Container(
            width: 99.w,
            height: 36.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(SvgIcon.decrement),
                CustomText(text: "", size: 18.sp, weight: FontWeight.w600),
                SvgPicture.asset(SvgIcon.increment)
              ],
            ),
          ),
        ),

        SizedBox(height: 32.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Add to cart
            Shimmer.fromColors(
              baseColor: Colors.grey[200]!,
              highlightColor: Colors.grey[300]!,
              child: SecondaryButton(
                height: 48.h,
                width: 165.w,
                icon: SvgIcon.bag,
                buttonColor: Colors.white,
                text: "",
              ),
            ),

            // Add to favorite
            Shimmer.fromColors(
              baseColor: Colors.grey[200]!,
              highlightColor: Colors.grey[300]!,
              child: SecondaryButton(
                height: 48.h,
                width: 139.w,
                text: "",
                icon: SvgIcon.heart,
                textColor: Colors.black,
                buttonColor: Colors.white,
                onTap: () {},
              ),
            )
          ],
        ),
      ],
    );
  }
}
