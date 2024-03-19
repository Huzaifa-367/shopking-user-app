// To parse this JSON data, do
//
//     final paymentMethodModel = paymentMethodModelFromJson(jsonString);

import 'dart:convert';

PaymentMethodModel paymentMethodModelFromJson(String str) =>
    PaymentMethodModel.fromJson(json.decode(str));

String paymentMethodModelToJson(PaymentMethodModel data) =>
    json.encode(data.toJson());

class PaymentMethodModel {
  List<Datum>? data;

  PaymentMethodModel({
    this.data,
  });

  PaymentMethodModel copyWith({
    List<Datum>? data,
  }) =>
      PaymentMethodModel(
        data: data ?? this.data,
      );

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      PaymentMethodModel(
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
  int? id;
  String? name;
  String? slug;
  int? status;
  String? image;

  Datum({
    this.id,
    this.name,
    this.slug,
    this.status,
    this.image,
  });

  Datum copyWith({
    int? id,
    String? name,
    String? slug,
    int? status,
    String? image,
  }) =>
      Datum(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        status: status ?? this.status,
        image: image ?? this.image,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        status: json["status"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "status": status,
        "image": image,
      };
}
