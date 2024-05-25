// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'dart:convert';

SliderModel sliderModelFromJson(String str) =>
    SliderModel.fromJson(json.decode(str));

String sliderModelToJson(SliderModel data) => json.encode(data.toJson());

class SliderModel {
  final List<SlideModel>? data;

  SliderModel({
    this.data,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        data: json["data"] == null
            ? []
            : List<SlideModel>.from(
                json["data"]!.map((x) => SlideModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SlideModel {
  final int? id;
  final String? title;
  final String? description;
  final int? status;
  final String? image;
  final dynamic link;

  SlideModel({
    this.id,
    this.title,
    this.description,
    this.status,
    this.image,
    this.link,
  });

  factory SlideModel.fromJson(Map<String, dynamic> json) => SlideModel(
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
