import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../../../../config/theme/app_color.dart';

class CouponWidget extends StatelessWidget {
  const CouponWidget(
      {super.key,
      this.offerImage,
      this.startDate,
      this.endDate,
      this.onTap,
      this.name,
      this.description});
  final String? offerImage;
  final String? name;
  final String? description;
  final String? startDate;
  final String? endDate;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 92.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColor.couponColor,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                    color: AppColor.blackColor.withOpacity(0.04),
                    offset: const Offset(0, 6),
                    blurRadius: 10.r)
              ]),
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: name,
                  color: AppColor.textColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                TextWidget(
                  text: description,
                  color: AppColor.textColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                TextWidget(
                  text: '$startDate - $endDate',
                  color: AppColor.textColor1,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: onTap,
            child: Container(
              height: 29.h,
              width: 61.w,
              decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      bottomRight: Radius.circular(12.r))),
              child: Center(
                child: TextWidget(
                  text: 'Apply'.tr,
                  color: AppColor.whiteColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
