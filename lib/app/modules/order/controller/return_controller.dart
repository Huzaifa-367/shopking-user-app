import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopperz/app/modules/order/views/return_orders_screen.dart';
import 'package:shopperz/config/theme/app_color.dart';
import 'package:shopperz/data/model/return_order_details_model.dart';
import 'package:shopperz/data/model/return_order_model.dart';
import 'package:shopperz/data/model/return_orders_model.dart' as order;
import 'package:shopperz/data/model/return_reason_model.dart';
import 'package:shopperz/data/repository/return_repo.dart';
import 'package:shopperz/data/server/app_server.dart';
import 'package:shopperz/utils/api_list.dart';
import 'package:shopperz/widgets/custom_snackbar.dart';

class ReturnController extends GetxController {
  ReturnReasonModel? returnReasonModel;
  final returnOrdersModel = order.ReturnOrdersModel().obs;
  final returnOrdersList = <order.Data>[].obs;

  ReturnOrdersDetailsModel? returnOrdersDetailsModel;

  RxList<ReturnReasonModel> returnReasonMap = <ReturnReasonModel>[].obs;
  RxList<order.ReturnOrdersModel> returnOrdersMap =
      <order.ReturnOrdersModel>[].obs;
  RxList<ReturnOrdersDetailsModel> returnOrdersDetailsMap =
      <ReturnOrdersDetailsModel>[].obs;

  TextEditingController selectedReason = TextEditingController();

  ScrollController scrollController = ScrollController();

  int paginate = 1;
  final page = 1.obs;
  final itemPerPage = 10.obs;
  final lastPage = 1.obs;
  bool hasMoreData = false;

  String selectedReasonId = '';

  int quantity = 0;
  double price = 0.0;
  double total = 0.0;
  double tax = 0.0;

  List<ReturnOrder> returnItems = [];

  void addItem(
      {required int index,
      required int id,
      required int quantity,
      required double price,
      required bool has_variation,
      required int order_quantity,
      required double return_price,
      required double tax,
      required double total,
      required String variation_id,
      required String variation_names}) {
    for (var item in returnItems) {
      if (item.index == index) {
        removeFromItem(item);
        return;
      }
    }
    returnItems.add(
      ReturnOrder(
        index: index,
        has_variation: has_variation,
        id: id,
        order_quantity: order_quantity,
        price: price,
        quantity: quantity,
        return_price: return_price,
        tax: tax,
        total: total,
        variation_id: variation_id,
        variation_names: variation_names,
      ),
    );
  }

  void incrementItem({required int index}) {
    for (var item in returnItems) {
      if (item.index == index) {
        if (item.quantity < item.order_quantity) {
          item.quantity++;
        }
        return;
      }
    }
  }

  void decrementItem({required int index}) {
    for (var item in returnItems) {
      if (item.index == index) {
        if (item.quantity > 1) {
          item.quantity--;
        }
        return;
      }
    }
  }

  checkItem({required int index}) {
    for (var item in returnItems) {
      if (item.index == index) {
        return true;
      }
    }
  }

  void removeFromItem(ReturnOrder returnOrder) {
    returnItems.remove(returnOrder);
  }

  final isLoading = false.obs;

  final box = GetStorage();

  AppServer server = AppServer();

  @override
  void onInit() {
    final box = GetStorage();
    if (box.read('isLogedIn') != false) {
      getReturnReason();
      getReturnOrders();
    }
    super.onInit();
  }

  getReturnReason() async {
    returnReasonModel = await ReturnRepo.getReturnReason();

    returnReasonMap.add(returnReasonModel!);

    refresh();
  }

  getReturnOrders() async {
    returnOrdersModel.value = await ReturnRepo.getReturnOrders(
        page: page.value, paginate: paginate, perPage: itemPerPage.value);

    lastPage.value = returnOrdersModel.value.meta!.lastPage!.toInt();

    if (page < lastPage.value) {
      hasMoreData = true;
      page.value++;
    } else if (lastPage.value == 1) {
      hasMoreData = false;
    } else {
      hasMoreData = false;
    }

    returnOrdersList.value += returnOrdersModel.value.data!;

    refresh();
  }

  void loadMoreData() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getReturnOrders();
      }
    });
  }

  getReturnOrdersDetails({required String return_id}) async {
    returnOrdersDetailsModel =
        await ReturnRepo.getReturnOrdersDetails(return_id: return_id);

    returnOrdersDetailsMap.add(returnOrdersDetailsModel!);

    refresh();
  }

  returnRequest(
      {required String order_id,
      required String return_reason_id,
      required String order_serial_no,
      required List<File?>? images,
      required String jsonFile,
      required String note}) async {
    isLoading(true);
    update();

    await server
        .multipartRequestForReturn(ApiList.returnRequest + order_id, images,
            order_id, return_reason_id, order_serial_no, jsonFile, note)
        .then((response) async {
      response.stream.transform(utf8.decoder).listen((value) {
        if (response.statusCode == 201) {
          isLoading(false);
          customSnackbar(
              "SUCCESS".tr,
              'Return request submitted successfully!'.toString().tr,
              AppColor.success);
          Get.off(() => ReturnOrdersScreen());
        } else {
          isLoading(false);
          customSnackbar("ERROR".tr,
              'Return request not submitted'.toString().tr, AppColor.error);
        }
      });
    });
  }

  void resetState() {
    returnOrdersList.clear();
    page.value = 1;
    lastPage.value = 1;
    hasMoreData = false;
  }
}
