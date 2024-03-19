import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopperz/config/theme/app_color.dart';
import 'package:shopperz/data/model/order_details_model.dart';
import 'package:shopperz/data/model/order_history_model.dart' as order;
import 'package:shopperz/data/repository/order_repo.dart';
import 'package:shopperz/data/server/app_server.dart';
import 'package:shopperz/utils/api_list.dart';
import 'package:shopperz/widgets/custom_snackbar.dart';

class OrderController extends GetxController {
  OrderDetailsModel? orderDetailsModel;

  final orderHistoryModel = order.OrderHistoryModel().obs;
  final orderHistoryList = <order.Data>[].obs;

  RxList<order.OrderHistoryModel> orderHistoryMap =
      <order.OrderHistoryModel>[].obs;
  RxList<OrderDetailsModel> orderDetailsMap = <OrderDetailsModel>[].obs;

  ScrollController scrollController = ScrollController();

  int paginate = 1;
  final page = 1.obs;
  final itemPerPage = 10.obs;
  final lastPage = 1.obs;
  bool hasMoreData = false;

  final isLoading = false.obs;

  final box = GetStorage();

  AppServer server = AppServer();

  @override
  void onInit() {
    final box = GetStorage();
    if (box.read('isLogedIn') != false) {
      getOrderHistory();
    }
    super.onInit();
  }

  getOrderHistory() async {
    orderHistoryModel.value = await OrderRepo.getOrderHistory(
        page: page.value, paginate: paginate, perPage: itemPerPage.value);

    lastPage.value = orderHistoryModel.value.meta!.lastPage!.toInt();

    if (page < lastPage.value) {
      hasMoreData = true;
      page.value++;
    } else if (lastPage.value == 1) {
      hasMoreData = false;
    } else {
      hasMoreData = false;
    }

    orderHistoryList.value += orderHistoryModel.value.data!;

    refresh();
  }

  void loadMoreData() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getOrderHistory();
      }
    });
  }

  getOrderDetails({required String id}) async {
    orderDetailsModel = await OrderRepo.getOrderDetails(id: id);

    orderDetailsMap.add(orderDetailsModel!);

    refresh();
  }

  cancelOrder({required String order_id}) async {
    isLoading(true);
    update();
    Map<String, String>? body = {
      "status": '15',
    };
    String jsonBody = json.encode(body);
    await server
        .postRequestWithToken(
      endPoint: ApiList.orderCancel + order_id,
      body: jsonBody,
    )
        .then((response) {
      if (response != null && response.statusCode == 200) {
        isLoading(false);
        customSnackbar("SUCCESS".tr,
            'Order Canceled Successfully!'.toString().tr, AppColor.success);

        getOrderHistory();
        getOrderDetails(id: order_id);
      } else {
        isLoading(false);
        customSnackbar("ERROR".tr,
            jsonDecode(response.body)["message"].toString().tr, AppColor.error);
      }
    });
  }

  void resetState() {
    orderHistoryList.clear();
    page.value = 1;
    lastPage.value = 1;
    hasMoreData = false;
  }
}
