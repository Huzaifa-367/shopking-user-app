// To parse this JSON data, do
//
//     final outletModel = outletModelFromJson(jsonString);

import 'dart:convert';

OutletModel outletModelFromJson(String str) =>
    OutletModel.fromJson(json.decode(str));

String outletModelToJson(OutletModel data) => json.encode(data.toJson());

class OutletModel {
  final List<Datum>? data;

  OutletModel({
    this.data,
  });

  factory OutletModel.fromJson(Map<String, dynamic> json) => OutletModel(
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
  final String? email;
  final String? phone;
  final String? countryCode;
  final String? latitude;
  final String? longitude;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? address;
  final int? status;

  Datum({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.countryCode,
    this.latitude,
    this.longitude,
    this.city,
    this.state,
    this.zipCode,
    this.address,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        countryCode: json["country_code"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zip_code"],
        address: json["address"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "country_code": countryCode,
        "latitude": latitude,
        "longitude": longitude,
        "city": city,
        "state": state,
        "zip_code": zipCode,
        "address": address,
        "status": status,
      };
}
