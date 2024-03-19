// To parse this JSON data, do
//
//     final brandModel = brandModelFromJson(jsonString);

import 'dart:convert';

BrandModel brandModelFromJson(String str) =>
    BrandModel.fromJson(json.decode(str));

String brandModelToJson(BrandModel data) => json.encode(data.toJson());

class BrandModel {
  final List<Datum>? data;

  BrandModel({
    this.data,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
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
  final String? description;
  final int? status;
  final String? thumb;
  final String? cover;

  Datum({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.status,
    this.thumb,
    this.cover,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        status: json["status"],
        thumb: json["thumb"],
        cover: json["cover"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "description": description,
        "status": status,
        "thumb": thumb,
        "cover": cover,
      };
}
