// To parse this JSON data, do
//
//     final promotionModel = promotionModelFromJson(jsonString);

import 'dart:convert';

PromotionModel promotionModelFromJson(String str) =>
    PromotionModel.fromJson(json.decode(str));

String promotionModelToJson(PromotionModel data) => json.encode(data.toJson());

class PromotionModel {
  final List<promotionModel>? data;

  PromotionModel({
    this.data,
  });

  factory PromotionModel.fromJson(Map<String, dynamic> json) => PromotionModel(
        data: json["data"] == null
            ? []
            : List<promotionModel>.from(
                json["data"]!.map((x) => promotionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class promotionModel {
  final int? id;
  final String? name;
  final String? slug;
  final int? type;
  final int? status;
  final String? cover;
  final String? preview;

  promotionModel({
    this.id,
    this.name,
    this.slug,
    this.type,
    this.status,
    this.cover,
    this.preview,
  });

  factory promotionModel.fromJson(Map<String, dynamic> json) => promotionModel(
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
