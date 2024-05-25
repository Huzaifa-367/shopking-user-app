// To parse this JSON data, do
//
//     final categryModel = categryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  final List<categryModel>? data;

  CategoryModel({
    this.data,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        data: json["data"] == null
            ? []
            : List<categryModel>.from(
                json["data"]!.map((x) => categryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class categryModel {
  final int? id;
  final String? name;
  final String? slug;
  final String? description;
  final String? parentCategory;
  final int? status;
  final int? parentId;
  final String? thumb;
  final String? cover;

  categryModel({
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

  factory categryModel.fromJson(Map<String, dynamic> json) => categryModel(
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
