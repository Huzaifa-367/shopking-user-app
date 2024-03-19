import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/order/controller/return_controller.dart';
import 'package:shopperz/data/model/order_details_model.dart';
import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/widgets/devider.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../../../../config/theme/app_color.dart';

class OrderWidget3 extends StatefulWidget {
  const OrderWidget3({super.key, required this.product, required this.index});
  final OrderProducts? product;
  final int index;

  @override
  State<OrderWidget3> createState() => _OrderWidget3State();
}

class _OrderWidget3State extends State<OrderWidget3> {
  ReturnController returnContrller = Get.put(ReturnController());
  int quantity = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quantity = widget.product!.orderQuantity!.toInt();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    returnContrller.returnItems.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DeviderWidget(),
        SizedBox(
          height: 11.h,
        ),
        Container(
          height: 80.h,
          width: double.infinity,
          color: AppColor.whiteColor,
          child: Padding(
            padding: EdgeInsets.only(left: 12.w, right: 12.w),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      returnContrller.addItem(
                        index: widget.index,
                        id: widget.product!.productId!, 
                        quantity: quantity, 
                        price: double.tryParse(widget.product!.price!.toString())!, 
                        has_variation: widget.product!.hasVariation!, 
                        order_quantity: widget.product!.orderQuantity!, 
                        return_price: 0, 
                        tax: double.tryParse(widget.product!.tax.toString())!,
                        total: double.tryParse(widget.product!.total.toString())!,
                        variation_id: widget.product!.variationId.toString(), 
                        variation_names: widget.product!.variationNames.toString());
                        });

                    returnContrller.checkItem(index: widget.index);

                    setState(() {
                      
                    });
                  },
                  child: SvgPicture.asset(
                      returnContrller.checkItem(index: widget.index) == true ? SvgIcon.checkActive : SvgIcon.check,
                      height: 20.h,
                      width: 20.w,
                    ),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Container(
                  height: 80.h,
                  width: 62.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    image: DecorationImage(
                        image: NetworkImage(widget.product!.productImage.toString()),
                        fit: BoxFit.cover),
                  ),
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
                        text: widget.product!.productName,
                        color: AppColor.textColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      widget.product!.variationNames == ''? SizedBox() : TextWidget(
                        text: widget.product!.variationNames,
                        color: AppColor.textColor,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                          height: 25.h,
                          width: 86.w,
                          decoration: BoxDecoration(
                              color: AppColor.cartColor,
                              borderRadius: BorderRadius.circular(20.r)),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(4.r),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: 

                                    () {
                                      setState(() {
                                        if (quantity > 1) {
                                          quantity--;
                                          returnContrller.decrementItem(index: widget.index);
                                        }
                                      });
                                    },
                                    child: SvgPicture.asset(
                                        quantity < 2
                                            ? SvgIcon.cart1
                                            : SvgIcon.cart3,
                                        height: 20.h,
                                        width: 20.w),
                                  ),
                                  TextWidget(
                                    text: quantity.toString(),
                                    color: AppColor.textColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  InkWell(
                                    onTap: 
                                    () {
                                      setState(() {
                                        if(quantity < widget.product!.orderQuantity!.toInt())
                                        {
                                          quantity++;
                                          returnContrller.incrementItem(index: widget.index);
                                        }
                                        
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      SvgIcon.cart2,
                                      color: quantity < widget.product!.orderQuantity!.toInt() ? null: AppColor.quantityError, 
                                        height: 20.h, width: 20.w),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 2.h,
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
                                text: widget.product!.subtotalCurrencyPrice,
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
                                text: widget.product!.totalCurrencyPrice,
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
