// To parse this JSON data, do
//
//     final promotionModel = promotionModelFromJson(jsonString);

import 'dart:convert';

PromotionModel promotionModelFromJson(String str) =>
    PromotionModel.fromJson(json.decode(str));

String promotionModelToJson(PromotionModel data) => json.encode(data.toJson());

class PromotionModel {
  final List<Datum>? data;

  PromotionModel({
    this.data,
  });

  factory PromotionModel.fromJson(Map<String, dynamic> json) => PromotionModel(
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
  final int? type;
  final int? status;
  final String? cover;
  final String? preview;

  Datum({
    this.id,
    this.name,
    this.slug,
    this.type,
    this.status,
    this.cover,
    this.preview,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        type: json["type"],
        status: json["status"],
        cover: json["cover"],
        preview: json["preview"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "type": type,
        "status": status,
        "cover": cover,
        "preview": preview,
      };
}
