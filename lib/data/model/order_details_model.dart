import 'package:shopperz/data/model/profile_address_model.dart';

class OrderDetailsModel {
  Data? data;

  OrderDetailsModel({this.data});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  List<AddressModel>? orderAddress;
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
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['order_address'] != null) {
      orderAddress = <AddressModel>[];
      json['order_address'].forEach((v) {
        orderAddress!.add(AddressModel.fromJson(v));
      });
    }
    outletAddress = json['outlet_address'] != null
        ? OutletAddress.fromJson(json['outlet_address'])
        : null;
    if (json['order_products'] != null) {
      orderProducts = <OrderProducts>[];
      json['order_products'].forEach((v) {
        orderProducts!.add(OrderProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_serial_no'] = orderSerialNo;
    data['user_id'] = userId;
    data['subtotal_currency_price'] = subtotalCurrencyPrice;
    data['tax_currency_price'] = taxCurrencyPrice;
    data['discount_currency_price'] = discountCurrencyPrice;
    data['total_currency_price'] = totalCurrencyPrice;
    data['total_amount_price'] = totalAmountPrice;
    data['shipping_charge_currency_price'] = shippingChargeCurrencyPrice;
    data['order_type'] = orderType;
    data['order_date'] = orderDate;
    data['order_time'] = orderTime;
    data['order_datetime'] = orderDatetime;
    data['payment_method'] = paymentMethod;
    data['payment_method_name'] = paymentMethodName;
    data['payment_status'] = paymentStatus;
    data['status'] = status;
    data['reason'] = reason;
    data['source'] = source;
    data['active'] = active;
    data['return_and_refund'] = returnAndRefund;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (orderAddress != null) {
      data['order_address'] = orderAddress!.map((v) => v.toJson()).toList();
    }
    if (outletAddress != null) {
      data['outlet_address'] = outletAddress!.toJson();
    }
    if (orderProducts != null) {
      data['order_products'] = orderProducts!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['username'] = username;
    data['balance'] = balance;
    data['currency_balance'] = currencyBalance;
    data['image'] = image;
    data['role_id'] = roleId;
    data['country_code'] = countryCode;
    data['order'] = order;
    data['create_date'] = createDate;
    data['update_date'] = updateDate;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['country_code'] = countryCode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['city'] = city;
    data['state'] = state;
    data['zip_code'] = zipCode;
    data['address'] = address;
    data['status'] = status;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['product_image'] = productImage;
    data['product_slug'] = productSlug;
    data['category_name'] = categoryName;
    data['price'] = price;
    data['currency_price'] = currencyPrice;
    data['quantity'] = quantity;
    data['order_quantity'] = orderQuantity;
    data['discount'] = discount;
    data['discount_currency_price'] = discountCurrencyPrice;
    data['tax'] = tax;
    data['tax_currency'] = taxCurrency;
    data['subtotal'] = subtotal;
    data['total'] = total;
    data['subtotal_currency_price'] = subtotalCurrencyPrice;
    data['total_currency_price'] = totalCurrencyPrice;
    data['status'] = status;
    data['variation_names'] = variationNames;
    data['product_user_review'] = productUserReview;
    data['product_user_review_id'] = productUserReviewId;
    data['is_refundable'] = isRefundable;
    data['has_variation'] = hasVariation;
    data['variation_id'] = variationId;
    return data;
  }
}
