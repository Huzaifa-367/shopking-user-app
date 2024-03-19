// To parse this JSON data, do
//
//     final couponModel = couponModelFromJson(jsonString);

import 'dart:convert';

CouponModel couponModelFromJson(String str) =>
    CouponModel.fromJson(json.decode(str));

String couponModelToJson(CouponModel data) => json.encode(data.toJson());

class CouponModel {
  final List<Datum>? data;

  CouponModel({
    this.data,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
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
  final String? description;
  final String? code;
  final String? discount;
  final String? flatDiscount;
  final int? convertDiscount;
  final String? currencyDiscount;
  final int? discountType;
  final String? convertStartDate;
  final String? convertEndDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? minimumOrder;
  final String? minimumOrderFlatAmount;
  final int? minimumOrderConvertAmount;
  final String? minimumOrderCurrencyAmount;
  final String? maximumDiscount;
  final String? maximumFlatDiscount;
  final int? maximumConvertDiscount;
  final String? maximumCurrencyDiscount;
  final int? limitPerUser;
  final String? image;

  Datum({
    this.id,
    this.name,
    this.description,
    this.code,
    this.discount,
    this.flatDiscount,
    this.convertDiscount,
    this.currencyDiscount,
    this.discountType,
    this.convertStartDate,
    this.convertEndDate,
    this.startDate,
    this.endDate,
    this.minimumOrder,
    this.minimumOrderFlatAmount,
    this.minimumOrderConvertAmount,
    this.minimumOrderCurrencyAmount,
    this.maximumDiscount,
    this.maximumFlatDiscount,
    this.maximumConvertDiscount,
    this.maximumCurrencyDiscount,
    this.limitPerUser,
    this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        code: json["code"],
        discount: json["discount"],
        flatDiscount: json["flat_discount"],
        convertDiscount: json["convert_discount"],
        currencyDiscount: json["currency_discount"],
        discountType: json["discount_type"],
        convertStartDate: json["convert_start_date"],
        convertEndDate: json["convert_end_date"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        minimumOrder: json["minimum_order"],
        minimumOrderFlatAmount: json["minimum_order_flat_amount"],
        minimumOrderConvertAmount: json["minimum_order_convert_amount"],
        minimumOrderCurrencyAmount: json["minimum_order_currency_amount"],
        maximumDiscount: json["maximum_discount"],
        maximumFlatDiscount: json["maximum_flat_discount"],
        maximumConvertDiscount: json["maximum_convert_discount"],
        maximumCurrencyDiscount: json["maximum_currency_discount"],
        limitPerUser: json["limit_per_user"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "code": code,
        "discount": discount,
        "flat_discount": flatDiscount,
        "convert_discount": convertDiscount,
        "currency_discount": currencyDiscount,
        "discount_type": discountType,
        "convert_start_date": convertStartDate,
        "convert_end_date": convertEndDate,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "minimum_order": minimumOrder,
        "minimum_order_flat_amount": minimumOrderFlatAmount,
        "minimum_order_convert_amount": minimumOrderConvertAmount,
        "minimum_order_currency_amount": minimumOrderCurrencyAmount,
        "maximum_discount": maximumDiscount,
        "maximum_flat_discount": maximumFlatDiscount,
        "maximum_convert_discount": maximumConvertDiscount,
        "maximum_currency_discount": maximumCurrencyDiscount,
        "limit_per_user": limitPerUser,
        "image": image,
      };
}
