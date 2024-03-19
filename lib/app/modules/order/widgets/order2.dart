import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/order/views/Edit_review_screen.dart';
import 'package:shopperz/app/modules/order/views/review_screen.dart';
import 'package:shopperz/data/model/order_details_model.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../../../../config/theme/app_color.dart';

class OrderWidget2 extends StatelessWidget {
  const OrderWidget2({super.key, required this.product, required this.order});
  final OrderProducts? product;
  final Data? order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Column(
        children: [
          Container(
            height: 62.h,
            width: double.infinity,
            color: AppColor.whiteColor,
            child: Row(
              children: [
                Container(
                  height: 62.h,
                  width: 52.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      image: DecorationImage(
                          image: NetworkImage(product!.productImage.toString()),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: product!.productName,
                        color: AppColor.textColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      TextWidget(
                        text: product!.variationNames,
                        color: AppColor.textColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextWidget(
                            text: product!.subtotalCurrencyPrice,
                            color: AppColor.textColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          TextWidget(
                            text: 'Qty:'.tr + ' ${product!.orderQuantity}',
                            color: AppColor.textColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          const Spacer(),
                          order!.status == 10 ?
                          InkWell(
                            onTap: () {
                             Get.to(() => product!.productUserReview == false? ReviewScreen(product: product,) : EditReviewScreen(product: product));
                            },
                            child: Container(
                              height: 26.h,
                              width: 95.w,
                              decoration: BoxDecoration(
                                  color: AppColor.primaryColor1,
                                  borderRadius: BorderRadius.circular(14.r)),
                              child: Center(
                                child: TextWidget(
                                  text: product!.productUserReview == false? 'Write Review'.tr: 'Edit Review'.tr,
                                  color: AppColor.primaryColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ):
                          SizedBox()
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          DottedLine(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            lineLength: double.infinity,
            lineThickness: 1.sp,
            dashLength: 4.w,
            dashColor: AppColor.borderColor,
            dashGapLength: 4.w,
            dashGapColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
