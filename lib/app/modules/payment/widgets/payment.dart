import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopperz/widgets/textwidget.dart';
import 'package:flutter/material.dart';

import '../../../../config/theme/app_color.dart';

// ignore: must_be_immutable
class PaymentWidget extends StatefulWidget {
  PaymentWidget({super.key, this.name, this.image, this.selected});
  String? name;
  String? image;
  bool? selected;

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      width: 156.w,
      decoration: BoxDecoration(
          color: widget.selected == true
              ? AppColor.primaryColor1
              : AppColor.whiteColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
              color: widget.selected == true
                  ? AppColor.primaryColor
                  : Colors.transparent,
              width: 1.r),
          boxShadow: [
            BoxShadow(
                color: AppColor.blackColor.withOpacity(0.04),
                offset: const Offset(0, 6),
                blurRadius: 32.r)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: widget.image ?? "",
            imageBuilder: (context, imageProvider) => Container(
              height: 24.h,
              width: 40.w,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover)),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          TextWidget(
            text: widget.name.toString(),
            color: AppColor.textColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }
}
