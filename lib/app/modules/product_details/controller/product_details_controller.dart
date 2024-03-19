import 'package:get/get.dart';
import 'package:shopperz/app/modules/cart/model/product_model.dart';
import 'package:shopperz/app/modules/product_details/model/children_variation.dart';
import 'package:shopperz/app/modules/product_details/model/initial_variation.dart';
import 'package:shopperz/app/modules/product_details/model/related_product.dart';
import 'package:shopperz/data/remote_services/remote_services.dart';
import 'package:shopperz/data/server/app_server.dart';
import 'package:shopperz/utils/api_list.dart';

class ProductDetailsController extends GetxController {
  final productModel = ProductModel().obs;
  final relatedProductModel = RelatedProductModel().obs;
  final initialVariationModel = InitialVariationModel().obs;
  final childrenVariationModel1 = ChildrenVariationModel().obs;
  final childrenVariationModel2 = ChildrenVariationModel().obs;
  final childrenVariationModel3 = ChildrenVariationModel().obs;
  final childrenVariationModel4 = ChildrenVariationModel().obs;
  final childrenVariationModel5 = ChildrenVariationModel().obs;
  final childrenVariationModel6 = ChildrenVariationModel().obs;

  final initialIndex = RxInt(-1);
  final selectedIndex1 = RxInt(-1);
  final selectedIndex2 = RxInt(-1);
  final selectedIndex3 = RxInt(-1);
  final selectedIndex4 = RxInt(-1);
  final selectedIndex5 = RxInt(-1);
  final selectedIndex6 = RxInt(-1);
  final selectedIndex7 = RxInt(-1);

  final variationProductId = ''.obs;
  final variationProductPrice = ''.obs;
  final variationProductCurrencyPrice = ''.obs;
  final variationProductOldPrice = ''.obs;
  final variationProductOldCurrencyPrice = ''.obs;
  final variationsku = ''.obs;
  final variationsStock = RxInt(-1);

  final reviewLimit = 3.obs;

  final isLaoding = RxInt(1);

  String finalVariationString = "";

  resetProductState() {
    childrenVariationModel1.value.data?.clear();
    childrenVariationModel2.value.data?.clear();
    childrenVariationModel3.value.data?.clear();
    childrenVariationModel4.value.data?.clear();
    childrenVariationModel5.value.data?.clear();
    childrenVariationModel6.value.data?.clear();

    initialIndex.value = -1;
    selectedIndex1.value = -1;
    selectedIndex2.value = -1;
    selectedIndex3.value = -1;
    selectedIndex4.value = -1;
    selectedIndex5.value = -1;
    selectedIndex6.value = -1;
    selectedIndex7.value = -1;

    variationProductId.value = '';
    variationProductPrice.value = '';
    variationProductCurrencyPrice.value = '';
    variationProductOldPrice.value = '';
    variationProductOldCurrencyPrice.value = '';
    variationsku.value = '';
    variationsStock.value = -1;

    finalVariationString = '';
  }

  Future<void> fetchProductDetails({required String slug}) async {
    isLaoding.value = 1;
    final data = await RemoteServices()
        .fetchProductDetails(slug: slug, reviewLimit: reviewLimit.value);

    isLaoding.value = 0;

    data.fold((error) {}, (product) {
      productModel.value = product;
    });
  }

  Future<void> fetchRelatedProduct({required String slug}) async {
    final data = await RemoteServices().fetchRelatedProducts(slug: slug);

    data.fold((error) => error, (relatedProduct) {
      relatedProductModel.value = relatedProduct;
      refresh();
    });
  }

  Future<void> fetchInitialVariation({required String productId}) async {
    final data =
        await RemoteServices().fetchInitialVariation(productId: productId);

    data.fold((error) {}, (initialData) {
      initialVariationModel.value = initialData;
    });
  }

  Future<void> fetchChildrenVariation1(
      {required String initialVariationId}) async {
    final data = await RemoteServices()
        .fetchChildrenVariation(initialVariationId: initialVariationId);

    data.fold((error) {}, (childrenData) {
      childrenVariationModel1.value = childrenData;
    });
  }

  Future<void> fetchChildrenVariation2(
      {required String initialVariationId}) async {
    final data = await RemoteServices()
        .fetchChildrenVariation(initialVariationId: initialVariationId);

    data.fold((error) {}, (childrenData) {
      childrenVariationModel2.value = childrenData;
    });
  }

  Future<void> fetchChildrenVariation3(
      {required String initialVariationId}) async {
    final data = await RemoteServices()
        .fetchChildrenVariation(initialVariationId: initialVariationId);

    data.fold((error) {}, (childrenData) {
      childrenVariationModel3.value = childrenData;
    });
  }

  Future<void> fetchChildrenVariation4(
      {required String initialVariationId}) async {
    final data = await RemoteServices()
        .fetchChildrenVariation(initialVariationId: initialVariationId);

    data.fold((error) {}, (childrenData) {
      childrenVariationModel4.value = childrenData;
    });
  }

  Future<void> fetchChildrenVariation5(
      {required String initialVariationId}) async {
    final data = await RemoteServices()
        .fetchChildrenVariation(initialVariationId: initialVariationId);

    data.fold((error) {}, (childrenData) {
      childrenVariationModel5.value = childrenData;
    });
  }

  Future<void> fetchChildrenVariation6(
      {required String initialVariationId}) async {
    final data = await RemoteServices()
        .fetchChildrenVariation(initialVariationId: initialVariationId);

    data.fold((error) {}, (childrenData) {
      childrenVariationModel6.value = childrenData;
    });
  }

  Future<void> finalVariation({required id}) async {
    finalVariationString = "";
    final response = await AppServer().getRequest(
      endPoint: ApiList.finalVariation + id,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        // "x-api-key": ApiList.licenseCode.toString(),
      },
    );
    if (response.statusCode == 200) {
      finalVariationString = response.data["data"];
    }
  }
}
