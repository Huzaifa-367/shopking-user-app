import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopperz/data/model/return_order_details_model.dart';
import 'package:shopperz/widgets/devider.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../../../../config/theme/app_color.dart';

class ReturnOrderWidget2 extends StatefulWidget {
  const ReturnOrderWidget2({super.key, required this.returnData, required this.data});
  final ReturnProducts? returnData;
  final Data? data;

  @override
  State<ReturnOrderWidget2> createState() => _ReturnOrderWidget2State();
}

class _ReturnOrderWidget2State extends State<ReturnOrderWidget2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DeviderWidget(),
        SizedBox(
          height: 11.h,
        ),
        Container(
          height: 65.h,
          width: double.infinity,
          color: AppColor.whiteColor,
          child: Padding(
            padding: EdgeInsets.only(left: 12.w, right: 12.w),
            child: Row(
              children: [
                Container(
                  height: 65.h,
                  width: 52.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      image: DecorationImage(
                          image: NetworkImage(widget.returnData!.productImage.toString()),
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
                        text: widget.returnData!.productName,
                        color: AppColor.textColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      TextWidget(
                        text: widget.returnData!.variationNames == 'null' ? '':widget.returnData!.variationNames,
                        color: AppColor.textColor,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      TextWidget(
                        text: 'Qty:'.tr +' ${widget.returnData!.quantity}',
                        color: AppColor.textColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              TextWidget(
                                text: 'Price: '.tr,
                                color: AppColor.textColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              TextWidget(
                                text: widget.returnData!.returnCurrencyPrice,
                                color: AppColor.textColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              )
                            ],
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Row(
                            children: [
                              TextWidget(
                                text: 'Total: '.tr,
                                color: AppColor.textColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              TextWidget(
                                text: widget.data!.returnTotalCurrencyPrice,
                                color: AppColor.textColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 11.h,
        ),
      ],
    );
  }
}
