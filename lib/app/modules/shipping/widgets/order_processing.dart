import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopperz/data/model/order_details_model.dart';
import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../../../../config/theme/app_color.dart';

class OrderProcesingWidget extends StatelessWidget {
  const OrderProcesingWidget({super.key,required this.order});
  final Data? order;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.centerRight,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 24.r,
                  width: 24.r,
                  decoration: BoxDecoration(
                      color: AppColor.activeColor,
                      borderRadius: BorderRadius.circular(24.r)),
                  child: Center(
                    child: SvgPicture.asset(
                      SvgIcon.active,
                      height: 12.h,
                      width: 12.w,
                    ),
                  ),
                ),
                Positioned(
                  right: -78.w,
                  child: Container(
                    height: 6.h,
                    width: 78.w,
                    color: order!.status == 1 || order!.status == 5 || order!.status == 7 || order!.status == 10 || order!.status == 15 || order!.status == 20 ? AppColor.activeColor: AppColor.borderColor,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            TextWidget(
              text: 'Order'.tr +'\n''Pending'.tr,
              textAlign: TextAlign.center,
              color: AppColor.textColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.centerRight,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 24.r,
                  width: 24.r,
                  decoration: BoxDecoration(
                      color: order!.status == 5 || order!.status == 7 || order!.status == 10 || order!.status == 15 || order!.status == 20 ? AppColor.activeColor: AppColor.inactiveColor,
                      border: Border.all(
                        color: order!.status == 1 ? AppColor.activeColor : Colors.transparent,
                        width: 4.w
                      ),
                      borderRadius: BorderRadius.circular(24.r)),
                  child: order!.status == 5 || order!.status == 7 || order!.status == 10 || order!.status == 15 || order!.status == 20 ? Center(
                    child: SvgPicture.asset(
                      SvgIcon.active,
                      height: 12.h,
                      width: 12.w,
                    ),
                  ):Container(),
                ),
                Positioned(
                  right: -78.w,
                  child: Container(
                    height: 6.h,
                    width: 78.w,
                    color: order!.status == 5 || order!.status == 7 || order!.status == 10 || order!.status == 15 || order!.status == 20 ? AppColor.activeColor: AppColor.borderColor,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            TextWidget(
              text: 'Order'.tr + '\n''Confirmed'.tr,
              textAlign: TextAlign.center,
              color: AppColor.textColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.centerRight,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 24.r,
                  width: 24.r,
                  decoration: BoxDecoration(
                      color: order!.status == 7 || order!.status == 10 || order!.status == 15 || order!.status == 20 ? AppColor.activeColor: AppColor.inactiveColor,
                      border: Border.all(
                        color: order!.status == 5 ? AppColor.activeColor : Colors.transparent,
                        width: 4.w
                      ),
                      borderRadius: BorderRadius.circular(24.r)),
                  child: order!.status == 7 || order!.status == 10 || order!.status == 15 || order!.status == 20 ? Center(
                    child: SvgPicture.asset(
                      SvgIcon.active,
                      height: 12.h,
                      width: 12.w,
                    ),
                  ):Container(),
                ),
                Positioned(
                  right: -78.w,
                  child: Container(
                    height: 6.h,
                    width: 78.w,
                    color: order!.status == 7 || order!.status == 10 || order!.status == 15 || order!.status == 20 ? AppColor.activeColor: AppColor.borderColor,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            TextWidget(
              text: 'On the'.tr +'\n''Way'.tr,
              textAlign: TextAlign.center,
              color: AppColor.textColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                  height: 24.r,
                  width: 24.r,
                  decoration: BoxDecoration(
                      color: order!.status == 10 || order!.status == 15 || order!.status == 20 ? AppColor.activeColor: AppColor.inactiveColor,
                      border: Border.all(
                        color: order!.status == 7 ? AppColor.activeColor : Colors.transparent,
                        width: 4.w
                      ),
                      borderRadius: BorderRadius.circular(24.r)),
                  child: order!.status == 10 || order!.status == 15 || order!.status == 20 ? Center(
                    child: SvgPicture.asset(
                      SvgIcon.active,
                      height: 12.h,
                      width: 12.w,
                    ),
                  ):Container(),
                ),
            SizedBox(
              height: 8.h,
            ),
            TextWidget(
              text: 'Order'.tr+'\n''Delivered'.tr,
              textAlign: TextAlign.center,
              color: AppColor.textColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
      ],
    );
  }
}
