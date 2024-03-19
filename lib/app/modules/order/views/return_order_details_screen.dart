import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/order/controller/return_controller.dart';
import 'package:shopperz/app/modules/order/widgets/return_order2.dart';
import 'package:shopperz/app/modules/order/widgets/review_image.dart';
import 'package:shopperz/main.dart';
import 'package:shopperz/widgets/appbar3.dart';
import 'package:shopperz/widgets/devider.dart';
import 'package:shopperz/widgets/loader/loader.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../../../../config/theme/app_color.dart';

class ReturnOrderDetailsScreen extends StatefulWidget {
  const ReturnOrderDetailsScreen({super.key, required this.id});
  final String id;

  @override
  State<ReturnOrderDetailsScreen> createState() =>
      _ReturnOrderDetailsScreenState();
}

class _ReturnOrderDetailsScreenState extends State<ReturnOrderDetailsScreen> {
  ReturnController returnController = Get.put(ReturnController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (box.read('isLogedIn') != false) {
      returnController.getReturnOrdersDetails(return_id: widget.id.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColor.primaryBackgroundColor,
        appBar: AppBarWidget3(
          text: 'Return Order Details'.tr,
        ),
        body: RefreshIndicator(
          color: AppColor.primaryColor,
          onRefresh: () async {
            if (box.read('isLogedIn') != false) {
              returnController.getReturnOrdersDetails(
                  return_id: widget.id.toString());
            }
          },
          child: Obx(
            () => returnController.returnOrdersDetailsMap.isNotEmpty
                ? SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          AppColor.blackColor.withOpacity(0.04),
                                      offset: const Offset(0, 0),
                                      blurRadius: 10.r)
                                ]),
                            child: Padding(
                              padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 12.w, right: 12.w),
                                    child: Row(
                                      children: [
                                        TextWidget(
                                          text: 'Order ID: '.tr,
                                          color: AppColor.textColor,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        TextWidget(
                                          text:
                                              '#${returnController.returnOrdersDetailsModel!.data!.orderSerialNo}',
                                          color: AppColor.textColor,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  const DeviderWidget(),
                                  ListView.builder(
                                    itemCount: returnController
                                        .returnOrdersDetailsModel!
                                        .data!
                                        .returnProducts!
                                        .length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return ReturnOrderWidget2(
                                        returnData: returnController
                                            .returnOrdersDetailsModel!
                                            .data!
                                            .returnProducts![index],
                                        data: returnController
                                            .returnOrdersDetailsModel!.data!,
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          AppColor.blackColor.withOpacity(0.04),
                                      offset: const Offset(0, 0),
                                      blurRadius: 10.r)
                                ]),
                            child: Padding(
                              padding: EdgeInsets.all(16.r),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      text: 'Return Reason'.tr,
                                      color: AppColor.textColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    TextWidget(
                                      text: returnController
                                          .returnOrdersDetailsModel!
                                          .data!
                                          .returnReasonName,
                                      textAlign: TextAlign.left,
                                      color: AppColor.textColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    SizedBox(
                                      height: returnController
                                                  .returnOrdersDetailsModel!
                                                  .data!
                                                  .note ==
                                              ''
                                          ? 0
                                          : 16.h,
                                    ),
                                    returnController.returnOrdersDetailsModel!
                                                .data!.note ==
                                            ''
                                        ? const SizedBox()
                                        : TextWidget(
                                            text: 'Return Note'.tr,
                                            color: AppColor.textColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    SizedBox(
                                      height: returnController
                                                  .returnOrdersDetailsModel!
                                                  .data!
                                                  .note ==
                                              ''
                                          ? 0
                                          : 12.h,
                                    ),
                                    returnController.returnOrdersDetailsModel!
                                                .data!.note ==
                                            ''
                                        ? const SizedBox()
                                        : TextWidget(
                                            text: returnController
                                                .returnOrdersDetailsModel!
                                                .data!
                                                .note,
                                            textAlign: TextAlign.left,
                                            color: AppColor.textColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    returnController.returnOrdersDetailsModel!
                                            .data!.images!.isNotEmpty
                                        ? TextWidget(
                                            text: 'Attachment'.tr,
                                            color: AppColor.textColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          )
                                        : const SizedBox(),
                                    SizedBox(
                                      height: returnController
                                              .returnOrdersDetailsModel!
                                              .data!
                                              .images!
                                              .isNotEmpty
                                          ? 12.h
                                          : 0,
                                    ),
                                    returnController.returnOrdersDetailsModel!
                                            .data!.images!.isNotEmpty
                                        ? StaggeredGrid.count(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 10.h,
                                            crossAxisSpacing: 10.w,
                                            children: [
                                              for (var i = 0;
                                                  i <
                                                      returnController
                                                          .returnOrdersDetailsModel!
                                                          .data!
                                                          .images!
                                                          .length;
                                                  i++)
                                                InkWell(
                                                  onTap: () {
                                                    Get.dialog(Dialog(
                                                      child: Image.network(
                                                          returnController
                                                              .returnOrdersDetailsModel!
                                                              .data!
                                                              .images![i]),
                                                    ));
                                                  },
                                                  child: ReviewImageWidget(
                                                    image: returnController
                                                        .returnOrdersDetailsModel!
                                                        .data!
                                                        .images![i],
                                                  ),
                                                )
                                            ],
                                          )
                                        : const SizedBox(),
                                  ]),
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          AppColor.blackColor.withOpacity(0.04),
                                      offset: const Offset(0, 0),
                                      blurRadius: 10.r)
                                ]),
                            child: Padding(
                              padding: EdgeInsets.all(16.r),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      text: 'Return Response'.tr,
                                      color: AppColor.textColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    TextWidget(
                                      text: returnController
                                                  .returnOrdersDetailsModel!
                                                  .data!
                                                  .status ==
                                              5
                                          ? 'Pending'
                                          : returnController
                                                      .returnOrdersDetailsModel!
                                                      .data!
                                                      .status ==
                                                  10
                                              ? 'Accepted'
                                              : returnController
                                                          .returnOrdersDetailsModel!
                                                          .data!
                                                          .status ==
                                                      15
                                                  ? 'Rejected'
                                                  : '',
                                      color: returnController
                                                  .returnOrdersDetailsModel!
                                                  .data!
                                                  .status ==
                                              5
                                          ? AppColor.pendingColor
                                          : returnController
                                                      .returnOrdersDetailsModel!
                                                      .data!
                                                      .status ==
                                                  10
                                              ? AppColor.activeColor
                                              : returnController
                                                          .returnOrdersDetailsModel!
                                                          .data!
                                                          .status ==
                                                      15
                                                  ? AppColor.redColor2
                                                  : null,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    SizedBox(
                                      height: returnController
                                                  .returnOrdersDetailsModel!
                                                  .data!
                                                  .rejectReason ==
                                              ''
                                          ? 0
                                          : 12.h,
                                    ),
                                    returnController.returnOrdersDetailsModel!
                                                .data!.rejectReason ==
                                            ''
                                        ? const SizedBox()
                                        : TextWidget(
                                            text: returnController
                                                .returnOrdersDetailsModel!
                                                .data!
                                                .rejectReason,
                                            textAlign: TextAlign.left,
                                            color: AppColor.textColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                  ]),
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          )
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: LoaderCircle(),
                  ),
          ),
        ),
      ),
    );
  }
}
