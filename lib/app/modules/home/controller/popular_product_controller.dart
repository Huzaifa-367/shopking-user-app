import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopperz/app/modules/home/model/popular_product.dart';
import 'package:shopperz/data/server/app_server.dart';
import 'package:shopperz/main.dart';
import 'package:shopperz/utils/api_list.dart';

class PopularProductController extends GetxController {
  final popularModel = PopularProduct().obs;

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

      return popularModel.value;
    }

    return popularModel.value;
  }

  @override
  void onInit() {
    fetchPopularProducts();
    super.onInit();
  }
}
