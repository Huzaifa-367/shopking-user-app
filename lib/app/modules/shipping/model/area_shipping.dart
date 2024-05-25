// To parse this JSON data, do
//
//     final areaShippingModel = areaShippingModelFromJson(jsonString);

import 'dart:convert';

AreaShippingModel areaShippingModelFromJson(String str) =>
    AreaShippingModel.fromJson(json.decode(str));

String areaShippingModelToJson(AreaShippingModel data) =>
    json.encode(data.toJson());

class AreaShippingModel {
  List<areaShippingModel>? data;

  AreaShippingModel({
    this.data,
  });

  AreaShippingModel copyWith({
    List<areaShippingModel>? data,
  }) =>
      AreaShippingModel(
        data: data ?? this.data,
      );

  factory AreaShippingModel.fromJson(Map<String, dynamic> json) =>
      AreaShippingModel(
        data: json["data"] == null
            ? []
            : List<areaShippingModel>.from(
                json["data"]!.map((x) => areaShippingModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class areaShippingModel {
  int? id;
  String? country;
  String? state;
  String? city;
  String? shippingCost;
  int? status;

  areaShippingModel({
    this.id,
    this.country,
    this.state,
    this.city,
    this.shippingCost,
    this.status,
  });

  areaShippingModel copyWith({
    int? id,
    String? country,
    String? state,
    String? city,
    String? shippingCost,
    int? status,
  }) =>
      areaShippingModel(
        id: id ?? this.id,
        country: country ?? this.country,
        state: state ?? this.state,
        city: city ?? this.city,
        shippingCost: shippingCost ?? this.shippingCost,
        status: status ?? this.status,
      );

  factory areaShippingModel.fromJson(Map<String, dynamic> json) =>
      areaShippingModel(
        id: json["id"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        shippingCost: json["shipping_cost"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
        "state": state,
        "city": city,
        "shipping_cost": shippingCost,
        "status": status,
      };
}
