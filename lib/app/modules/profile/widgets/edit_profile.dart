import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopperz/app/modules/auth/controller/auth_controler.dart';
import 'package:shopperz/app/modules/profile/controller/profile_controller.dart';
import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/widgets/appbar3.dart';
import 'package:shopperz/widgets/loader/loader.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../widgets/custom_form_field.dart';
import '../../../../widgets/custom_phone_form_field.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/form_field_title.dart';
import '../../../../widgets/primary_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ProfileController profileController = Get.put(ProfileController());

  final authController = Get.put(AuthController());

  bool validate = false;

  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.getProfile();
    authController.getSetting();
    authController.getCountryCode();
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
      child: GetBuilder<ProfileController>(
        builder: (profileController) => Stack(
          alignment: Alignment.center,
          children: [
            Scaffold(
              backgroundColor: AppColor.primaryBackgroundColor,
              appBar: const AppBarWidget3(text: '',),
              body: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomText(
                      text: "Edit Profile".tr,
                      color: AppColor.primaryColor,
                      size: 22.sp,
                      weight: FontWeight.w700,
                    ),
                    SizedBox(height: 30.h),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormFieldTitle(title: "Full Name".tr),
                          SizedBox(height: 4.h),
                          CustomFormField(
                            controller: profileController.nameController,
                            validator: (value) => value!.isEmpty
                                          ? 'PLEASE_TYPE_Name'.tr
                                          : null,
                          ),
                          SizedBox(height: 20.h),
                          FormFieldTitle(title: "Email".tr),
                          SizedBox(height: 4.h),
                          CustomFormField(
                            controller: profileController.emailController,
                            validator: (value) => value!.isEmpty
                                          ? 'PLEASE_TYPE_EMAIL'.tr
                                          : null,
                          ),
                          SizedBox(height: 20.h),
                          FormFieldTitle(title: "Phone".tr),
                          SizedBox(height: 4.h),
                          CustomPhoneFormField(
                            phoneController: profileController.phoneController,
                            validator: (value) => value!.isEmpty
                                          ? 'PLEASE_TYPE_PHONE_NUMBER'.tr
                                          : null,
                            prefix: Padding(
                                  padding:  EdgeInsets.only(left: 10.w),
                                  child: PopupMenuButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.r),
                                        ),
                                      ),
                                      position: PopupMenuPosition.under,
                                      itemBuilder: (ctx) => List.generate(
                                          authController.countryCodeModel!.data!.length,
                                          (index) => PopupMenuItem(
                                            height: 32.h,
                                                onTap: () async {
                                                  setState(() {
                                                    profileController.countryCodeController.text = authController.countryCodeModel!.data![index].callingCode.toString();
                                                  });
                                                },
                                                child: Text(
                                                  authController.countryCodeModel!.data![index].callingCode.toString(),
                                                  style: GoogleFonts.urbanist(
                                                      color: AppColor.textColor,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 16.sp),
                                                ),
                                              )),
                                    child: Row(
                                          children: [
                                            Text(
                                              profileController.countryCodeController.text.toString() == '' ? authController.countryCode.toString() : profileController.countryCodeController.text.toString(),
                                              style: GoogleFonts.urbanist(
                                                  color: AppColor.textColor,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500
                                                ),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            SvgPicture.asset(SvgIcon.down)
                                          ],
                                        ),
                                  ),
                                ),
                          ),
                          SizedBox(height: 30.h),
                          PrimaryButton(
                            text: "Save Changes".tr,
                            width: 153.w,
                            onTap: () {
                              validateAndSave(context);
                                      (context as Element).markNeedsBuild();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ),
            profileController.isLoading.value
                  ? LoaderCircle()
                  : SizedBox(),
          ],
        ),
      ),
    );
  }

  void validateAndSave(context) {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      Get.find<ProfileController>().updateUserProfile(context);
      validate = true;
    } else {
      validate = false;
    }
  }
}
