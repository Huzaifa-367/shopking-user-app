import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../utils/svg_icon.dart';
import '../../../../widgets/textwidget.dart';
import '../controller/filter_controller.dart';

class SortByWidget extends StatefulWidget {
  const SortByWidget({super.key});
  @override
  State<SortByWidget> createState() => _SortByWidgetState();
}

class _SortByWidgetState extends State<SortByWidget> {
  bool isExpanded = false;

  _onExpansionChanged(bool val) {
    setState(() {
      isExpanded = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sortController = Get.put(FilterController());
    return Column(
      children: <Widget>[
        ExpansionTile(
          onExpansionChanged: _onExpansionChanged,
          tilePadding: EdgeInsets.symmetric(horizontal: 0.w),
          title: TextWidget(
            text: "Sort By".tr,
            color: AppColor.textColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
          trailing: SvgPicture.asset(
            isExpanded == true ? SvgIcon.up : SvgIcon.downEx,
            height: 20.h,
            width: 20.w,
          ),
          children: <Widget>[
            Obx(
              () => Column(
                children: <Widget>[
                  RadioListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 0.w),
                    title: Text('Newest'.tr),
                    value: 'newest',
                    groupValue: sortController.selectedOption.value,
                    activeColor: AppColor.primaryColor,
                    onChanged: (value) {
                      sortController.selectedOption.value = value!;

                      Get.back();
                    },
                  ),
                  RadioListTile(
                    activeColor: AppColor.primaryColor,
                    contentPadding: EdgeInsets.symmetric(horizontal: 0.w),
                    title: Text('Price Low To High'.tr),
                    value: 'price_low_to_high',
                    groupValue: sortController.selectedOption.value,
                    onChanged: (value) {
                      sortController.selectedOption.value = value!;

                      Get.back();
                    },
                  ),
                  RadioListTile(
                    activeColor: AppColor.primaryColor,
                    contentPadding: EdgeInsets.symmetric(horizontal: 0.w),
                    title: Text('Price High To Low'.tr),
                    value: 'price_high_to_low',
                    groupValue: sortController.selectedOption.value,
                    onChanged: (value) {
                      sortController.selectedOption.value = value!;

                      Get.back();
                    },
                  ),
                  RadioListTile(
                    activeColor: AppColor.primaryColor,
                    contentPadding: EdgeInsets.symmetric(horizontal: 0.w),
                    title: Text('Top Rated'.tr),
                    value: 'top_rated',
                    groupValue: sortController.selectedOption.value,
                    onChanged: (value) {
                      sortController.selectedOption.value = value!;

                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
