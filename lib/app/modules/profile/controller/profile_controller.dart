import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopperz/app/modules/auth/controller/auth_controler.dart';
import 'package:shopperz/app/modules/navbar/views/navbar_view.dart';
import 'package:shopperz/app/modules/profile/widgets/image_size_chekcer.dart';
import 'package:shopperz/data/model/pages_model.dart';
import 'package:shopperz/data/model/profile_address_model.dart';
import 'package:shopperz/data/model/profile_model.dart';
import 'package:shopperz/data/model/total_complete_orders_model.dart';
import 'package:shopperz/data/model/total_orders_count_model.dart';
import 'package:shopperz/data/model/total_return_orders_model.dart';
import 'package:shopperz/data/model/total_wallet_balance.dart';
import 'package:shopperz/data/repository/profile_repo.dart';
import 'package:shopperz/data/server/app_server.dart';
import 'package:shopperz/utils/api_list.dart';
import 'package:shopperz/widgets/custom_snackbar.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../config/theme/app_color.dart';
import '../../navbar/controller/navbar_controller.dart';

class ProfileController extends GetxController {
  ProfileModel? profileModel;
  PagesModel? pagesModel;
  ProfileAddressModel? addressModel;
  TotalOrdersCount? totalOrdersCount;
  TotalCompleteOrdersCount? totalCompleteOrdersCount;
  TotalReturnOrdersCount? totalReturnOrdersCount;
  TotalWalletBalance? totalWalletBalance;

  RxList<ProfileModel> profileMap = <ProfileModel>[].obs;
  RxList<PagesModel> pagesMap = <PagesModel>[].obs;
  RxList<ProfileAddressModel> addressMap = <ProfileAddressModel>[].obs;
  RxList<TotalOrdersCount> totalOrdersCountMap = <TotalOrdersCount>[].obs;
  RxList<TotalCompleteOrdersCount> totalCompleteOrdersCountMap =
      <TotalCompleteOrdersCount>[].obs;
  RxList<TotalReturnOrdersCount> totalReturnOrdersCountMap =
      <TotalReturnOrdersCount>[].obs;
  RxList<TotalWalletBalance> totalWalletBalanceMap = <TotalWalletBalance>[].obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  AuthController authController = Get.put(AuthController());

  final isLoading = false.obs;

  final accountBalance = 0.0.obs;

  String? imagePath;
  File? file;

  final box = GetStorage();

  AppServer server = AppServer();

  @override
  void onInit() {
    final box = GetStorage();
    if (box.read('isLogedIn') != false) {
      getProfile();
      getAddress();
      getTotalOrdersCount();
      getTotalCompleteOrdersCount();
      getTotalReturnOrdersCount();
      getTotalWalletBalance();
      authController.getCountryCode();
      authController.getSetting();
    }
    getPages();
    super.onInit();
  }

  getProfile() async {
    profileModel = await ProfileRepo.getProfile();

    nameController.text = profileModel!.data!.name ?? "";
    emailController.text = profileModel!.data!.email ?? "";
    phoneController.text = profileModel!.data!.phone ?? "";
    countryCodeController.text = profileModel!.data!.countryCode ?? "";
    accountBalance.value = double.parse(profileModel!.data!.balance.toString());

    update();

    profileMap.add(profileModel!);

    refresh();
  }

  getPages() async {
    var page = await ProfileRepo.getPages();

    if (page.data != null) {
      pagesModel = page;
      pagesMap.add(pagesModel!);
    }

    refresh();
  }

