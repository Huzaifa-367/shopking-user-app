import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/auth/controller/auth_controler.dart';
import 'package:shopperz/app/modules/auth/controller/swap_title_controller.dart';
import 'package:shopperz/utils/validation_rules.dart';
import 'package:shopperz/widgets/appbar3.dart';
import 'package:shopperz/widgets/loader/loader.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../widgets/custom_form_field.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/form_field_title.dart';
import '../../../../widgets/primary_button.dart';

// ignore: must_be_immutable
class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({super.key, this.emailOrPhone, this.countryCode});
  String? emailOrPhone, countryCode;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final authController = Get.put(AuthController());
  final swapController = Get.put(SwapTitleController());

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
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
      child: Obx(
        () => Stack(
          alignment: Alignment.center,
          children: [
            Scaffold(
              appBar: const AppBarWidget3(
                text: '',
              ),
              backgroundColor: AppColor.primaryBackgroundColor,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),
                          CustomText(
                              text: "Reset Password".tr,
                              color: AppColor.primaryColor,
                              size: 26.sp,
                              weight: FontWeight.w700),
                          SizedBox(height: 20.h),
                          FormFieldTitle(title: "New Password".tr),
                          SizedBox(height: 4.h),
                          CustomFormField(
                            controller: newPasswordController,
                            validator: (password) =>
                                ValidationRules().password(password),
                          ),
                          SizedBox(height: 10.h),
                          FormFieldTitle(title: "Confirm Password".tr),
                          SizedBox(height: 4.h),
                          CustomFormField(
                            controller: confirmPasswordController,
                            validator: (password) {
                              ValidationRules().password(password);
                              if (newPasswordController.text !=
                                  confirmPasswordController.text) {
                                return 'Password Not Matched'.tr;
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          InkWell(
                              onTap: () {
                                if (formkey.currentState!.validate()) {
                                  swapController.isShowEmailField.value
                                      ? authController.resetPasswordWithEmail(
                                          email: widget.emailOrPhone.toString(),
                                          newPassword: newPasswordController.text,
                                          confirmPassword:
                                              confirmPasswordController.text)
                                      : authController.resetPasswordWithPhone(
                                          phone: widget.emailOrPhone.toString(),
                                          newPassword: newPasswordController.text,
                                          confirmPassword:
                                              confirmPasswordController.text,
                                          countryCode:
                                              authController.countryCode);
                                } else {
                                  debugPrint("Login is failed");
                                }
                              },
                              child: PrimaryButton(text: "Submit".tr)),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            authController.isLoading.value
                ? const LoaderCircle()
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
