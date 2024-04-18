class ProfileAddressModel {
  List<AddressModel>? data;

  ProfileAddressModel({this.data});

  ProfileAddressModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AddressModel>[];
      json['data'].forEach((v) {
        data!.add(AddressModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressModel {
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
  final String? house_no;
  final int? floor_no;
  final dynamic latitude;
  final dynamic longitude;

  AddressModel({
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
    this.floor_no,
    this.house_no,
    this.latitude,
    this.longitude,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
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
        house_no: json["house_no"],
        floor_no: int.parse(json["floor_no"]),
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
        "house_no": house_no,
        "floor_no": floor_no,
        "latitude": latitude,
        "longitude": longitude,
      };
}
