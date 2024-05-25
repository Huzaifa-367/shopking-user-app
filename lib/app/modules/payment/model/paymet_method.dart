// To parse this JSON data, do
//
//     final paymentMethodModel = paymentMethodModelFromJson(jsonString);

import 'dart:convert';

PaymentMethodModel paymentMethodModelFromJson(String str) =>
    PaymentMethodModel.fromJson(json.decode(str));

String paymentMethodModelToJson(PaymentMethodModel data) =>
    json.encode(data.toJson());

class PaymentMethodModel {
  List<paymentMethodModel>? data;

  PaymentMethodModel({
    this.data,
  });

  PaymentMethodModel copyWith({
    List<paymentMethodModel>? data,
  }) =>
      PaymentMethodModel(
        data: data ?? this.data,
      );

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      PaymentMethodModel(
        data: json["data"] == null
            ? []
            : List<paymentMethodModel>.from(
                json["data"]!.map((x) => paymentMethodModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class paymentMethodModel {
  int? id;
  String? name;
  String? slug;
  int? status;
  String? image;

  paymentMethodModel({
    this.id,
    this.name,
    this.slug,
    this.status,
    this.image,
  });

  paymentMethodModel copyWith({
    int? id,
    String? name,
    String? slug,
    int? status,
    String? image,
  }) =>
      paymentMethodModel(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        status: status ?? this.status,
        image: image ?? this.image,
      );

  factory paymentMethodModel.fromJson(Map<String, dynamic> json) =>
      paymentMethodModel(
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
