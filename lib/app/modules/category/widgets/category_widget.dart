import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../../../../config/theme/app_color.dart';

class CategoryList extends StatelessWidget {
  const CategoryList(
      {super.key,
      required this.text,
      this.onTapSubCategory,
      this.onTapProduct});

  final String text;
  final Function()? onTapProduct;

  final Function()? onTapSubCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: AppColor.borderColor, width: 1.sp))),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 8,
              child: InkWell(
                onTap: onTapProduct,
                child: SizedBox(
                  height: 70.h,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextWidget(
                      text: text,
                      color: AppColor.textColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: onTapSubCategory,
                child: SizedBox(
                  height: 70.h,
                  child: Padding(
                    padding: EdgeInsets.all(8.r),
                    child: SvgPicture.asset(
                      SvgIcon.forward,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
