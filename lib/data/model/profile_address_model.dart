class ProfileAddressModel {
  List<Data>? data;

  ProfileAddressModel({this.data});

  ProfileAddressModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? fullName;
  String? email;
  String? countryCode;
  String? phone;
  String? address;
  String? country;
  String? state;
  String? city;
  String? zipCode;
  String? latitude;
  String? longitude;

  Data(
      {this.id,
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
      this.longitude});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    fullName = json['full_name'];
    email = json['email'];
    countryCode = json['country_code'];
    phone = json['phone'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    zipCode = json['zip_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zip_code'] = this.zipCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}