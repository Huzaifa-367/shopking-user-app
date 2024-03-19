// To parse this JSON data, do
//
//     final childrenVariationModel = childrenVariationModelFromJson(jsonString);

import 'dart:convert';

ChildrenVariationModel childrenVariationModelFromJson(String str) => ChildrenVariationModel.fromJson(json.decode(str));

String childrenVariationModelToJson(ChildrenVariationModel data) => json.encode(data.toJson());

class ChildrenVariationModel {
    final List<Datum>? data;

    ChildrenVariationModel({
        this.data,
    });

    factory ChildrenVariationModel.fromJson(Map<String, dynamic> json) => ChildrenVariationModel(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    final int? id;
    final int? productAttributeId;
    final int? productAttributeOptionId;
    final String? productAttributeName;
    final String? productAttributeOptionName;
    final int? price;
    final String? currencyPrice;
    final int? oldPrice;
    final String? oldCurrencyPrice;
    final int? discount;
    final int? discountPercentage;
    final String? sku;
    final int? stock;

    Datum({
        this.id,
        this.productAttributeId,
        this.productAttributeOptionId,
        this.productAttributeName,
        this.productAttributeOptionName,
        this.price,
        this.currencyPrice,
        this.oldPrice,
        this.oldCurrencyPrice,
        this.discount,
        this.discountPercentage,
        this.sku,
        this.stock,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productAttributeId: json["product_attribute_id"],
        productAttributeOptionId: json["product_attribute_option_id"],
        productAttributeName: json["product_attribute_name"],
        productAttributeOptionName: json["product_attribute_option_name"],
        price: json["price"],
        currencyPrice: json["currency_price"],
        oldPrice: json["old_price"],
        oldCurrencyPrice: json["old_currency_price"],
        discount: json["discount"],
        discountPercentage: json["discount_percentage"],
        sku: json["sku"],
        stock: json["stock"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_attribute_id": productAttributeId,
        "product_attribute_option_id": productAttributeOptionId,
        "product_attribute_name": productAttributeName,
        "product_attribute_option_name": productAttributeOptionName,
        "price": price,
        "currency_price": currencyPrice,
        "old_price": oldPrice,
        "old_currency_price": oldCurrencyPrice,
        "discount": discount,
        "discount_percentage": discountPercentage,
        "sku": sku,
        "stock": stock,
    };
}
