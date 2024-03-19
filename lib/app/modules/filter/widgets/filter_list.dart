import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopperz/app/modules/filter/widgets/item.dart';
import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/widgets/devider.dart';
import 'package:shopperz/widgets/textwidget.dart';
import '../../../../config/theme/app_color.dart';

class FilterListWidget extends StatefulWidget {
  const FilterListWidget(
      {super.key,
      this.filterSectionName,
      this.listType,
      this.brandId,
      this.brandIdList});

  final String? filterSectionName;
  final List? listType;
  final String? brandId;
  final List<dynamic>? brandIdList;

  @override
  State<FilterListWidget> createState() => _FilterListWidgetState();
}

class _FilterListWidgetState extends State<FilterListWidget> {
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
              text: widget.filterSectionName,
              color: AppColor.textColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
            children: [
              for (int index = 0; index < widget.listType!.length; index++)
                ItemWidget(
                  filterName: widget.listType![index],
                  brandId: widget.brandId,
                  brandIdList: widget.brandIdList![index],
                ),
            ],
          ),
        ),
        const DeviderWidget()
      ],
    );
  }
}
