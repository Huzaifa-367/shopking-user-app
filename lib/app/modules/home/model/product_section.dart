// To parse this JSON data, do
//
//     final productSectionModel = productSectionModelFromJson(jsonString);

import 'dart:convert';

ProductSectionModel productSectionModelFromJson(String str) =>
    ProductSectionModel.fromJson(json.decode(str));

String productSectionModelToJson(ProductSectionModel data) =>
    json.encode(data.toJson());

class ProductSectionModel {
  final List<Datum>? data;

  ProductSectionModel({
    this.data,
  });

  factory ProductSectionModel.fromJson(Map<String, dynamic> json) =>
      ProductSectionModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final int? id;
  final String? name;
  final String? slug;
  final int? status;
  final List<Product>? products;

  Datum({
    this.id,
    this.name,
    this.slug,
    this.status,
    this.products,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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

class Product {
  final int? id;
  final String? name;
  final String? slug;
  final String? currencyPrice;
  final String? cover;
  final bool? flashSale;
  final bool? isOffer;
  final String? discountedPrice;
  final dynamic ratingStar;
  final int? ratingStarCount;
  final bool? wishlist;

  Product({
    this.id,
    this.name,
    this.slug,
    this.currencyPrice,
    this.cover,
    this.flashSale,
    this.isOffer,
    this.discountedPrice,
    this.ratingStar = 0,
    this.ratingStarCount,
    this.wishlist,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        currencyPrice: json["currency_price"],
        cover: json["cover"],
        flashSale: json["flash_sale"],
        isOffer: json["is_offer"],
        discountedPrice: json["discounted_price"],
        ratingStar: json["rating_star"],
        ratingStarCount: json["rating_star_count"],
        wishlist: json["wishlist"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "currency_price": currencyPrice,
        "cover": cover,
        "flash_sale": flashSale,
        "is_offer": isOffer,
        "discounted_price": discountedPrice,
        "rating_star": ratingStar,
        "rating_star_count": ratingStarCount,
        "wishlist": wishlist,
      };
}
