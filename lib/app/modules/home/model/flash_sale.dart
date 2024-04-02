// To parse this JSON data, do
//
//     final flashSaleModel = flashSaleModelFromJson(jsonString);

import 'dart:convert';

import 'package:shopperz/app/modules/product_details/model/Product_model.dart';

FlashSaleModel flashSaleModelFromJson(String str) =>
    FlashSaleModel.fromJson(json.decode(str));

String flashSaleModelToJson(FlashSaleModel data) => json.encode(data.toJson());

class FlashSaleModel {
  final List<Product>? data;

  FlashSaleModel({
    this.data,
  });

  factory FlashSaleModel.fromJson(Map<String, dynamic> json) => FlashSaleModel(
        data: json["data"] == null
            ? []
            : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