  Future getImageFromGallary() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    double imageSize = await ImageSize.getImageSize(image!);
    file = File(image.path);
    if (imageSize > 2) {
      customSnackbar(
          "ERROR".tr, "IMAGE_SHOULD_BE_LESS_THAN_2MB".tr, AppColor.error);
    } else {
      updateProfileImage(image.path);
    }
  }

  updateProfileImage(file) async {
    isLoading(true);
    update();
    await server
        .multipartRequest(ApiList.changeImage, file)
        .then((response) async {
      if (response != null) {
        isLoading(false);
        update();
        getProfile();
        customSnackbar("SUCCESS".tr, "PROFILE_IMAGE_SAVED_SUCCESSFULLY".tr,
            AppColor.success);
        update();
      } else {
        isLoading(false);
        update();
        customSnackbar("ERROR".tr, "SOMETHING_WRONG".tr, AppColor.error);
      }
    });
  }

  updateUserProfile(context) async {
    isLoading(true);
    update();
    Map<String, String>? body = {
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'country_code': countryCodeController.text.toString() == ''
          ? authController.countryCode.toString()
          : countryCodeController.text.toString(),
    };
    String jsonBody = json.encode(body);

    await server
        .putRequest(
      endPoint: ApiList.profileUpdate,
      body: jsonBody,
    )
        .then((response) async {
      final jsonResponse = json.decode(response.body);
      if (response != null && response.statusCode == 200) {
        await getProfile();
        isLoading(false);
        update();
        Get.back();
        customSnackbar("PROFILE_UPDATE".tr, 'PROFILE_UPDATE_SUCCESSFULLY'.tr,
            AppColor.success);
      } else if (jsonResponse['message'] != null) {
        isLoading(false);
        update();
        customSnackbar(
            "ERROR".tr, jsonResponse['message'].toString().tr, AppColor.error);
      } else {
        isLoading(false);
        update();
        customSnackbar("ERROR".tr, "SOMETHING_WRONG".tr, AppColor.error);
      }
    });
  }

  updateUserPassword() async {
    isLoading(true);
    update();
    Map<String, String>? body = {
      'old_password': oldPasswordController.text,
      'new_password': newPasswordController.text,
      'confirm_password': confirmPasswordController.text,
    };
    String jsonBody = json.encode(body);
    await server
        .putRequest(
      endPoint: ApiList.changePassword,
      body: jsonBody,
    )
        .then((response) {
      print(response.body);
      if (response != null && response.statusCode == 200) {
        isLoading(false);
        getProfile();
        update();
        oldPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
        Get.back();
        customSnackbar('CHANGE_PASSWORD'.tr, 'PASSWORD_UPDATE_SUCCESSFULLY'.tr,
            AppColor.success);
      } else if (response != null && response.statusCode == 422) {
        var message = jsonDecode(response.body);

        if (message['errors']['new_password'] != null) {
          customSnackbar(
              'CHANGE_PASSWORD'.tr,
              message['errors']['new_password'][0].toString().tr,
              AppColor.error);
        }
        if (message['errors']['old_password'] != null) {
          customSnackbar(
              'CHANGE_PASSWORD'.tr,
              message['errors']['old_password'][0].toString().tr,
              AppColor.error);
        }
        isLoading(false);
        Future.delayed(const Duration(milliseconds: 10), () {
          update();
        });
      } else {
        isLoading(false);
        Future.delayed(const Duration(milliseconds: 10), () {
          update();
        });
        customSnackbar('CHANGE_PASSWORD'.tr, 'PLEASE_ENTER_VALID_INPUT'.tr,
            AppColor.error);
      }
    });
  }

  getAddress() async {
    addressModel = await ProfileRepo.getAddress();
    addressMap.add(addressModel!);

    refresh();
  }

  getTotalOrdersCount() async {
    totalOrdersCount = await ProfileRepo.getTotalOrdersCount();

    totalOrdersCountMap.add(totalOrdersCount!);

    refresh();
  }

  getTotalCompleteOrdersCount() async {
    totalCompleteOrdersCount = await ProfileRepo.getTotalCompleteOrdersCount();

    totalCompleteOrdersCountMap.add(totalCompleteOrdersCount!);

    refresh();
  }

  getTotalReturnOrdersCount() async {
    totalReturnOrdersCount = await ProfileRepo.getTotalReturnOrdersCount();

    totalReturnOrdersCountMap.add(totalReturnOrdersCount!);

    refresh();
  }

  getTotalWalletBalance() async {
    totalWalletBalance = await ProfileRepo.getTotalWalletBalance();

    totalWalletBalanceMap.add(totalWalletBalance!);

    refresh();
  }

  deleteAccount() async {
    isLoading(true);
    server
        .postRequestWithToken(endPoint: ApiList.deleteAccount)
        .then((response) {
      if (response != null && response.statusCode == 200) {
        isLoading(false);
        update();
        final jsonResponse = json.decode(response.body);
        box.write('isLogedIn', false);
        final navController = Get.put(NavbarController());
        Get.offAll(const NavBarView());
        navController.selectPage(0);
        customSnackbar("ACCOUNT".tr, jsonResponse['message'].toString().tr,
            AppColor.success);
      } else if (response != null && response.statusCode == 422) {
        final jsonResponse = json.decode(response.body);
        isLoading(false);
        update();
        String errorMessage = jsonResponse['message'].toString();
        customSnackbar("ERROR".tr, errorMessage, AppColor.error);
        update();
      }
      isLoading(false);
      update();
    });
    return null;
  }
}
