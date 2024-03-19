class ReviewDetailsModel {
  Data? data;

  ReviewDetailsModel({this.data});

  ReviewDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? name;
  int? productId;
  int? star;
  String? review;
  List<String>? images;

  Data(
      {this.id,
      this.userId,
      this.name,
      this.productId,
      this.star,
      this.review,
      this.images});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    productId = json['product_id'];
    star = json['star'];
    review = json['review'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['product_id'] = this.productId;
    data['star'] = this.star;
    data['review'] = this.review;
    data['images'] = this.images;
    return data;
  }
}