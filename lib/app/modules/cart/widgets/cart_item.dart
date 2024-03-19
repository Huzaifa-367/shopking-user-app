import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../../../../config/theme/app_color.dart';

class CartWidget extends StatefulWidget {
 const CartWidget(
      {super.key,
      this.title,
      this.color,
      this.size,
      this.increment,
      this.decrement,
      required this.quantity,
      this.productImage,
      this.currentPrice,
      this.discountPrice,
      this.remove,
      required this.isOffer,
      this.stock,
      this.incrementValue,
      this.decrementIconvalue = 1,
      this.finalVariation});

  final String? productImage;
  final String? title;
  final String? color;
  final String? size;
  final String quantity;
  final String? currentPrice;
  final String? discountPrice;
  final void Function()? increment;
  final void Function()? decrement;
  final void Function()? remove;
  final int decrementIconvalue;
  final int? incrementValue;
  final int? stock;
  final String? finalVariation;
  final bool? isOffer;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 115.h,
          width: double.infinity,
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: widget.productImage ??
                    "https://img.freepik.com/free-vector/healthy-food-packaging-set_1284-23304.jpg",
                imageBuilder: (context, imageProvider) => Container(
                  height: double.infinity,
                  width: 92.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
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
                      text: widget.title ?? '',
                      color: AppColor.textColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextWidget(
                      text: widget.finalVariation,
                      color: AppColor.textColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      children: [
                        TextWidget(
                              text: widget.currentPrice,
                              color: AppColor.textColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                        SizedBox(
                          width: 8.w,
                        ),
                        widget.isOffer == true ? TextWidget(
                                text: widget.discountPrice ?? '0',
                                color: AppColor.quantityError,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.lineThrough): const SizedBox(),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 30.h,
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
                                    onTap: widget.decrement,
                                    child: SvgPicture.asset(
                                        widget.decrementIconvalue < 2
                                            ? SvgIcon.cart1
                                            : SvgIcon.cart3,
                                        height: 20.h,
                                        width: 20.w),
                                  ),
                                  TextWidget(
                                    text: widget.quantity,
                                    color: AppColor.textColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  InkWell(
                                    onTap: widget.increment,
                                    child: SvgPicture.asset(widget.stock! > widget.incrementValue!.toInt() ? SvgIcon.cart2 : SvgIcon.cart1,
                                        height: 20.h, width: 20.w),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: widget.remove,
                          child: Container(
                            height: 30.h,
                            width: 79.w,
                            decoration: BoxDecoration(
                                color: AppColor.removeColor,
                                borderRadius: BorderRadius.circular(20.r)),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(4.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(SvgIcon.remove,
                                        height: 16.h, width: 16.w),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    TextWidget(
                                      text: 'Remove'.tr,
                                      color: AppColor.removeTextColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
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
        Container(
          height: 1.h,
          width: double.infinity,
          color: AppColor.borderColor,
        )
      ],
    );
  }
}
