// To parse this JSON data, do
//
//     final showAddressModel = showAddressModelFromJson(jsonString);

import 'dart:convert';

ShowAddressModel showAddressModelFromJson(String str) =>
    ShowAddressModel.fromJson(json.decode(str));

String showAddressModelToJson(ShowAddressModel data) =>
    json.encode(data.toJson());

class ShowAddressModel {
  final List<Datum>? data;

  ShowAddressModel({
    this.data,
  });

  factory ShowAddressModel.fromJson(Map<String, dynamic> json) =>
      ShowAddressModel(
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
  final int? userId;
  final String? fullName;
  final String? email;
  final String? countryCode;
  final String? phone;
  final String? address;
  final String? country;
  final String? state;
  final String? city;
  final String? zipCode;
  final dynamic latitude;
  final dynamic longitude;

  Datum({
    this.id,
    this.userId,
    this.fullName,
    this.email,
    this.countryCode,
    this.phone,
    this.address,
    this.country,
    this.state,
    this.city,
    this.zipCode,
    this.latitude,
    this.longitude,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        fullName: json["full_name"],
        email: json["email"],
        countryCode: json["country_code"],
        phone: json["phone"],
        address: json["address"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        zipCode: json["zip_code"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "full_name": fullName,
        "email": email,
        "country_code": countryCode,
        "phone": phone,
        "address": address,
        "country": country,
        "state": state,
        "city": city,
        "zip_code": zipCode,
        "latitude": latitude,
        "longitude": longitude,
      };
}
