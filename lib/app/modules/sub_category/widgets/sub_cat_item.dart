import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../../../../config/theme/app_color.dart';

class SubCatItemWidget extends StatefulWidget {
  const SubCatItemWidget({super.key, this.subCategoryItem});
  final String? subCategoryItem;

  @override
  State<SubCatItemWidget> createState() => _SubCatItemWidgetState();
}

class _SubCatItemWidgetState extends State<SubCatItemWidget> {
  bool select = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h, left: 16.w),
      child: Row(
        children: [
          TextWidget(
            text: widget.subCategoryItem,
            color: AppColor.textColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }
}
