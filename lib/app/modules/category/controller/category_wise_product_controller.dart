import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopperz/data/remote_services/remote_services.dart';

import '../model/category_wise_product.dart';

class CategoryWiseProductController extends GetxController {
  ScrollController scrollController = ScrollController();
  final isLaoding = false.obs;
  final categoryWiseProductModel = CategoryWiseProduct().obs;
  final categoryWiseProductList = <Product>[].obs;

  int paginate = 1;
  final page = 1.obs;
  final itemPerPage = 30.obs;
  final isLoading = false.obs;
  final lastPage = 1.obs;
  bool hasMoreData = false;

  final indexCount = RxInt(-1);
  final itemCount = 0.obs;

  Map<String, dynamic>? variationsMap;

  fetchCategoryWiseProduct({
    required String categorySlug,
    String? brands,
    sortBy,
    minPrice,
    maxPrice,
    String? name, 
    variatons,
  }) async {
    isLaoding(true);
    final data = await RemoteServices().fetchCategoryWiseProduct( 
      category: categorySlug,
      brands: brands,
      sortBy: sortBy,
      minPrice: minPrice,
      maxPrice: maxPrice,
      name: name ?? "",
      variations: variatons,
      page: page.value,
    );
    isLaoding(false);
    data.fold((error) => error.toString(), (categoryWiseProduct) {
      categoryWiseProductModel.value = categoryWiseProduct;

      lastPage.value = categoryWiseProduct.data!.lastPage!.toInt();

      if (page.value < lastPage.value) {
        hasMoreData = true;
      }
      else if (page.value == lastPage.value) {
        hasMoreData = false;
      } else {
        hasMoreData = false;
      }

      categoryWiseProductList.value += categoryWiseProduct.data!.products!;
      
    });
  }

  void loadMoreData({required String categorySlug,}) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (hasMoreData) {
            page.value++;
          fetchCategoryWiseProduct(
          categorySlug: categorySlug,
        );
        }
        
      }
    });
  }

  void resetState() {
    categoryWiseProductList.clear();
    page.value = 1;
    lastPage.value = 1;
    hasMoreData = false;
  }
}
