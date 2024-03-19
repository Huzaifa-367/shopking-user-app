// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

AddressModel addressModelFromJson(String str) =>
    AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  final Data? data;

  AddressModel({
    this.data,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final int? userId;
  final String? fullName;
  final dynamic email;
  final String? countryCode;
  final String? phone;
  final String? address;
  final String? country;
  final String? state;
  final String? city;
  final String? zipCode;
  final dynamic latitude;
  final dynamic longitude;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
