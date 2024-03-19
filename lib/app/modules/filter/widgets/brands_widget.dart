import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/category/model/category_wise_product.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../utils/svg_icon.dart';
import '../../../../widgets/devider.dart';
import '../../../../widgets/textwidget.dart';
import '../controller/filter_controller.dart';
import 'item.dart';

class BrandListWidget extends StatefulWidget {
  const BrandListWidget({super.key, this.cateWiseProduct});
  final Data? cateWiseProduct;

  @override
  State<BrandListWidget> createState() => _BrandListWidgetState();
}

class _BrandListWidgetState extends State<BrandListWidget> {
  final filterContrller = Get.put(FilterController());
  bool isExpanded = false;
  bool select = false;

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
              text: "Brands".tr,
              color: AppColor.textColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
            children: [
              for (int index = 0;
                  index < widget.cateWiseProduct!.brands!.length;
                  index++)
                ItemWidget(
                  filterName: widget.cateWiseProduct?.brands?[index].name ?? "",
                  onTap: () {
                    filterContrller.addBrandId(
                        widget.cateWiseProduct?.brands?[index].id.toString() ??
                            "");

                    if (filterContrller.brandIndexList.contains(
                        widget.cateWiseProduct?.brands?[index].id.toString())) {
                      select = true;
                    } else {
                      select = false;
                    }
                    setState(() {});
                  },
                  select: filterContrller.brandIndexList.contains(
                          widget.cateWiseProduct?.brands?[index].id.toString())
                      ? true
                      : false,
                ),
            ],
          ),
        ),
        const DeviderWidget()
      ],
    );
  }
}
