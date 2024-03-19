import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/auth/controller/otp_controller.dart';
import 'package:shopperz/app/modules/auth/controller/swap_title_controller.dart';
import 'package:shopperz/app/modules/auth/views/sign_in.dart';
import 'package:shopperz/utils/validation_rules.dart';
import 'package:shopperz/widgets/appbar3.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../widgets/custom_form_field.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/form_field_title.dart';
import '../../../../widgets/loader/loader.dart';
import '../../../../widgets/primary_button.dart';

// ignore: must_be_immutable
class ForgetOTPScreen extends StatefulWidget {
  ForgetOTPScreen({super.key, this.emailOrPhone, this.countryCode});
  String? emailOrPhone, countryCode;

  @override
  State<ForgetOTPScreen> createState() => _ForgetOTPScreenState();
}

class _ForgetOTPScreenState extends State<ForgetOTPScreen> {
  final formkey = GlobalKey<FormState>();
  final tokenTextController = TextEditingController();
  final otpController = Get.put(OTPController());
  final swapController = Get.put(SwapTitleController());

  @override
  void dispose() {
    tokenTextController.dispose();
    otpController.dispose();
    super.dispose();
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
              appBar: const AppBarWidget3(text: ''),
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
                              text: swapController.isShowEmailField.value
                                  ? "Verify Email".tr
                                  : "Verify Number".tr,
                              color: AppColor.primaryColor,
                              size: 26.sp,
                              weight: FontWeight.w700),
                          SizedBox(height: 20.h),
                          FormFieldTitle(title: "Enter OTP".tr),
                          SizedBox(height: 4.h),
                          CustomFormField(
                              controller: tokenTextController,
                              keyboardType: TextInputType.number,
                              validator: (token) =>
                                  ValidationRules().normal(token)),
                          SizedBox(height: 10.h),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                    text: "If you didn't receive a code!".tr,
                                    size: 14.sp,
                                    weight: FontWeight.w500),
                                InkWell(
                                  onTap: () {
                                    swapController.isShowEmailField.value
                                        ? otpController
                                            .resendOTPWithEmailForForget(
                                                email: widget.emailOrPhone
                                                    .toString())
                                        : otpController
                                            .resendOTPWithPhoneForForget(
                                                phone: widget.emailOrPhone
                                                    .toString(),
                                                country_code: widget.countryCode
                                                    .toString());
                                  },
                                  child: CustomText(
                                    text: " Resend".tr,
                                    color: AppColor.primaryColor,
                                    weight: FontWeight.w700,
                                    size: 14.sp,
                                  ),
                                )
                              ]),
                          SizedBox(
                            height: 24.h,
                          ),
                          PrimaryButton(
                            text: "Verify".tr,
                            onTap: () {
                              if (formkey.currentState!.validate()) {
                                swapController.isShowEmailField.value
                                    ? otpController.verifyOTPWithEmailForForget(
                                        email: widget.emailOrPhone.toString(),
                                        token: tokenTextController.text)
                                    : otpController.verifyOTPWithPhoneForForget(
                                        phone: widget.emailOrPhone.toString(),
                                        country_code:
                                            widget.countryCode.toString(),
                                        token: tokenTextController.text);
                              }
                            },
                          ),
                          SizedBox(height: 20.h),
                          GestureDetector(
                            onTap: () {
                              Get.offAll(() => const SignInScreen());
                            },
                            child: CustomText(
                                text: "Back to sign in".tr,
                                color: AppColor.primaryColor,
                                weight: FontWeight.w700,
                                size: 16.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            otpController.isLoading.value
                ? const LoaderCircle()
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
