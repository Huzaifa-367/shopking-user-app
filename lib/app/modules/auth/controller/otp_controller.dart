import 'dart:convert';

import 'package:get/get.dart';
import 'package:shopperz/app/modules/auth/controller/auth_controler.dart';
import 'package:shopperz/app/modules/auth/models/user_model.dart';
import 'package:shopperz/app/modules/auth/views/reset_password.dart';
import 'package:shopperz/app/modules/navbar/views/navbar_view.dart';
import 'package:shopperz/config/theme/app_color.dart';
import 'package:shopperz/main.dart';
import 'package:shopperz/widgets/custom_snackbar.dart';

import '../../../../data/server/app_server.dart';
import '../../../../utils/api_list.dart';

class OTPController extends GetxController {
  final isLoading = false.obs;
  final resendLoading = false.obs;
  final userModel = UserModel().obs;

  AuthController authController = Get.put(AuthController());

  Future<void> verifyOTPWithEmail(
      {required String email, required String token}) async {
    isLoading(true);
    try {
      final resonse =
          await AppServer().httpPost(endPoint: ApiList.verifyEmail, body: {
        "email": email,
        "token": token,
      });

      if (resonse.statusCode == 200) {
        isLoading(false);
        authController.registrationWithEmail(
            name: authController.nameController.text,
            email: email,
            password: authController.passController.text);

        final token = jsonDecode(resonse.body)["token"];
        box.write("token", 'Bearer $token');
        box.write("isLogedIn", true);
        Get.offAll(() => const NavBarView());
      } else {
        isLoading(false);
        customSnackbar("ERROR".tr,
            jsonDecode(resonse.body)["message"].toString().tr, AppColor.error);
      }
    } catch (e) {
      isLoading(false);
      customSnackbar("ERROR".tr, e.toString(), AppColor.error);
    }
  }

  Future<void> verifyOTPWithPhone(
      {required String phone,
      required String token,
      required String country_code}) async {
    isLoading(true);
    try {
      final resonse =
          await AppServer().httpPost(endPoint: ApiList.verifyPhone, body: {
        "phone": phone,
        "country_code": country_code,
        "token": token,
      });

      if (resonse.statusCode == 200) {
        isLoading(false);
        authController.registrationWithPhone(
            name: authController.nameController.text,
            phone: authController.phoneController.text,
            countryCode: authController.countryCode,
            password: authController.passController.text);

        final token = jsonDecode(resonse.body)["token"];
        box.write("token", 'Bearer $token');
        box.write("isLogedIn", true);
        Get.offAll(() => const NavBarView());
      } else {
        isLoading(false);
        customSnackbar("ERROR".tr,
            jsonDecode(resonse.body)["message"].toString().tr, AppColor.error);
      }
    } catch (e) {
      isLoading(false);
      customSnackbar("ERROR".tr, e.toString(), AppColor.error);
    }
  }

  Future<void> verifyOTPWithEmailForForget(
      {required String email, required String token}) async {
    isLoading(true);
    try {
      final resonse = await AppServer()
          .httpPost(endPoint: ApiList.verifyForgotEmail, body: {
        "email": email,
        "token": token,
      });

      if (resonse.statusCode == 200) {
        isLoading(false);
        customSnackbar(
            "SUCCESS".tr,
            jsonDecode(resonse.body)["message"].toString().tr,
            AppColor.success);
        Get.to(() => ResetPasswordScreen());
      } else {
        isLoading(false);
        customSnackbar("ERROR".tr,
            jsonDecode(resonse.body)["message"].toString().tr, AppColor.error);
      }
    } catch (e) {
      isLoading(false);
      customSnackbar("ERROR".tr, e.toString(), AppColor.error);
    }
  }

  Future<void> verifyOTPWithPhoneForForget(
      {required String phone,
      required String token,
      required String country_code}) async {
    isLoading(true);
    try {
      final resonse = await AppServer()
          .httpPost(endPoint: ApiList.verifyForgotPhone, body: {
        "phone": phone,
        "country_code": country_code,
        "token": token,
      });

      if (resonse.statusCode == 200) {
        isLoading(false);
        customSnackbar(
            "SUCCESS".tr,
            jsonDecode(resonse.body)["message"].toString().tr,
            AppColor.success);
        Get.to(() => ResetPasswordScreen());
      } else {
        isLoading(false);
        customSnackbar("ERROR".tr,
            jsonDecode(resonse.body)["message"].toString().tr, AppColor.error);
      }
    } catch (e) {
      isLoading(false);
      customSnackbar("ERROR".tr, e.toString(), AppColor.error);
    }
  }

