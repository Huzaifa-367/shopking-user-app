import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../widgets/textwidget.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.streetAddress,
    required this.state,
  });

  final String fullName;
  final String phone;
  final String email;
  final String streetAddress;
  final String state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            text: fullName,
            color: AppColor.textColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            height: 8.h,
          ),
          TextWidget(
            text: phone,
            color: AppColor.textColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(
            height: email == '' ? 0.h :8.h,
          ),
          email == '' ? SizedBox(): TextWidget(
            text: email,
            color: AppColor.textColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(
            height: 8.h,
          ),
          TextWidget(
            text: streetAddress,
            color: AppColor.textColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(
            height: 8.h,
          ),
          TextWidget(
            text: state,
            color: AppColor.textColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
