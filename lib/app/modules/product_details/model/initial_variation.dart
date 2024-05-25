// To parse this JSON data, do
//
//     final initialVariationModel = initialVariationModelFromJson(jsonString);

import 'dart:convert';

import 'package:shopperz/app/modules/product_details/model/children_variation.dart';

InitialVariationModel initialVariationModelFromJson(String str) =>
    InitialVariationModel.fromJson(json.decode(str));

String initialVariationModelToJson(InitialVariationModel data) =>
    json.encode(data.toJson());

class InitialVariationModel {
  final List<VariationModel>? data;

  InitialVariationModel({
    this.data,
  });

  factory InitialVariationModel.fromJson(Map<String, dynamic> json) =>
      InitialVariationModel(
        data: json["data"] == null
            ? []
            : List<VariationModel>.from(
                json["data"]!.map((x) => VariationModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
