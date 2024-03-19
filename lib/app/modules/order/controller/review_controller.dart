import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopperz/app/modules/order/controller/order_controller.dart';
import 'package:shopperz/app/modules/order/views/order_history_screen.dart';
import 'package:shopperz/config/theme/app_color.dart';
import 'package:shopperz/data/model/review_details_model.dart';
import 'package:shopperz/data/repository/review_repo.dart';
import 'package:shopperz/data/server/app_server.dart';
import 'package:shopperz/utils/api_list.dart';
import 'package:shopperz/widgets/custom_snackbar.dart';

class ReviewController extends GetxController {
  ReviewDetailsModel? reviewDetailsModel;

  RxList<ReviewDetailsModel> reviewDetailsMap = <ReviewDetailsModel>[].obs;

  final isLoading = false.obs;

  final box = GetStorage();

  AppServer server = AppServer();

  String image1 = '', image2 = '', image3 = '', image4 = '', image5 = '';

  int? star;

  TextEditingController reviewText = TextEditingController();

  @override
  void onInit() {
    final box = GetStorage();
    if (box.read('isLogedIn') != false) {}
    super.onInit();
  }

  getReviewDetails({required String review_id}) async {
    var details = await ReviewRepo.getReviewDetails(review_id: review_id);

    if (details.data != null) {
      reviewDetailsModel = details;
      reviewDetailsMap.add(reviewDetailsModel!);
    }

    refresh();

    if (reviewDetailsMap.isNotEmpty) {
      reviewText.text = reviewDetailsModel!.data!.review.toString();
      star = reviewDetailsModel!.data!.star;

      update();

      if (reviewDetailsModel!.data!.images!.length == 0) {
        image1 = '';
        image2 = '';
        image3 = '';
        image4 = '';
        image5 = '';
      } else if (reviewDetailsModel!.data!.images!.length == 1) {
        image1 = reviewDetailsModel!.data!.images![0];
        image2 = '';
        image3 = '';
        image4 = '';
        image5 = '';
      } else if (reviewDetailsModel!.data!.images!.length == 2) {
        image1 = reviewDetailsModel!.data!.images![0];
        image2 = reviewDetailsModel!.data!.images![1];
        image3 = '';
        image4 = '';
        image5 = '';
      } else if (reviewDetailsModel!.data!.images!.length == 3) {
        image1 = reviewDetailsModel!.data!.images![0];
        image2 = reviewDetailsModel!.data!.images![1];
        image3 = reviewDetailsModel!.data!.images![2];
        image4 = '';
        image5 = '';
      } else if (reviewDetailsModel!.data!.images!.length == 4) {
        image1 = reviewDetailsModel!.data!.images![0];
        image2 = reviewDetailsModel!.data!.images![1];
        image3 = reviewDetailsModel!.data!.images![2];
        image4 = reviewDetailsModel!.data!.images![3];
        image5 = '';
      } else if (reviewDetailsModel!.data!.images!.length == 5) {
        image1 = reviewDetailsModel!.data!.images![0];
        image2 = reviewDetailsModel!.data!.images![1];
        image3 = reviewDetailsModel!.data!.images![2];
        image4 = reviewDetailsModel!.data!.images![3];
        image5 = reviewDetailsModel!.data!.images![4];
      }
    } else {
      reviewText.text = '';
      star = 0;

      image1 = '';
      image2 = '';
      image3 = '';
      image4 = '';
      image5 = '';
    }
    refresh();
  }

  reviewSubmit(
      {required String product_id,
      required String star,
      required String review,
      List<File?>? images}) async {
    isLoading(true);
    update();

    await server
        .multipartRequestForReview(
            ApiList.submitReview, images, product_id, star, review)
        .then((response) async {
      response.stream.transform(utf8.decoder).listen((value) {
        if (response.statusCode == 201) {
          isLoading(false);
          customSnackbar("SUCCESS".tr,
              'Review submitted successfully!'.toString().tr, AppColor.success);
          Get.off(() => OrderHistoryScreen());
        } else {
          isLoading(false);
          customSnackbar(
              "ERROR".tr, 'Review not submitted'.toString().tr, AppColor.error);
        }
      });
    });
  }

  reviewUpdate(
      {required String product_id,
      required String? star,
      required String review,
      required String review_id}) async {
    isLoading(true);
    update();
    Map<String, String>? body = {
      'product_id': product_id,
      'review': review,
      'star': star.toString(),
    };
    String jsonBody = json.encode(body);

    await server
        .putRequest(
      endPoint: ApiList.updateReview + review_id,
      body: jsonBody,
    )
        .then((response) async {
      if (response != null && response.statusCode == 200) {
        getReviewDetails(review_id: review_id);
        isLoading(false);
        update();
        customSnackbar(
            "SUCCESS".tr, 'Review Updated successfully!'.tr, AppColor.success);
        final orderController = Get.put(OrderController());
        orderController.resetState();
        Get.off(() => const OrderHistoryScreen());
      } else {
        isLoading(false);
        update();
        customSnackbar("ERROR".tr, "SOMETHING_WRONG".tr, AppColor.error);
      }
    });
  }

  updateImage(file, review_id) async {
    update();
    await server
        .multipartRequestReviewUpdate(ApiList.updateImage + review_id, file)
        .then((response) async {
      response.stream.transform(utf8.decoder).listen((value) {
        if (response == 200) {
          update();
          getReviewDetails(review_id: review_id);
          update();
        } else {
          update();
        }
      });
    });
  }

  deleteImage({required String review_id, required String index}) async {
    var response;
    response =
        await ReviewRepo().deleteImage(review_id: review_id, index: index);
    if (response.statusCode == 200) {
      update();
      getReviewDetails(review_id: review_id);
      update();
    } else {
      update();
    }
  }
}
