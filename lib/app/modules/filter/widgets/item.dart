import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../../../../config/theme/app_color.dart';
import '../../category/model/category_wise_product.dart';

class ItemWidget extends StatefulWidget {
  const ItemWidget(
      {super.key,
      this.filterName,
      this.brandId,
      this.brandIdList,
      this.cateWiseProductModel,
      this.onTap,
      this.select});

  final Data? cateWiseProductModel;
  final String? filterName;
  final String? brandId;
  final List<dynamic>? brandIdList;
  final void Function()? onTap;
  final bool? select;

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          InkWell(
            onTap: widget.onTap,
            child: SvgPicture.asset(
              widget.select == true ? SvgIcon.checkActive : SvgIcon.check,
              height: 20.h,
              width: 20.w,
            ),
          ),
          SizedBox(
            width: 12.w,
          ),
          TextWidget(
            text: widget.filterName,
            color: AppColor.textColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }
}
