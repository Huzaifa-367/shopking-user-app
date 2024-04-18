// To parse this JSON data, do
//
//     final showAddressModel = showAddressModelFromJson(jsonString);

import 'dart:convert';

import 'package:shopperz/data/model/profile_address_model.dart';

ShowAddressModel showAddressModelFromJson(String str) =>
    ShowAddressModel.fromJson(json.decode(str));

String showAddressModelToJson(ShowAddressModel data) =>
    json.encode(data.toJson());

class ShowAddressModel {
  final List<AddressModel>? data;

  ShowAddressModel({
    this.data,
  });

  factory ShowAddressModel.fromJson(Map<String, dynamic> json) =>
      ShowAddressModel(
        data: json["data"] == null
            ? []
            : List<AddressModel>.from(
                json["data"]!.map((x) => AddressModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
