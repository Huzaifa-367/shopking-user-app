import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/order/controller/order_controller.dart';
import 'package:shopperz/app/modules/order/widgets/order.dart';
import 'package:shopperz/main.dart';
import 'package:shopperz/utils/images.dart';
import 'package:shopperz/widgets/appbar3.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../../../../config/theme/app_color.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  OrderController order = Get.put(OrderController());

  @override
  void initState() {
    order.loadMoreData();
    super.initState();
    if (box.read('isLogedIn') != false) {
      order.getOrderHistory();
    }
  }

  @override
  void dispose() {
    order.resetState();
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
              text: 'ORDER_HISTORY'.tr,
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
                  order.resetState();
                  order.getOrderHistory();
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
                        () => order.orderHistoryList.isNotEmpty &&
                                order.orderHistoryList.length > 0
                            ? ListView.builder(
                                controller: order.scrollController,
                                itemCount: order.orderHistoryList.length +
                                    (order.hasMoreData == true ? 1 : 0),
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  if (index == order.orderHistoryList.length) {
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
                                    child: OrderWidget(
                                        order: order.orderHistoryList[index]),
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
