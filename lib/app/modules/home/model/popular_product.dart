// To parse this JSON data, do
//
//     final popularProduct = popularProductFromJson(jsonString);

import 'dart:convert';

import 'package:shopperz/app/modules/product_details/model/Product_model.dart';

PopularProduct popularProductFromJson(String str) =>
    PopularProduct.fromJson(json.decode(str));

String popularProductToJson(PopularProduct data) => json.encode(data.toJson());

class PopularProduct {
  final List<Product>? data;

  PopularProduct({
    this.data,
  });

  factory PopularProduct.fromJson(Map<String, dynamic> json) => PopularProduct(
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
