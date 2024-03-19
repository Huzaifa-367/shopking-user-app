import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shopperz/app/modules/wishlist/model/fav_model.dart';
import 'package:shopperz/config/theme/app_color.dart';
import 'package:shopperz/utils/api_list.dart';
import 'package:shopperz/widgets/custom_snackbar.dart';

import '../../../../main.dart';

class WishlistController extends GetxController {
  final favList = <int>{}.obs;
  final favoriteModel = FavoriteModel().obs;
  final isLoading = false.obs;

  fetchFavorite() async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse(ApiList.showWishlist),
        headers: {
          "Accept": "application/json, text/plain, */*",
          "Access-Control-Allow-Origin": "*",
          // "x-api-key": ApiList.licenseCode.toString(),
          'Authorization': 'Bearer ${box.read("token")}',
        },
      );

      if (response.statusCode == 200) {
        isLoading(false);
        final jsonString = response.body;
        final data = favoriteModelFromJson(jsonString);
        favoriteModel.value = data;
        favoriteModel.value.data?.map((e) => favList.add(e.id!)).toList();
      }
    } catch (e) {
      isLoading(false);
    }
  }

  toggleFavoriteFalse(int productId) async {
    var dio = Dio();
    try {
      var response = await dio.post(ApiList.wishList,
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json, text/plain, */*",
              "Access-Control-Allow-Origin": "*",
              // "x-api-key": ApiList.licenseCode.toString(),
              'Authorization': 'Bearer ${box.read("token")}',
            },
          ),
          data: {
            "product_id": productId.toString(),
            "toggle": '0',
          });

      if (response.statusCode == 202) {
        refresh();
        update();
      }
    } catch (e) {
      print(e);
    }
  }

  toggleFavoriteTrue(int productId) async {
    var dio = Dio();
    try {
      var response = await dio.post(ApiList.wishList,
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json, text/plain, */*",
              "Access-Control-Allow-Origin": "*",
              // "x-api-key": ApiList.licenseCode.toString(),
              'Authorization': 'Bearer ${box.read("token")}',
            },
          ),
          data: {
            "product_id": productId.toString(),
            "toggle": '1',
          });

      if (response.statusCode == 202) {
        refresh();
        update();
      }
    } catch (e) {
      print(e);
    }
  }

  showFavorite(int id) {
    if (favList.contains(id)) {
      toggleFavoriteFalse(id);
      favList.remove(id);
      customSnackbar('Remove'.tr, 'Removed from Wishlist'.tr, AppColor.error);
    } else {
      favList.add(id);
      customSnackbar('Add'.tr, 'Added to Wishlist'.tr, AppColor.success);
    }
  }

  @override
  void onInit() {
    fetchFavorite();
    super.onInit();
  }
}
