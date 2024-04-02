import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopperz/app/modules/home/model/product_section.dart';
import 'package:shopperz/app/modules/product_details/model/Product_model.dart';
import 'package:shopperz/main.dart';

import '../../../../data/server/app_server.dart';
import '../../../../utils/api_list.dart';
import '../model/popular_product.dart';

class AllPopularControler extends GetxController {
  ScrollController scrollController = ScrollController();
  final popularModel = PopularProduct().obs;
  final popularList = <Product>[].obs;

  int paginate = 1;
  int page = 1;
  int itemPerPage = 8;
  bool hasMoreData = false;

  Future<PopularProduct> fetchPopularProducts() async {
    final store = GetStorage();
    var token = store.read('token');
    final response = await AppServer().getRequest(
        endPoint: ApiList.mostPopular(
            paginate.toString(), page.toString(), itemPerPage.toString()),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json, text/plain, */*",
          "Access-Control-Allow-Origin": "*",
          // "x-api-key": ApiList.licenseCode.toString(),
          'Authorization': box.read('isLogedIn') != false ? token : null
        });

    if (response.statusCode == 200) {
      final data = response.data;
      popularModel.value = PopularProduct.fromJson(data);
      popularList.value += popularModel.value.data!;
      final meta = data["meta"];
      final lastPage = meta["last_page"];

      if (page <= lastPage) {
        hasMoreData = true;
        page++;
      } else {
        hasMoreData = false;
      }

      return popularModel.value;
    }

    return popularModel.value;
  }

  void loadMoreData() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchPopularProducts();
      }
    });
  }

  void resetState() {
    popularList.clear();
    page = 1;
    hasMoreData = false;
  }

  @override
  void onInit() {
    fetchPopularProducts();
    super.onInit();
  }
}
