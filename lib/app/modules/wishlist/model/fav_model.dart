// To parse this JSON data, do
//
//     final favoriteModel = favoriteModelFromJson(jsonString);

import 'dart:convert';

import 'package:shopperz/app/modules/product_details/model/Product_model.dart';

FavoriteModel favoriteModelFromJson(String str) =>
    FavoriteModel.fromJson(json.decode(str));

String favoriteModelToJson(FavoriteModel data) => json.encode(data.toJson());

class FavoriteModel {
  final List<Product>? data;

  FavoriteModel({
    this.data,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
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
