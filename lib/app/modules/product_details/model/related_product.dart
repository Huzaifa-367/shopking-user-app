// To parse this JSON data, do
//
//     final relatedProductModel = relatedProductModelFromJson(jsonString);

import 'dart:convert';

import 'package:shopperz/app/modules/product_details/model/Product_model.dart';

RelatedProductModel relatedProductModelFromJson(String str) =>
    RelatedProductModel.fromJson(json.decode(str));

String relatedProductModelToJson(RelatedProductModel data) =>
    json.encode(data.toJson());

class RelatedProductModel {
  final List<Product>? data;

  RelatedProductModel({
    this.data,
  });

  factory RelatedProductModel.fromJson(Map<String, dynamic> json) =>
      RelatedProductModel(
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
