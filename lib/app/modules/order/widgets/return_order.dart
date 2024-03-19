import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/order/views/return_order_details_screen.dart';
import 'package:shopperz/data/model/return_orders_model.dart';
import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../../../../main.dart';
import '../../../../config/theme/app_color.dart';

class ReturnOrderWidget extends StatelessWidget {
  const ReturnOrderWidget({super.key, required this.returnData});
  final Data? returnData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(ReturnOrderDetailsScreen(id: returnData!.id.toString(),));
      },
      child: Stack(
        children: [
          Container(
            height: 162.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                      color: AppColor.blackColor.withOpacity(0.04),
                      offset: const Offset(0, 0),
                      blurRadius: 10.r)
                ]),
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: '#${returnData!.orderSerialNo}',
                    color: AppColor.textColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  TextWidget(
                    text: returnData!.returnDatetime,
                    color: AppColor.deSelectedColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  Row(
                    children: [
                      TextWidget(
                        text: 'Info: '.tr,
                        color: AppColor.textColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      TextWidget(
                        text: '${returnData!.returnItems} ' 'Product'.tr,
                        color: AppColor.textColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextWidget(
                        text: 'Return Status: '.tr,
                        color: AppColor.textColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      TextWidget(
                        text: returnData!.status == 5 ? 'Pending'.tr : returnData!.status == 10 ? 'Accepted'.tr :returnData!.status == 15 ? 'Rejected'.tr : '',
                        color: returnData!.status == 5 ? AppColor
                            .pendingColor : returnData!.status == 10 ? AppColor.activeColor : returnData!.status == 15 ? AppColor.redColor2 : null,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextWidget(
                        text: 'Total: '.tr,
                        color: AppColor.textColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      TextWidget(
                        text: returnData!.returnTotalCurrencyPrice,
                        color: AppColor.textColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: box.read("languageCode") == 'ar' ? null : 16.w,
            left: box.read("languageCode") == 'ar' ? 16.w : null,
            top: 16.h,
            child: Container(
              height: 30.h,
              width: 30.w,
              decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                        color: AppColor.primaryColor.withOpacity(0.25),
                        offset: const Offset(0, 6),
                        blurRadius: 15.r)
                  ]),
              child: Center(
                child: SvgPicture.asset(
                  SvgIcon.eye,
                  colorFilter: const ColorFilter.mode(
                      AppColor.whiteColor, BlendMode.srcIn),
                  height: 20.h,
                  width: 20.w,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
