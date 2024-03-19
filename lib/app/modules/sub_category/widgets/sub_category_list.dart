import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/widgets/devider.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../../../../config/theme/app_color.dart';

class SubCategoryListWidget extends StatefulWidget {
  const SubCategoryListWidget(
      {super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;
  @override
  State<SubCategoryListWidget> createState() => _SubCategoryListWidgetState();
}

class _SubCategoryListWidgetState extends State<SubCategoryListWidget> {
  bool isExpanded = false;

  _onExpansionChanged(bool val) {
    setState(() {
      isExpanded = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
              tilePadding: EdgeInsets.zero,
              onExpansionChanged: _onExpansionChanged,
              trailing: SvgPicture.asset(
                isExpanded == true ? SvgIcon.up : SvgIcon.downEx,
                height: 20.h,
                width: 20.w,
              ),
              title: TextWidget(
                text: widget.title,
                color: AppColor.textColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              children: widget.children),
        ),
        const DeviderWidget()
      ],
    );
  }
}
