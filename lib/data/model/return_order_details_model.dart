class ReturnOrdersDetailsModel {
  Data? data;

  ReturnOrdersDetailsModel({this.data});

  ReturnOrdersDetailsModel.fromJson(Map<String, dynamic> json) {
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
  int? returnReasonId;
  String? returnReasonName;
  String? note;
  String? rejectReason;
  int? orderId;
  String? orderDatetime;
  String? returnDatetime;
  String? returnTotalCurrencyPrice;
  String? returnTotalPrice;
  int? userId;
  int? orderSerialNo;
  int? status;
  List<String>? images;
  User? user;
  List<ReturnProducts>? returnProducts;

  Data(
      {this.id,
      this.returnReasonId,
      this.returnReasonName,
      this.note,
      this.rejectReason,
      this.orderId,
      this.orderDatetime,
      this.returnDatetime,
      this.returnTotalCurrencyPrice,
      this.returnTotalPrice,
      this.userId,
      this.orderSerialNo,
      this.status,
      this.images,
      this.user,
      this.returnProducts});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    returnReasonId = json['return_reason_id'];
    returnReasonName = json['return_reason_name'];
    note = json['note'];
    rejectReason = json['reject_reason'];
    orderId = json['order_id'];
    orderDatetime = json['order_datetime'];
    returnDatetime = json['return_datetime'];
    returnTotalCurrencyPrice = json['return_total_currency_price'];
    returnTotalPrice = json['return_total_price'];
    userId = json['user_id'];
    orderSerialNo = json['order_serial_no'];
    status = json['status'];
    images = json['images'].cast<String>();
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['return_products'] != null) {
      returnProducts = <ReturnProducts>[];
      json['return_products'].forEach((v) {
        returnProducts!.add(new ReturnProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['return_reason_id'] = this.returnReasonId;
    data['return_reason_name'] = this.returnReasonName;
    data['note'] = this.note;
    data['reject_reason'] = this.rejectReason;
    data['order_id'] = this.orderId;
    data['order_datetime'] = this.orderDatetime;
    data['return_datetime'] = this.returnDatetime;
    data['return_total_currency_price'] = this.returnTotalCurrencyPrice;
    data['return_total_price'] = this.returnTotalPrice;
    data['user_id'] = this.userId;
    data['order_serial_no'] = this.orderSerialNo;
    data['status'] = this.status;
    data['images'] = this.images;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.returnProducts != null) {
      data['return_products'] =
          this.returnProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? username;
  String? balance;
  String? currencyBalance;
  String? image;
  int? roleId;
  String? countryCode;
  int? order;
  String? createDate;
  String? updateDate;

  User(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.username,
      this.balance,
      this.currencyBalance,
      this.image,
      this.roleId,
      this.countryCode,
      this.order,
      this.createDate,
      this.updateDate});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    username = json['username'];
    balance = json['balance'];
    currencyBalance = json['currency_balance'];
    image = json['image'];
    roleId = json['role_id'];
    countryCode = json['country_code'];
    order = json['order'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['username'] = this.username;
    data['balance'] = this.balance;
    data['currency_balance'] = this.currencyBalance;
    data['image'] = this.image;
    data['role_id'] = this.roleId;
    data['country_code'] = this.countryCode;
    data['order'] = this.order;
    data['create_date'] = this.createDate;
    data['update_date'] = this.updateDate;
    return data;
  }
}

class ReturnProducts {
  int? id;
  int? productId;
  String? productName;
  String? productImage;
  String? variationNames;
  String? categoryName;
  int? quantity;
  String? price;
  String? currencyPrice;
  String? totalCurrencyPrice;
  String? returnCurrencyPrice;

  ReturnProducts(
      {this.id,
      this.productId,
      this.productName,
      this.productImage,
      this.variationNames,
      this.categoryName,
      this.quantity,
      this.price,
      this.currencyPrice,
      this.totalCurrencyPrice,
      this.returnCurrencyPrice});

  ReturnProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    variationNames = json['variation_names'];
    categoryName = json['category_name'];
    quantity = json['quantity'];
    price = json['price'];
    currencyPrice = json['currency_price'];
    totalCurrencyPrice = json['total_currency_price'];
    returnCurrencyPrice = json['return_currency_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['variation_names'] = this.variationNames;
    data['category_name'] = this.categoryName;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['currency_price'] = this.currencyPrice;
    data['total_currency_price'] = this.totalCurrencyPrice;
    data['return_currency_price'] = this.returnCurrencyPrice;
    return data;
  }
}