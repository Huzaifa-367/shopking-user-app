// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopperz/app/modules/auth/controller/auth_controler.dart';
import 'package:shopperz/app/modules/auth/views/sign_in.dart';
import 'package:shopperz/app/modules/auth/views/sign_up.dart';
import 'package:shopperz/app/modules/language/controller/language_controller.dart';
import 'package:shopperz/app/modules/language/views/language_change_screen.dart';
import 'package:shopperz/app/modules/order/controller/order_controller.dart';
import 'package:shopperz/app/modules/order/controller/return_controller.dart';
import 'package:shopperz/app/modules/profile/controller/profile_controller.dart';
import 'package:shopperz/app/modules/profile/views/pages_screen.dart';
import 'package:shopperz/app/modules/profile/widgets/address_screen.dart';
import 'package:shopperz/app/modules/profile/widgets/change_password.dart';
import 'package:shopperz/app/modules/profile/widgets/delete_account_widget.dart';
import 'package:shopperz/app/modules/profile/widgets/edit_profile.dart';

import 'package:shopperz/app/modules/profile/widgets/menu_widget.dart';
import 'package:shopperz/main.dart';
import 'package:shopperz/utils/images.dart';
import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/widgets/devider.dart';
import 'package:shopperz/widgets/loader/loader.dart';
import 'package:shopperz/widgets/primary_button.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../../../../config/theme/app_color.dart';
import '../../order/views/order_history_screen.dart';
import '../../order/views/return_orders_screen.dart';
import 'my_account_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profile = Get.put(ProfileController());
  AuthController auth = Get.put(AuthController());
  OrderController order = Get.put(OrderController());
  LanguageController language = Get.put(LanguageController());
  ReturnController returnController = Get.put(ReturnController());

  @override
  void initState() {
    super.initState();
    if (box.read('isLogedIn') != false) {
      profile.getProfile();
      profile.getAddress();
      profile.getTotalOrdersCount();
      profile.getTotalCompleteOrdersCount();
      profile.getTotalReturnOrdersCount();
      profile.getTotalWalletBalance();
      // order.getOrderHistory();
      // returnController.getReturnOrders();
      returnController.getReturnReason();
    }
    language.getLanguageData();
    profile.getPages();
  }

  openDeleteAccountDialog() {
    Get.dialog(Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: AccountDeleteWidget(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Stack(
          alignment: Alignment.center,
          children: [
            Scaffold(
              backgroundColor: AppColor.primaryBackgroundColor,
              appBar: AppBar(
                backgroundColor: AppColor.primaryBackgroundColor,
                elevation: 0,
                toolbarHeight: 48.h,
                leadingWidth: 130.w,
                leading: Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  child: SvgPicture.asset(
                    SvgIcon.logo,
                    height: 20.h,
                    width: 73.w,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      Column(
                        children: [
                          box.read('isLogedIn') != false
                              ? Obx(
                                  () => Stack(
                                      clipBehavior: Clip.none,
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          height: 100.r,
                                          width: 100.r,
                                          decoration: BoxDecoration(
                                            color: AppColor.whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(74.r),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100.r),
                                            child: profile.profileMap.isNotEmpty
                                                ? CachedNetworkImage(
                                                    imageUrl: profile
                                                            .profileModel
                                                            ?.data
                                                            ?.image ??
                                                        "",
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    placeholder:
                                                        (context, url) =>
                                                            Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey[300]!,
                                                      highlightColor:
                                                          Colors.grey[400]!,
                                                      child: Container(
                                                          height: 74.r,
                                                          width: 74.r,
                                                          color: Colors.grey),
                                                    ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  )
                                                : Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey[300]!,
                                                    highlightColor:
                                                        Colors.grey[400]!,
                                                    child: Container(
                                                        height: 74.r,
                                                        width: 74.r,
                                                        color: Colors.grey),
                                                  ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: -12.h,
                                          right: 0,
                                          child: InkWell(
                                            onTap: () {
                                              profile.getImageFromGallary();
                                            },
                                            child: Container(
                                              height: 32.r,
                                              width: 32.r,
                                              decoration: BoxDecoration(
                                                  color: AppColor.redColor,
                                                  border: Border.all(
                                                      color:
                                                          AppColor.whiteColor,
                                                      width: 2.r),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          32.r)),
                                              child: Center(
                                                child: SvgPicture.asset(
                                                  SvgIcon.menuEdit,
                                                  color: AppColor.whiteColor,
                                                  // colorFilter:
                                                  //     const ColorFilter.mode(
                                                  //   AppColor.whiteColor,
                                                  //   BlendMode.dst,
                                                  // ),
                                                  height: 16.h,
                                                  width: 16.w,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ]),
                                )
                              : Container(
                                  height: 74.r,
                                  width: 74.r,
                                  decoration: BoxDecoration(
                                    color: AppColor.whiteColor,
                                    borderRadius: BorderRadius.circular(74.r),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            AppImages.profilePicture),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                          SizedBox(height: 16.h),
                          box.read('isLogedIn') != false
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Obx(
                                      () => profile.profileMap.isNotEmpty &&
                                              profile.profileModel?.data != null
                                          ? Column(
                                              children: [
                                                SizedBox(
                                                  height: 12.h,
                                                ),
                                                TextWidget(
                                                  text: profile
                                                      .profileModel!.data!.name
                                                      .toString(),
                                                  color: AppColor.textColor,
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                profile.profileModel!.data!
                                                                .phone
                                                                .toString() !=
                                                            '' &&
                                                        profile
                                                                .profileModel!
                                                                .data!
                                                                .countryCode
                                                                .toString() !=
                                                            ''
                                                    ? SizedBox(
                                                        height: 8.h,
                                                      )
                                                    : const SizedBox(),
                                              ],
                                            )
                                          : const SizedBox(),
                                    ),
                                    Obx(
                                      () => profile.profileMap.isNotEmpty &&
                                              profile.profileModel?.data != null
                                          ? Column(
                                              children: [
                                                TextWidget(
                                                  text: profile.profileModel!
                                                                  .data!.phone
                                                                  .toString() ==
                                                              '' ||
                                                          profile
                                                                  .profileModel!
                                                                  .data!
                                                                  .countryCode
                                                                  .toString() ==
                                                              ''
                                                      ? ''
                                                      : profile.profileModel!
                                                              .data!.countryCode
                                                              .toString() +
                                                          profile.profileModel!
                                                              .data!.phone
                                                              .toString(),
                                                  color: AppColor.textColor1,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                profile.profileModel!.data!
                                                                .phone
                                                                .toString() !=
                                                            '' &&
                                                        profile
                                                                .profileModel!
                                                                .data!
                                                                .countryCode
                                                                .toString() !=
                                                            ''
                                                    ? SizedBox(
                                                        height: 8.h,
                                                      )
                                                    : const SizedBox(),
                                              ],
                                            )
                                          : const SizedBox(),
                                    ),
                                    Obx(
                                      () => profile.profileMap.isNotEmpty &&
                                              profile.profileModel?.data != null
                                          ? TextWidget(
                                              text: profile.profileModel!.data!
                                                          .email
                                                          .toString() ==
                                                      'null'
                                                  ? ''
                                                  : profile
                                                      .profileModel!.data!.email
                                                      .toString(),
                                              color: AppColor.textColor1,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                            )
                                          : const SizedBox(),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    TextWidget(
                                      text: 'SING_IN_TO_SEE_YOUR_INFO'.tr,
                                      color: AppColor.textColor,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    SizedBox(
                                      height: 24.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => const SignUpScreen());
                                          },
                                          borderRadius:
                                              BorderRadius.circular(24.r),
                                          child: Ink(
                                            height: 48.h,
                                            width: 156.w,
                                            decoration: BoxDecoration(
                                              color: AppColor.primaryColor1,
                                              borderRadius:
                                                  BorderRadius.circular(24.r),
                                            ),
                                            child: Center(
                                              child: TextWidget(
                                                text: 'Sign Up'.tr,
                                                color: AppColor.primaryColor,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => const SignInScreen());
                                          },
                                          borderRadius:
                                              BorderRadius.circular(24.r),
                                          child: Ink(
                                            height: 48.h,
                                            width: 156.w,
                                            decoration: BoxDecoration(
                                                color: AppColor.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        24.r)),
                                            child: Center(
                                              child: TextWidget(
                                                text: 'Sign In'.tr,
                                                color: AppColor.whiteColor,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                        ],
                      ),
                      SizedBox(
                        height: 28.h,
                      ),
                      box.read('isLogedIn') != false
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MenuWidget(
                                  text: 'MY_ACCOUNT'.tr,
                                  icon: SvgIcon.menuProfile,
                                  onTap: () {
                                    Get.to(() => const MyAccountScreen());
                                  },
                                ),
                                const DeviderWidget(),
                                MenuWidget(
                                  text: 'ORDER_HISTORY'.tr,
                                  icon: SvgIcon.menuBag,
                                  onTap: () {
                                    Get.to(() => const OrderHistoryScreen());
                                  },
                                ),
                                const DeviderWidget(),
                                MenuWidget(
                                  text: 'RETURN_ORDERS'.tr,
                                  icon: SvgIcon.menuRefresh,
                                  onTap: () {
                                    Get.to(() => const ReturnOrdersScreen());
                                  },
                                ),
                                const DeviderWidget(),
                                MenuWidget(
                                  text: 'EDIT_PROFILE'.tr,
                                  icon: SvgIcon.menuEdit,
                                  onTap: () {
                                    Get.to(() => const EditProfileScreen());
                                  },
                                ),
                                const DeviderWidget(),
                                MenuWidget(
                                  text: 'CHANGE_PASSWORD'.tr,
                                  icon: SvgIcon.menuKey,
                                  onTap: () {
                                    Get.to(() => const ChangePasswordScreen());
                                  },
                                ),
                                const DeviderWidget(),
                                MenuWidget(
                                  text: 'ADDRESSES'.tr,
                                  icon: SvgIcon.menuLocation,
                                  onTap: () {
                                    Get.to(() => const AddressScreen());
                                  },
                                ),
                                const DeviderWidget(),
                              ],
                            )
                          : const SizedBox(),
                      MenuWidget(
                        text: 'CHANGE_LANGUAGE'.tr,
                        icon: SvgIcon.language,
                        onTap: () {
                          Get.to(() => const ChangeLanguageView());
                        },
                      ),
                      const DeviderWidget(),
                      Obx(
                        () => SizedBox(
                          child: profile.pagesMap.isNotEmpty &&
                                  profile.pagesModel?.data != null
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: profile.pagesModel!.data!.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return Column(
                                      children: [
                                        profileItem(
                                          profile.pagesModel!.data![index]
                                              .description,
                                          SvgIcon.tc,
                                          profile
                                              .pagesModel!.data![index].title,
                                        ),
                                        const DeviderWidget(),
                                      ],
                                    );
                                  })
                              : const SizedBox(),
                        ),
                      ),
                      box.read('isLogedIn') != false
                          ? InkWell(
                              onTap: () async {
                                await auth.logout();
                              },
                              child: MenuWidget(
                                  text: 'LOGOUT'.tr, icon: SvgIcon.menuLogout))
                          : const SizedBox(),
                      SizedBox(
                        height: 20.h,
                      ),
                      if (box.read('isLogedIn') == true)
                        PrimaryButton(
                            onTap: () {
                              openDeleteAccountDialog();
                            },
                            text: 'DELETE_ACCOUNT'.tr),
                      SizedBox(
                        height: 40.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            auth.isLoading.value ? const LoaderCircle() : const SizedBox(),
          ],
        ),
      ),
    );
  }

  InkWell profileItem(des, icon, textValue) {
    return InkWell(
      onTap: () => Get.to(() => PagesScreen(
            tittle: textValue,
            description: des,
          )),
      child: SizedBox(
        height: 52.h,
        width: double.infinity,
        child: Center(
          child: Row(
            children: [
              SvgPicture.asset(
                '$icon',
                color: AppColor.error,
                height: 20.h,
                width: 20.w,
              ),
              SizedBox(
                width: 16.w,
              ),
              TextWidget(
                text: '$textValue'.tr,
                color: AppColor.textColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
