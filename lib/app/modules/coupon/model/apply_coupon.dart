// To parse this JSON data, do
//
//     final applyCoupon = applyCouponFromJson(jsonString);

import 'dart:convert';

ApplyCoupon applyCouponFromJson(String str) =>
    ApplyCoupon.fromJson(json.decode(str));

String applyCouponToJson(ApplyCoupon data) => json.encode(data.toJson());

class ApplyCoupon {
  final Data? data;

  ApplyCoupon({
    this.data,
  });

  factory ApplyCoupon.fromJson(Map<String, dynamic> json) => ApplyCoupon(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final String? code;
  dynamic discount;
  final String? flatDiscount;
  dynamic convertDiscount;
  final String? currencyDiscount;

  Data({
    this.id,
    this.code,
    this.discount,
    this.flatDiscount,
    this.convertDiscount,
    this.currencyDiscount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        code: json["code"],
        discount: json["discount"],
        flatDiscount: json["flat_discount"],
        convertDiscount: json["convert_discount"],
        currencyDiscount: json["currency_discount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "discount": discount,
        "flat_discount": flatDiscount,
        "convert_discount": convertDiscount,
        "currency_discount": currencyDiscount,
      };
}
