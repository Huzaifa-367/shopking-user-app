import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/order/views/order_details_screen.dart';
import 'package:shopperz/data/model/order_history_model.dart';
import 'package:shopperz/main.dart';
import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../../../../config/theme/app_color.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({super.key,required this.order});
  final Data? order;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(()=> OrderDetailsScreen(id: order!.id.toString()));
      },
      child: Stack(
        children: [
          Container(
            height: 191.h,
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
                    text: '#${order!.orderSerialNo}',
                    color: AppColor.textColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  TextWidget(
                    text: order!.orderDatetime.toString(),
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
                        text: '${order!.orderItems.toString()} ' + 'Product'.tr,
                        color: AppColor.textColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextWidget(
                        text: 'Delivery Status: '.tr,
                        color: AppColor.textColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      TextWidget(
                        text: order!.statusName.toString(),
                        color: order!.status == 1 ? AppColor
                            .pendingColor : order!.status == 5 ? AppColor.primaryColor : order!.status == 7 ? AppColor.onthewayColor : order!.status == 10 ? AppColor.greenColor : order!.status == 15 ? AppColor.redColor2 : order!.status == 20 ? AppColor.redColor2 : null,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextWidget(
                        text: 'Payment Status: '.tr,
                        color: AppColor.textColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: order!.paymentStatus == 5 ? AppColor
                                .paidColor: order!.paymentStatus == 10 ? AppColor.unpaidColor:null,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Padding(
                          padding: EdgeInsets.all(4.r),
                          child: Wrap(
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 2.w, right: 2.w),
                                  child: TextWidget(
                                    text: order!.paymentStatus == 5 ? 'Paid'.tr : order!.paymentStatus == 10 ? 'Unpaid'.tr : '',
                                    color: order!.paymentStatus == 5 ? AppColor
                                        .greenColor : order!.paymentStatus == 10 ? AppColor.redColor2 : null, // unpaid color AppColor.redColor2 //refund color AppColor.refundTextColor
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
                        text: order!.totalCurrencyPrice.toString(),
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
