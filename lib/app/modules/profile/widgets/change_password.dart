import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/profile/controller/profile_controller.dart';
import 'package:shopperz/widgets/appbar3.dart';
import 'package:shopperz/widgets/loader/loader.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../widgets/custom_form_field.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/form_field_title.dart';
import '../../../../widgets/primary_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ProfileController profileController = Get.put(ProfileController());

  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool validate = false;


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
      child: Obx(
        ()=> Stack(
          alignment: Alignment.center,
          children: [
            Scaffold(
              backgroundColor: AppColor.primaryBackgroundColor,
              resizeToAvoidBottomInset: true,
              appBar: AppBarWidget3(text: '',),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Change Password".tr,
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
                            FormFieldTitle(title: "Old Password".tr),
                            SizedBox(height: 4.h),
                            CustomFormField(
                              controller: profileController.oldPasswordController,
                                    validator: (value) => value!.isEmpty
                                                  ? 'PLEASE_TYPE_OLD_PASSWORD'.tr
                                                  : null,
                              obsecure: true,
                            ),
                            SizedBox(height: 20.h),
                            FormFieldTitle(title: "New Password".tr),
                            SizedBox(height: 4.h),
                            CustomFormField(
                              controller: profileController.newPasswordController,
                                    validator: (value) => value!.isEmpty
                                                  ? 'PLEASE_TYPE_NEW_PASSWORD'.tr
                                                  : null,
                              obsecure: true,
                            ),
                            SizedBox(height: 20.h),
                            FormFieldTitle(title: "Confirm Password".tr),
                            SizedBox(height: 4.h),
                            CustomFormField(
                              controller: profileController.confirmPasswordController,
                                    validator: (value) => value!.isEmpty
                                                  ? 'PLEASE_TYPE_CONFIRM_PASSWORD'.tr : value != profileController.newPasswordController.text ? 'PASSWORD_NOT_MATCHED'.tr
                                                  : null,
                              obsecure: true,
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
                ),
              ),
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
      profileController.updateUserPassword();
      validate = true;
    } else {
      validate = false;
    }
  }

}
