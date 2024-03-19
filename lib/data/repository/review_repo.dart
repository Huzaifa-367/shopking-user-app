import 'package:dio/dio.dart';
import 'package:shopperz/data/model/review_details_model.dart';
import 'package:shopperz/data/server/app_server.dart';
import 'package:shopperz/utils/api_list.dart';

class ReviewRepo {
  static Future<BaseOptions> getBasseOptionsWithToken() async {
    BaseOptions options = BaseOptions(
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
      headers: AppServer.getHttpHeadersWithToken(),
    );

    return options;
  }

  static Future<ReviewDetailsModel> getReviewDetails(
      {required String review_id}) async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = ApiList.showReview.toString() + review_id;
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return ReviewDetailsModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return ReviewDetailsModel.fromJson(response.data);
  }

  deleteImage({required String review_id, required String index}) async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = ApiList.deleteImage.toString() + review_id + '/' + index;
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print(e);
    }
    return response;
  }
}
