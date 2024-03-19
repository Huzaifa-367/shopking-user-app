import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/coupon/model/apply_coupon.dart';
import 'package:shopperz/app/modules/shipping/model/coupon.dart';
import 'package:shopperz/config/theme/app_color.dart';
import 'package:shopperz/data/remote_services/remote_services.dart';
import 'package:shopperz/main.dart';
import 'package:shopperz/widgets/custom_snackbar.dart';

class CouponController extends GetxController {
  final isLoading = false.obs;
  final couponSubmitLoader = false.obs;
  final couponFormKey = GlobalKey<FormState>();
  final couponModel = CouponModel().obs;
  final applyCouponModel = ApplyCoupon().obs;
  final selectedCouponIndex = RxInt(-1);
  final couponCode = "".obs;
  final discountPrice = "".obs;
  final couponTextController = TextEditingController();
  final applyCouponStatus = false.obs;

  Future<void> fetchCoupon() async {
    isLoading(true);
    final data = await RemoteServices().fetchCoupon();

    isLoading(false);

    data.fold((error) {
      isLoading(false);
      customSnackbar("ERROR".tr, error, AppColor.error);
    }, (coupon) {
      isLoading(false);
      couponModel.value = coupon;
    });
  }

  Future<void> submitCoupon(
      {required String code, required String total}) async {
    couponSubmitLoader(true);
    final data = await RemoteServices().submitCoupon(code: code, total: total);
    couponSubmitLoader(false);

    data.fold((error) {
      couponSubmitLoader(false);
      applyCouponStatus.value = box.read("applyCoupon");
      customSnackbar("ERROR".tr, error, AppColor.error);
    }, (applyCoupon) {
      applyCouponStatus.value = box.read("applyCoupon");

      couponSubmitLoader(false);
      applyCouponModel.value = applyCoupon;
      customSnackbar("SUCCESS".tr, 'Coupon Applied'.tr, AppColor.success);
    });
  }

  @override
  void onInit() {
    fetchCoupon();
    super.onInit();
  }

  setCoupon(String code) {
    couponCode.value = code;
  }
}
