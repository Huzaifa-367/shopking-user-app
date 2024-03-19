import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/auth/controller/auth_controler.dart';
import 'package:shopperz/app/modules/profile/controller/profile_controller.dart';
import 'package:shopperz/app/modules/profile/widgets/add_new_address.dart';
import 'package:shopperz/app/modules/profile/widgets/address_widget.dart';
import 'package:shopperz/main.dart';
import 'package:shopperz/utils/images.dart';
import 'package:shopperz/widgets/appbar3.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../utils/svg_icon.dart';
import '../../../../widgets/custom_text.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  ProfileController profile = Get.put(ProfileController());
  AuthController auth = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    if (box.read('isLogedIn') != false) {
      profile.getAddress();
    }
    auth.getCountryCode();
    auth.getSetting();
  }

  openAddressDialog() {
    Get.dialog(Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.only(top: 20.h, bottom: 20.h),
      child: const AddNewAddressDialog(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColor.primaryBackgroundColor,
        appBar: const AppBarWidget3(
          text: '',
        ),
        body: RefreshIndicator(
          color: AppColor.primaryColor,
          onRefresh: () async {
            if (box.read('isLogedIn') != false) {
              profile.getAddress();
            }
            auth.getCountryCode();
            auth.getSetting();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomText(
                    text: "Address".tr,
                    size: 22.sp,
                    weight: FontWeight.w700,
                    color: AppColor.primaryColor,
                  ),
                  SizedBox(height: 20.h),
                  Obx(
                    () => profile.addressMap.isNotEmpty && profile.addressModel!.data!.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: profile.addressModel!.data!.length,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.only(bottom: 15.h),
                              child: AddressWidget(
                                address: profile.addressModel!.data![index],
                              ),
                            ),
                          )
                        : Center(
                                child: Image.asset(AppImages.emptyIcon,height: 300.h,width: 300.w,),
                              ),
                  ),
                  SizedBox(height: 20.h),
                  InkWell(
                    onTap: () {
                      openAddressDialog();
                    },
                    child: Container(
                      height: 118.h,
                      width: 328.w,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor1,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            SvgIcon.moreCircle,
                            height: 20.h,
                            width: 20.w,
                          ),
                          SizedBox(width: 8.w),
                          CustomText(
                            text: "Add New Address".tr,
                            size: 18.sp,
                            color: AppColor.primaryColor,
                            weight: FontWeight.w600,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
