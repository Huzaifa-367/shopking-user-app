import 'package:dio/dio.dart';
import 'package:shopperz/data/model/order_details_model.dart';
import 'package:shopperz/data/model/order_history_model.dart';
import 'package:shopperz/data/server/app_server.dart';
import 'package:shopperz/utils/api_list.dart';

class OrderRepo {
  static Future<BaseOptions> getBasseOptions() async {
    BaseOptions options = BaseOptions(
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
      headers: AppServer.getAuthHeaders(),
    );

    return options;
  }

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

  static Future<OrderHistoryModel> getOrderHistory(
      {required int? paginate,
      required int? page,
      required int? perPage}) async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = ApiList.orderHistory.toString() +
        '?paginate=$paginate&page=$page&per_page=$perPage&active=5';
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return OrderHistoryModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return OrderHistoryModel.fromJson(response.data);
  }

  static Future<OrderDetailsModel> getOrderDetails({required String id}) async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = ApiList.orderDetails.toString() + id;
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return OrderDetailsModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return OrderDetailsModel.fromJson(response.data);
  }
}
