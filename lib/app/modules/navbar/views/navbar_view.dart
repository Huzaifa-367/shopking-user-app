import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/auth/views/sign_in.dart';
import 'package:shopperz/app/modules/cart/controller/cart_controller.dart';
import 'package:shopperz/app/modules/cart/views/cart_screen.dart';
import 'package:shopperz/app/modules/category/views/category_screen.dart';
import 'package:shopperz/app/modules/home/views/home_screen.dart';
import 'package:shopperz/app/modules/navbar/controller/navbar_controller.dart';
import 'package:shopperz/app/modules/navbar/widgets/bottom_navbar.dar.dart';
import 'package:shopperz/app/modules/profile/views/profile_screen.dart';
import 'package:shopperz/app/modules/wishlist/controller/wishlist_controller.dart';
import 'package:shopperz/app/modules/wishlist/views/wishlist_screen.dart';
import 'package:shopperz/data/helper/device_token.dart';
import 'package:shopperz/data/helper/notification_helper.dart';
import 'package:shopperz/main.dart';
import 'package:shopperz/utils/svg_icon.dart';
import '../../../../config/theme/app_color.dart';

class NavBarView extends StatelessWidget {
  const NavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationHelper notificationHelper = NotificationHelper();

    DeviceToken deviceToken = DeviceToken();

    notificationHelper.notificationPermission();

    if (box.read('isLogedIn') != false) {
      deviceToken.getDeviceToken();
    }

    final navController = Get.put(NavbarController());
    GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey();
    final CartController cartController = Get.put(CartController());

    List<Widget> screens = [
      const HomeScreen(),
      const CategoryScreen(),
      CartScreen(),
      const WishlistScreen(),
      const ProfileScreen()
    ];

    return WillPopScope(
      onWillPop: () async {
        if (navController.selectedIndex.value != 0) {
          navController.selectPage(0);
          return false;
        } else {
          if (navController.canExit.value) {
            navController.selectPage(0);
            return true;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Press back again to exit.'.tr,
                    style: TextStyle(color: Colors.white)),
                behavior: SnackBarBehavior.floating,
                backgroundColor: AppColor.primaryColor,
                duration: Duration(seconds: 2),
                margin: EdgeInsets.all(10),
              ),
            );
            navController.canExit.value = true;
            Timer(const Duration(seconds: 2), () {
              navController.canExit.value = false;
            });
            return false;
          }
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
        ),
        child: Scaffold(
          key: scaffoldKey,
          extendBody: true,
          floatingActionButton: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50.r)),
              boxShadow: [
                BoxShadow(
                  color: AppColor.primaryColor.withOpacity(0.3),
                  offset: const Offset(
                    0.0,
                    5.0,
                  ),
                  blurRadius: 10.r,
                  spreadRadius: 2.r,
                ),
              ],
            ),
            child: Obx(
              () => InkWell(
                borderRadius: BorderRadius.circular(52.r),
                onTap: () {
                  navController.selectedIndex(2);
                },
                child: Container(
                  height: 56.r,
                  width: 56.r,
                  decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(56.r),
                      boxShadow: [
                        BoxShadow(
                            color: AppColor.primaryColor.withOpacity(0.34),
                            blurRadius: 10.r,
                            offset: Offset(0, 6))
                      ]),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 60.h,
                        width: 60.w,
                        child: CircleAvatar(
                            backgroundColor: AppColor.primaryColor,
                            child: SvgPicture.asset(
                              SvgIcon.bag,
                              height: 24.h,
                              width: 24.w,
                              color: AppColor.whiteColor,
                            )),
                      ),
                      cartController.totalItems > 0
                          ? Positioned(
                              top: 12.h,
                              right: 10.w,
                              child: Container(
                                height: 10.r,
                                width: 10.r,
                                decoration: BoxDecoration(
                                    color: AppColor.yellowColor,
                                    borderRadius: BorderRadius.circular(10.r)),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Obx(() {
            return BottomAppBar(
              elevation: 5,
              notchMargin: 5,
              clipBehavior: Clip.antiAlias,
              shape: const CircularNotchedRectangle(),
              child: Row(children: [
                BottomNavItem(
                    tittle: "Home".tr,
                    imageData: navController.selectedIndex.value == 0
                        ? SvgIcon.homeActive
                        : SvgIcon.home,
                    isSelected: navController.selectedIndex.value == 0,
                    onTap: () => navController.selectPage(0)),
                BottomNavItem(
                    tittle: "Category".tr,
                    imageData: navController.selectedIndex.value == 1
                        ? SvgIcon.categoryActive
                        : SvgIcon.category,
                    isSelected: navController.selectedIndex.value == 1,
                    onTap: () => navController.selectPage(1)),
                const Expanded(
                  child: SizedBox(),
                ),
                BottomNavItem(
                    tittle: "Wishlist".tr,
                    imageData: navController.selectedIndex.value == 3
                        ? SvgIcon.wishlistActive
                        : SvgIcon.wishlist,
                    isSelected: navController.selectedIndex.value == 3,
                    onTap: () async {
                      if (box.read('isLogedIn') != false) {
                        navController.selectPage(3);
                        await Get.put(WishlistController()).fetchFavorite();
                      } else {
                        Get.to(() => SignInScreen());
                      }
                    }),
                BottomNavItem(
                    tittle: "Profile".tr,
                    imageData: navController.selectedIndex.value == 4
                        ? SvgIcon.profileActive
                        : SvgIcon.profile,
                    isSelected: navController.selectedIndex.value == 4,
                    onTap: () {
                      navController.selectPage(4);
                    }),
              ]),
            );
          }),
          body: Obx(() {
            return screens[navController.selectedIndex.value];
          }),
        ),
      ),
    );
  }
}
