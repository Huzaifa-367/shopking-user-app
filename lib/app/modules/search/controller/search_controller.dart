import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/search/model/all_product.dart';
import 'package:shopperz/data/remote_services/remote_services.dart';

class ProductSearchController extends GetxController {
  final searchTextController = TextEditingController();
  final productList = <Datum>[].obs;
  var searchAllProductList = <Datum>[].obs;
  final isLoading = false.obs;

  Future<dynamic> fetchAllProduct() async {
    isLoading(true);
    final result = await RemoteServices().fetchAllProduct();
    isLoading(false);
    return result.fold(
      (error) {
        isLoading(false);
      },
      (allProduct) {
        productList.value = allProduct.data ?? [];
      },
    );
  }

  void searchFromAllProduct(String query) {
    searchAllProductList.assignAll(productList.where(
      (product) => product.name!.toLowerCase().contains(query.toLowerCase()),
    ));
  }

  @override
  void onInit() {
    fetchAllProduct();
    searchAllProductList.assignAll(productList);
    super.onInit();
  }
}
