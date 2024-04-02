// To parse this JSON data, do
//
//     final allProducts = allProductsFromJson(jsonString);

import 'dart:convert';

import 'package:shopperz/app/modules/product_details/model/Product_model.dart';

AllProducts allProductsFromJson(String str) =>
    AllProducts.fromJson(json.decode(str));

String allProductsToJson(AllProducts data) => json.encode(data.toJson());

class AllProducts {
  final List<Product>? data;

  AllProducts({
    this.data,
  });

  factory AllProducts.fromJson(Map<String, dynamic> json) => AllProducts(
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
