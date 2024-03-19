import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/theme/app_color.dart';

class ReviewImageWidget extends StatelessWidget {
  const ReviewImageWidget({super.key, required this.image});
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 88.h,
        width: 88.w,
        decoration: BoxDecoration(
          color: AppColor.borderColor,
          image: DecorationImage(
              image: NetworkImage(image.toString()), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(8.r),
        ));
  }
}
