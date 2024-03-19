import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopperz/app/modules/profile/controller/profile_controller.dart';
import 'package:shopperz/config/theme/app_color.dart';
import 'package:shopperz/data/remote_services/remote_services.dart';
import 'package:shopperz/data/server/app_server.dart';
import 'package:shopperz/utils/api_list.dart';
import 'package:shopperz/widgets/custom_snackbar.dart';
import '../model/address.dart';

class AddressController extends GetxController {
  final formkey = GlobalKey<FormState>();
  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final phoneTextController = TextEditingController();
  final country = "".obs;
  final state = "".obs;
  final city = "".obs;

  String countryCode = '';

  final zipTextController = TextEditingController();
  final streetTextController = TextEditingController();

  ProfileController profile = Get.put(ProfileController());

  final addressModel = AddressModel().obs;
  final isLoading = false.obs;

  submitAddress() async {
    isLoading(true);
    final response = await RemoteServices().submitAddress(
      fullName: nameTextController.text,
      countryCode: countryCode,
      phone: phoneTextController.text,
      streetAddress: streetTextController.text,
      country: country.value,
      city: city.value,
      email: emailTextController.text,
      zip: zipTextController.text,
      state: state.value,
    );

    if (response != null && response.statusCode == 201) {
      isLoading(false);
      profile.getAddress();
      update();
      Get.back();
      customSnackbar("SUCCESS".tr, 'Address Added Successfully!'.toString().tr,
          AppColor.success);
    } else {
      isLoading(false);
      Get.back();
      Future.delayed(const Duration(milliseconds: 10), () {
        customSnackbar("ERROR".tr,
            jsonDecode(response.body)['message'].toString(), AppColor.error);
        update();
      });
    }
  }

  updateAddress({required String id}) async {
    isLoading(true);
    Map body = {
      "full_name": nameTextController.text,
      "email": emailTextController.text,
      "country_code": countryCode,
      "phone": phoneTextController.text,
      "country": country.value,
      "address": streetTextController.text,
      "state": state.value,
      "city": city.value,
      "zip_code": zipTextController.text,
      "latitude": "",
      "longitude": "",
    };
    String jsonBody = json.encode(body);
    AppServer()
        .putRequest(
      endPoint: ApiList.updateAddress + id,
      body: jsonBody,
    )
        .then((response) {
      if (response != null && response.statusCode == 200) {
        isLoading(false);
        profile.getAddress();
        update();
        Future.delayed(const Duration(milliseconds: 10), () {
          customSnackbar("SUCCESS".tr, "ADDRESS_UPDATED_SUCCESSFULLY".tr,
              AppColor.success);
          update();
        });

        Get.back();
      } else {
        isLoading(false);
        Future.delayed(const Duration(milliseconds: 10), () {
          customSnackbar("ERROR".tr, "SOMETHING_WRONG".tr, AppColor.error);
          update();
        });
        Get.back();
      }
    });
    return null;
  }

  deleletAddress({required String id}) async {
    final store = GetStorage();
    var token = store.read('token');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json, text/plain, */*",
      "Access-Control-Allow-Origin": "*",
      // "x-api-key": ApiList.licenseCode.toString(),
      'Authorization': token
    };
    isLoading(true);
    AppServer()
        .deleteRequest(endPoint: ApiList.deleteAddress + id, headers: headers)
        .then((response) {
      if (response != null && response.statusCode == 202) {
        isLoading(false);
        profile.getAddress();
        update();
        Get.back();
        customSnackbar(
            "SUCCESS".tr, "ADDRESS_DELETED_SUCCESSFULLY".tr, AppColor.success);
      } else {
        isLoading(false);
        Get.back();
        Future.delayed(const Duration(milliseconds: 10), () {
          customSnackbar("ERROR".tr, "SOMETHING_WRONG".tr, AppColor.error);
          update();
        });
      }
    });
  }
}
