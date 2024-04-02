// To parse this JSON data, do
//
//     final productSectionModel = productSectionModelFromJson(jsonString);

import 'dart:convert';

import 'package:shopperz/app/modules/product_details/model/Product_model.dart';

ProductSectionModel productSectionModelFromJson(String str) =>
    ProductSectionModel.fromJson(json.decode(str));

String productSectionModelToJson(ProductSectionModel data) =>
    json.encode(data.toJson());

class ProductSectionModel {
  final List<DatumSection>? data;

  ProductSectionModel({
    this.data,
  });

  factory ProductSectionModel.fromJson(Map<String, dynamic> json) =>
      ProductSectionModel(
        data: json["data"] == null
            ? []
            : List<DatumSection>.from(
                json["data"]!.map((x) => DatumSection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DatumSection {
  final int? id;
  final String? name;
  final String? slug;
  final int? status;
  final List<Product>? products;

  DatumSection({
    this.id,
    this.name,
    this.slug,
    this.status,
    this.products,
  });

  factory DatumSection.fromJson(Map<String, dynamic> json) => DatumSection(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        status: json["status"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "status": status,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}
