// To parse this JSON data, do
//
//     final favoriteModel = favoriteModelFromJson(jsonString);

import 'dart:convert';

FavoriteModel favoriteModelFromJson(String str) =>
    FavoriteModel.fromJson(json.decode(str));

String favoriteModelToJson(FavoriteModel data) => json.encode(data.toJson());

class FavoriteModel {
  final List<FavoriteItem>? data;

  FavoriteModel({
    this.data,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        data: json["data"] == null
            ? []
            : List<FavoriteItem>.from(
                json["data"]!.map((x) => FavoriteItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class FavoriteItem {
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

  FavoriteItem({
    this.id,
    this.name,
    this.slug,
    this.currencyPrice,
    this.cover,
    this.flashSale,
    this.isOffer,
    this.discountedPrice,
    this.ratingStar,
    this.ratingStarCount,
    this.wishlist,
  });

  factory FavoriteItem.fromJson(Map<String, dynamic> json) => FavoriteItem(
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
