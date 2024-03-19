// To parse this JSON data, do
//
//     final popularProduct = popularProductFromJson(jsonString);

import 'dart:convert';

PopularProduct popularProductFromJson(String str) => PopularProduct.fromJson(json.decode(str));

String popularProductToJson(PopularProduct data) => json.encode(data.toJson());

class PopularProduct {
    final List<Datum>? data;

    PopularProduct({
        this.data,
    });

    factory PopularProduct.fromJson(Map<String, dynamic> json) => PopularProduct(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    final int? id;
    final String? name;
    final String? slug;
    final String? currencyPrice;
    final String? cover;
    final bool? flashSale;
    final bool? isOffer;
    final String? discountedPrice;
    final dynamic ratingStar;
    final dynamic ratingStarCount;
    final bool? wishlist;

    Datum({
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

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
