class OrderDetailsModel {
  Data? data;

  OrderDetailsModel({this.data});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? orderSerialNo;
  int? userId;
  String? subtotalCurrencyPrice;
  String? taxCurrencyPrice;
  String? discountCurrencyPrice;
  String? totalCurrencyPrice;
  String? totalAmountPrice;
  String? shippingChargeCurrencyPrice;
  int? orderType;
  String? orderDate;
  String? orderTime;
  String? orderDatetime;
  int? paymentMethod;
  String? paymentMethodName;
  int? paymentStatus;
  int? status;
  String? reason;
  int? source;
  int? active;
  bool? returnAndRefund;
  User? user;
  List<OrderAddress>? orderAddress;
  OutletAddress? outletAddress;
  List<OrderProducts>? orderProducts;

  Data(
      {this.id,
      this.orderSerialNo,
      this.userId,
      this.subtotalCurrencyPrice,
      this.taxCurrencyPrice,
      this.discountCurrencyPrice,
      this.totalCurrencyPrice,
      this.totalAmountPrice,
      this.shippingChargeCurrencyPrice,
      this.orderType,
      this.orderDate,
      this.orderTime,
      this.orderDatetime,
      this.paymentMethod,
      this.paymentMethodName,
      this.paymentStatus,
      this.status,
      this.reason,
      this.source,
      this.active,
      this.returnAndRefund,
      this.user,
      this.orderAddress,
      this.outletAddress,
      this.orderProducts});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderSerialNo = json['order_serial_no'];
    userId = json['user_id'];
    subtotalCurrencyPrice = json['subtotal_currency_price'];
    taxCurrencyPrice = json['tax_currency_price'];
    discountCurrencyPrice = json['discount_currency_price'];
    totalCurrencyPrice = json['total_currency_price'];
    totalAmountPrice = json['total_amount_price'];
    shippingChargeCurrencyPrice = json['shipping_charge_currency_price'];
    orderType = json['order_type'];
    orderDate = json['order_date'];
    orderTime = json['order_time'];
    orderDatetime = json['order_datetime'];
    paymentMethod = json['payment_method'];
    paymentMethodName = json['payment_method_name'];
    paymentStatus = json['payment_status'];
    status = json['status'];
    reason = json['reason'];
    source = json['source'];
    active = json['active'];
    returnAndRefund = json['return_and_refund'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['order_address'] != null) {
      orderAddress = <OrderAddress>[];
      json['order_address'].forEach((v) {
        orderAddress!.add(new OrderAddress.fromJson(v));
      });
    }
    outletAddress = json['outlet_address'] != null
        ? new OutletAddress.fromJson(json['outlet_address'])
        : null;
    if (json['order_products'] != null) {
      orderProducts = <OrderProducts>[];
      json['order_products'].forEach((v) {
        orderProducts!.add(new OrderProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_serial_no'] = this.orderSerialNo;
    data['user_id'] = this.userId;
    data['subtotal_currency_price'] = this.subtotalCurrencyPrice;
    data['tax_currency_price'] = this.taxCurrencyPrice;
    data['discount_currency_price'] = this.discountCurrencyPrice;
    data['total_currency_price'] = this.totalCurrencyPrice;
    data['total_amount_price'] = this.totalAmountPrice;
    data['shipping_charge_currency_price'] = this.shippingChargeCurrencyPrice;
    data['order_type'] = this.orderType;
    data['order_date'] = this.orderDate;
    data['order_time'] = this.orderTime;
    data['order_datetime'] = this.orderDatetime;
    data['payment_method'] = this.paymentMethod;
    data['payment_method_name'] = this.paymentMethodName;
    data['payment_status'] = this.paymentStatus;
    data['status'] = this.status;
    data['reason'] = this.reason;
    data['source'] = this.source;
    data['active'] = this.active;
    data['return_and_refund'] = this.returnAndRefund;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.orderAddress != null) {
      data['order_address'] =
          this.orderAddress!.map((v) => v.toJson()).toList();
    }
    if (this.outletAddress != null) {
      data['outlet_address'] = this.outletAddress!.toJson();
    }
    if (this.orderProducts != null) {
      data['order_products'] =
          this.orderProducts!.map((v) => v.toJson()).toList();
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

class OrderAddress {
  int? id;
  int? userId;
  int? addressType;
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

  OrderAddress(
      {this.id,
      this.userId,
      this.addressType,
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

  OrderAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    addressType = json['address_type'];
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
    data['address_type'] = this.addressType;
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

class OutletAddress {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? countryCode;
  String? latitude;
  String? longitude;
  String? city;
  String? state;
  String? zipCode;
  String? address;
  String? status;

  OutletAddress(
      {this.id,
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
      this.status});

  OutletAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    countryCode = json['country_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zip_code'];
    address = json['address'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['country_code'] = this.countryCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip_code'] = this.zipCode;
    data['address'] = this.address;
    data['status'] = this.status;
    return data;
  }
}

class OrderProducts {
  int? id;
  int? orderId;
  int? productId;
  String? productName;
  String? productImage;
  String? productSlug;
  String? categoryName;
  String? price;
  String? currencyPrice;
  int? quantity;
  int? orderQuantity;
  String? discount;
  String? discountCurrencyPrice;
  String? tax;
  String? taxCurrency;
  String? subtotal;
  String? total;
  String? subtotalCurrencyPrice;
  String? totalCurrencyPrice;
  int? status;
  String? variationNames;
  bool? productUserReview;
  int? productUserReviewId;
  bool? isRefundable;
  bool? hasVariation;
  int? variationId;

  OrderProducts(
      {this.id,
      this.orderId,
      this.productId,
      this.productName,
      this.productImage,
      this.productSlug,
      this.categoryName,
      this.price,
      this.currencyPrice,
      this.quantity,
      this.orderQuantity,
      this.discount,
      this.discountCurrencyPrice,
      this.tax,
      this.taxCurrency,
      this.subtotal,
      this.total,
      this.subtotalCurrencyPrice,
      this.totalCurrencyPrice,
      this.status,
      this.variationNames,
      this.productUserReview,
      this.productUserReviewId,
      this.isRefundable,
      this.hasVariation,
      this.variationId});

  OrderProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    productSlug = json['product_slug'];
    categoryName = json['category_name'];
    price = json['price'];
    currencyPrice = json['currency_price'];
    quantity = json['quantity'];
    orderQuantity = json['order_quantity'];
    discount = json['discount'];
    discountCurrencyPrice = json['discount_currency_price'];
    tax = json['tax'];
    taxCurrency = json['tax_currency'];
    subtotal = json['subtotal'];
    total = json['total'];
    subtotalCurrencyPrice = json['subtotal_currency_price'];
    totalCurrencyPrice = json['total_currency_price'];
    status = json['status'];
    variationNames = json['variation_names'];
    productUserReview = json['product_user_review'];
    productUserReviewId = json['product_user_review_id'];
    isRefundable = json['is_refundable'];
    hasVariation = json['has_variation'];
    variationId = json['variation_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['product_slug'] = this.productSlug;
    data['category_name'] = this.categoryName;
    data['price'] = this.price;
    data['currency_price'] = this.currencyPrice;
    data['quantity'] = this.quantity;
    data['order_quantity'] = this.orderQuantity;
    data['discount'] = this.discount;
    data['discount_currency_price'] = this.discountCurrencyPrice;
    data['tax'] = this.tax;
    data['tax_currency'] = this.taxCurrency;
    data['subtotal'] = this.subtotal;
    data['total'] = this.total;
    data['subtotal_currency_price'] = this.subtotalCurrencyPrice;
    data['total_currency_price'] = this.totalCurrencyPrice;
    data['status'] = this.status;
    data['variation_names'] = this.variationNames;
    data['product_user_review'] = this.productUserReview;
    data['product_user_review_id'] = this.productUserReviewId;
    data['is_refundable'] = this.isRefundable;
    data['has_variation'] = this.hasVariation;
    data['variation_id'] = this.variationId;
    return data;
  }
}