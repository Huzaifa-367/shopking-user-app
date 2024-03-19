// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  final List<Datum>? data;

  CategoryModel({
    this.data,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
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
  final String? parentCategory;
  final int? status;
  final int? parentId;
  final String? thumb;
  final String? cover;

  Datum({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.parentCategory,
    this.status,
    this.parentId,
    this.thumb,
    this.cover,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        parentCategory: json["parent_category"],
        status: json["status"],
        parentId: json["parent_id"],
        thumb: json["thumb"],
        cover: json["cover"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "description": description,
        "parent_category": parentCategory,
        "status": status,
        "parent_id": parentId,
        "thumb": thumb,
        "cover": cover,
      };
}
