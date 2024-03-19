// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'dart:convert';

SliderModel sliderModelFromJson(String str) =>
    SliderModel.fromJson(json.decode(str));

String sliderModelToJson(SliderModel data) => json.encode(data.toJson());

class SliderModel {
  final List<Datum>? data;

  SliderModel({
    this.data,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
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
  final String? title;
  final String? description;
  final int? status;
  final String? image;
  final dynamic link;

  Datum({
    this.id,
    this.title,
    this.description,
    this.status,
    this.image,
    this.link,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        image: json["image"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "status": status,
        "image": image,
        "link": link,
      };
}
