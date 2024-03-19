import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/order/controller/order_controller.dart';
import 'package:shopperz/app/modules/order/widgets/order.dart';
import 'package:shopperz/app/modules/profile/controller/profile_controller.dart';
import 'package:shopperz/main.dart';
import 'package:shopperz/utils/images.dart';
import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/widgets/appbar3.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../../../../config/theme/app_color.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  ProfileController profile = Get.put(ProfileController());
  OrderController order = Get.put(OrderController());

  @override
  void initState() {
    super.initState();
    if (box.read('isLogedIn') != false) {
      profile.getProfile();
      profile.getTotalOrdersCount();
      profile.getTotalCompleteOrdersCount();
      profile.getTotalReturnOrdersCount();
      profile.getTotalWalletBalance();
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
        body: RefreshIndicator(
          color: AppColor.primaryColor,
          onRefresh: () async {
            if (box.read('isLogedIn') != false) {
              profile.getProfile();
              profile.getTotalOrdersCount();
              profile.getTotalCompleteOrdersCount();
              profile.getTotalReturnOrdersCount();
              profile.getTotalWalletBalance();
              order.getOrderHistory();
            }
          },
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'MY_ACCOUNT'.tr,
                        color: AppColor.primaryColor,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Obx(
                        () => profile.profileMap.isNotEmpty &&
                                profile.profileModel!.data != null
                            ? Row(
                                children: [
                                  TextWidget(
                                    text: 'Welcome Back, '.tr,
                                    color: AppColor.textColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  TextWidget(
                                    text:
                                        '${profile.profileModel!.data!.name}!',
                                    color: AppColor.textColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              )
                            : TextWidget(
                                text: 'Welcome Back'.tr,
                                color: AppColor.textColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 160.h,
                            width: 156.w,
                            decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.circular(16.r),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          AppColor.blackColor.withOpacity(0.04),
                                      offset: Offset(0, 6.r),
                                      blurRadius: 32.r)
                                ]),
                            child: Padding(
                              padding: EdgeInsets.all(8.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                        color: AppColor.pinkColor,
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColor.pinkColor
                                                  .withOpacity(0.25),
                                              offset: const Offset(0, 6),
                                              blurRadius: 15.r)
                                        ]),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        SvgIcon.bag2,
                                        height: 20.h,
                                        width: 20.w,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Obx(
                                    () => profile.totalOrdersCountMap
                                                .isNotEmpty &&
                                            profile.totalOrdersCount!.data !=
                                                null
                                        ? TextWidget(
                                            text: profile.totalOrdersCount!
                                                .data!.totalOrders
                                                .toString(),
                                            color: AppColor.pinkColor,
                                            fontSize: 26.sp,
                                            fontWeight: FontWeight.w700,
                                          )
                                        : TextWidget(
                                            text: '0',
                                            color: AppColor.pinkColor,
                                            fontSize: 26.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  TextWidget(
                                    text: 'TOTAL_ORDERS'.tr,
                                    color: AppColor.deSelectedColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 160.h,
                            width: 156.w,
                            decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.circular(16.r),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          AppColor.blackColor.withOpacity(0.04),
                                      offset: Offset(0, 6.r),
                                      blurRadius: 32.r)
                                ]),
                            child: Padding(
                              padding: EdgeInsets.all(8.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                        color: AppColor.orangeColor,
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColor.orangeColor
                                                  .withOpacity(0.25),
                                              offset: const Offset(0, 6),
                                              blurRadius: 15.r)
                                        ]),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        SvgIcon.bag3,
                                        height: 20.h,
                                        width: 20.w,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Obx(() => profile.totalCompleteOrdersCountMap
                                              .isNotEmpty &&
                                          profile.totalCompleteOrdersCount!
                                                  .data !=
                                              null
                                      ? TextWidget(
                                          text: profile
                                              .totalCompleteOrdersCount!
                                              .data!
                                              .totalCompletedOrders
                                              .toString(),
                                          color: AppColor.orangeColor,
                                          fontSize: 26.sp,
                                          fontWeight: FontWeight.w700,
                                        )
                                      : TextWidget(
                                          text: '0',
                                          color: AppColor.orangeColor,
                                          fontSize: 26.sp,
                                          fontWeight: FontWeight.w700,
                                        )),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  TextWidget(
                                    text: 'TOTAL_COMPLETED'.tr,
                                    color: AppColor.deSelectedColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 160.h,
                            width: 156.w,
                            decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.circular(16.r),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          AppColor.blackColor.withOpacity(0.04),
                                      offset: Offset(0, 6.r),
                                      blurRadius: 32.r)
                                ]),
                            child: Padding(
                              padding: EdgeInsets.all(8.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                        color: AppColor.returnColor,
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColor.returnColor
                                                  .withOpacity(0.25),
                                              offset: const Offset(0, 6),
                                              blurRadius: 15.r)
                                        ]),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        SvgIcon.refresh,
                                        height: 20.h,
                                        width: 20.w,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Obx(
                                    () => profile.totalReturnOrdersCountMap
                                                .isNotEmpty &&
                                            profile.totalReturnOrdersCount!
                                                    .data !=
                                                null
                                        ? TextWidget(
                                            text: profile
                                                .totalReturnOrdersCount!
                                                .data!
                                                .totalReturnedOrders
                                                .toString(),
                                            color: AppColor.returnColor,
                                            fontSize: 26.sp,
                                            fontWeight: FontWeight.w700,
                                          )
                                        : TextWidget(
                                            text: '0',
                                            color: AppColor.returnColor,
                                            fontSize: 26.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  TextWidget(
                                    text: 'TOTAL_RETURNED'.tr,
                                    color: AppColor.deSelectedColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 160.h,
                            width: 156.w,
                            decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.circular(16.r),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          AppColor.blackColor.withOpacity(0.04),
                                      offset: Offset(0, 6.r),
                                      blurRadius: 32.r)
                                ]),
                            child: Padding(
                              padding: EdgeInsets.all(8.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                        color: AppColor.blueColor1,
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColor.blueColor1
                                                  .withOpacity(0.25),
                                              offset: const Offset(0, 6),
                                              blurRadius: 15.r)
                                        ]),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        SvgIcon.bag2,
                                        height: 20.h,
                                        width: 20.w,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Obx(
                                    () => profile.totalWalletBalanceMap
                                                .isNotEmpty &&
                                            profile.totalWalletBalance!.data !=
                                                null
                                        ? TextWidget(
                                            text: profile.totalWalletBalance!
                                                .data!.walletBalance
                                                .toString(),
                                            color: AppColor.blueColor1,
                                            fontSize: 26.sp,
                                            fontWeight: FontWeight.w700,
                                          )
                                        : TextWidget(
                                            text: '0',
                                            color: AppColor.blueColor1,
                                            fontSize: 26.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  TextWidget(
                                    text: 'WALLET_BALANCE'.tr,
                                    color: AppColor.deSelectedColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      TextWidget(
                        text: 'ORDER_HISTORY'.tr,
                        color: AppColor.textColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Obx(
                        () => order.orderHistoryList.isNotEmpty &&
                                order.orderHistoryList.length > 0
                            ? ListView.builder(
                                itemCount: order.orderHistoryList.length > 3
                                    ? 3
                                    : order.orderHistoryList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 16.h),
                                    child: OrderWidget(
                                        order: order.orderHistoryList[index]),
                                  );
                                },
                              )
                            : Center(
                                child: Image.asset(
                                  AppImages.emptyIcon,
                                  height: 300.h,
                                  width: 300.w,
                                ),
                              ),
                      ),
                    ])),
          ),
        ),
      ),
    );
  }
}