  Future<void> sendOTPWithEmail({required String email}) async {
    try {
      final resonse =
          await AppServer().httpPost(endPoint: ApiList.resendOTPEmail, body: {
        "email": email,
      });

      if (resonse.statusCode == 200) {
        customSnackbar(
            "SUCCESS".tr,
            jsonDecode(resonse.body)["message"].toString().tr,
            AppColor.success);
      } else {
        customSnackbar("ERROR".tr,
            jsonDecode(resonse.body)["message"].toString().tr, AppColor.error);
      }
    } catch (e) {
      customSnackbar("ERROR".tr, e.toString(), AppColor.error);
    }
  }

  Future<void> sendOTPWithPhone(
      {required String phone, required String country_code}) async {
    try {
      final resonse =
          await AppServer().httpPost(endPoint: ApiList.resendOTPPhone, body: {
        "phone": phone,
        "country_code": country_code,
      });

      if (resonse.statusCode == 200) {
        customSnackbar(
            "SUCCESS".tr,
            jsonDecode(resonse.body)["message"].toString().tr,
            AppColor.success);
      } else {
        customSnackbar("ERROR".tr,
            jsonDecode(resonse.body)["message"].toString().tr, AppColor.error);
      }
    } catch (e) {
      customSnackbar("ERROR".tr, e.toString(), AppColor.error);
    }
  }

  Future<void> resendOTPWithEmail({required String email}) async {
    isLoading(true);
    try {
      final resonse =
          await AppServer().httpPost(endPoint: ApiList.resendOTPEmail, body: {
        "email": email,
      });

      if (resonse.statusCode == 200) {
        isLoading(false);
        customSnackbar(
            "SUCCESS".tr,
            jsonDecode(resonse.body)["message"].toString().tr,
            AppColor.success);
      } else {
        isLoading(false);
        customSnackbar("ERROR".tr,
            jsonDecode(resonse.body)["message"].toString().tr, AppColor.error);
      }
    } catch (e) {
      isLoading(false);
      customSnackbar("ERROR".tr, e.toString(), AppColor.error);
    }
  }

  Future<void> resendOTPWithPhone(
      {required String phone, required String country_code}) async {
    isLoading(true);
    try {
      final resonse =
          await AppServer().httpPost(endPoint: ApiList.resendOTPPhone, body: {
        "phone": phone,
        "country_code": country_code,
      });

      if (resonse.statusCode == 200) {
        isLoading(false);
        customSnackbar(
            "SUCCESS".tr,
            jsonDecode(resonse.body)["message"].toString().tr,
            AppColor.success);
      } else {
        isLoading(false);
        customSnackbar("ERROR".tr,
            jsonDecode(resonse.body)["message"].toString().tr, AppColor.error);
      }
    } catch (e) {
      isLoading(false);
      customSnackbar("ERROR".tr, e.toString(), AppColor.error);
    }
  }

  Future<void> resendOTPWithEmailForForget({required String email}) async {
    isLoading(true);
    try {
      final resonse = await AppServer()
          .httpPost(endPoint: ApiList.resendForgotOTPEmail, body: {
        "email": email,
      });

      if (resonse.statusCode == 200) {
        isLoading(false);
        customSnackbar(
            "SUCCESS".tr,
            jsonDecode(resonse.body)["message"].toString().tr,
            AppColor.success);
      } else {
        isLoading(false);
        customSnackbar(
            "ERROR".tr,
            jsonDecode(resonse.body)["errors"]['email'][0].toString().tr,
            AppColor.error);
      }
    } catch (e) {
      isLoading(false);
      customSnackbar("ERROR".tr, e.toString(), AppColor.error);
    }
  }

  Future<void> resendOTPWithPhoneForForget(
      {required String phone, required String country_code}) async {
    isLoading(true);
    try {
      final resonse = await AppServer()
          .httpPost(endPoint: ApiList.resendForgotOTPPhone, body: {
        "phone": phone,
        "country_code": country_code,
      });

      if (resonse.statusCode == 200) {
        isLoading(false);
        customSnackbar(
            "SUCCESS".tr,
            jsonDecode(resonse.body)["message"].toString().tr,
            AppColor.success);
      } else {
        isLoading(false);
        customSnackbar(
            "ERROR".tr,
            jsonDecode(resonse.body)["errors"]['phone'][0].toString().tr,
            AppColor.error);
      }
    } catch (e) {
      isLoading(false);
      customSnackbar("ERROR".tr, e.toString(), AppColor.error);
    }
  }
}
