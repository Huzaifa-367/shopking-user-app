import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopperz/app/modules/auth/controller/auth_controler.dart';
import 'package:shopperz/app/modules/auth/controller/swap_title_controller.dart';
import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/utils/validation_rules.dart';
import 'package:shopperz/widgets/appbar3.dart';
import 'package:shopperz/widgets/loader/loader.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/primary_button.dart';
import '../widgets/swap_field_title.dart';
import '../widgets/swap_form_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final authController = Get.put(AuthController());
  final swapController = Get.put(SwapTitleController());

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authController.getSetting();
    authController.getCountryCode();
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
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
      child: Obx(() => Stack(
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
                                text: "Forgot Password".tr,
                                color: AppColor.primaryColor,
                                size: 26.sp,
                                weight: FontWeight.w700),
                            SizedBox(height: 20.h),
                            const SwapFieldTitle(),
                            SizedBox(height: 4.h),
                            SwapFormField(
                              emailController: emailController,
                              emailValidator: (email) =>
                                  ValidationRules().email(email),
                              phoneController: phoneController,
                              prefix: Padding(
                                padding: EdgeInsets.only(left: 10.w),
                                child: PopupMenuButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.r),
                                    ),
                                  ),
                                  position: PopupMenuPosition.under,
                                  itemBuilder: (ctx) => List.generate(
                                      authController
                                          .countryCodeModel!.data!.length,
                                      (index) => PopupMenuItem(
                                            height: 32.h,
                                            onTap: () async {
                                              setState(() {
                                                authController.countryCode =
                                                    authController
                                                        .countryCodeModel!
                                                        .data![index]
                                                        .callingCode
                                                        .toString();
                                              });
                                            },
                                            child: Text(
                                              authController.countryCodeModel!
                                                  .data![index].callingCode
                                                  .toString(),
                                              style: GoogleFonts.urbanist(
                                                  color: AppColor.textColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16.sp),
                                            ),
                                          )),
                                  child: Row(
                                    children: [
                                      Text(
                                        authController.countryCode,
                                        style: GoogleFonts.urbanist(
                                            color: AppColor.textColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      SvgPicture.asset(SvgIcon.down)
                                    ],
                                  ),
                                ),
                              ),
                              phoneValidator: (phone) =>
                                  ValidationRules().normal(phone),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            PrimaryButton(
                              text: "Get OTP".tr,
                              onTap: () {
                                if (formkey.currentState!.validate()) {
                                  swapController.isShowEmailField.value
                                      ? authController.forgotPasswordWithEmail(
                                          email: emailController.text)
                                      : authController.forgotPasswordWithPhone(
                                          phone: phoneController.text,
                                          country_code:
                                              authController.countryCode);
                                } else {
                                  debugPrint("Login is failed");
                                }
                              },
                            ),
                            SizedBox(height: 20.h),
                            GestureDetector(
                              onTap: () {
                                Get.back();
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
              authController.isLoading.value
                  ? const LoaderCircle()
                  : const SizedBox()
            ],
          )),
    );
  }
}
