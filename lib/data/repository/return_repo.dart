import 'package:dio/dio.dart';
import 'package:shopperz/data/model/return_order_details_model.dart';
import 'package:shopperz/data/model/return_orders_model.dart';
import 'package:shopperz/data/model/return_reason_model.dart';
import 'package:shopperz/data/server/app_server.dart';
import 'package:shopperz/utils/api_list.dart';

class ReturnRepo {
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

  static Future<ReturnReasonModel> getReturnReason() async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = ApiList.showReturnReason.toString() + '?status=5';
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return ReturnReasonModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return ReturnReasonModel.fromJson(response.data);
  }

  static Future<ReturnOrdersModel> getReturnOrders(
      {required int? paginate,
      required int? page,
      required int? perPage}) async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = ApiList.showReturnOrders.toString() +
        '?paginate=$paginate&page=$page&per_page=$perPage&active=5';
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return ReturnOrdersModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return ReturnOrdersModel.fromJson(response.data);
  }

  static Future<ReturnOrdersDetailsModel> getReturnOrdersDetails(
      {required String return_id}) async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = ApiList.showReturnOrdersDetails.toString() + return_id;
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return ReturnOrdersDetailsModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return ReturnOrdersDetailsModel.fromJson(response.data);
  }
}
