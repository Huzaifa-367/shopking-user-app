import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/order/controller/return_controller.dart';
import 'package:shopperz/app/modules/order/widgets/return_order.dart';
import 'package:shopperz/main.dart';
import 'package:shopperz/utils/images.dart';
import 'package:shopperz/widgets/appbar3.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../../../../config/theme/app_color.dart';

class ReturnOrdersScreen extends StatefulWidget {
  const ReturnOrdersScreen({super.key});

  @override
  State<ReturnOrdersScreen> createState() => _ReturnOrdersScreenState();
}

class _ReturnOrdersScreenState extends State<ReturnOrdersScreen> {
  ReturnController returnController = Get.put(ReturnController());
  @override
  void initState() {
    returnController.loadMoreData();
    super.initState();
    if (box.read('isLogedIn') != false) {
      returnController.getReturnOrders();
    }
  }

  @override
  void dispose() {
    returnController.resetState();
    super.dispose();
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
        appBar: const AppBarWidget3(text: ''),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
            child: TextWidget(
              text: 'RETURN_ORDERS'.tr,
              color: AppColor.primaryColor,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Expanded(
            child: RefreshIndicator(
              color: AppColor.primaryColor,
              onRefresh: () async {
                if (box.read('isLogedIn') != false) {
                  returnController.resetState();
                  returnController.getReturnOrders();
                }
              },
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 12.h,
                    ),
                    Expanded(
                      child: Obx(
                        () => returnController.returnOrdersList.isNotEmpty &&
                                returnController.returnOrdersList.length > 0
                            ? ListView.builder(
                                controller: returnController.scrollController,
                                itemCount:
                                    returnController.returnOrdersList.length +
                                        (returnController.hasMoreData == true
                                            ? 1
                                            : 0),
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  if (index ==
                                      returnController
                                          .returnOrdersList.length) {
                                    return Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          height: 40.h,
                                          width: 40.w,
                                          child:
                                              const CircularProgressIndicator(
                                            color: AppColor.primaryColor,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 16.h),
                                    child: ReturnOrderWidget(
                                      returnData: returnController
                                          .returnOrdersList[index],
                                    ),
                                  );
                                },
                              )
                            : Padding(
                                padding: EdgeInsets.only(top: 100.h),
                                child: Center(
                                  child: Image.asset(
                                    AppImages.emptyIcon,
                                    height: 300.h,
                                    width: 300.w,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
