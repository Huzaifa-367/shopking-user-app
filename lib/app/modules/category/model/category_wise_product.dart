// To parse this JSON data, do
//
//     final categoryWiseProduct = categoryWiseProductFromJson(jsonString);

import 'dart:convert';

CategoryWiseProduct categoryWiseProductFromJson(String str) =>
    CategoryWiseProduct.fromJson(json.decode(str));

String categoryWiseProductToJson(CategoryWiseProduct data) =>
    json.encode(data.toJson());

class CategoryWiseProduct {
  final Data? data;

  CategoryWiseProduct({
    this.data,
  });

  factory CategoryWiseProduct.fromJson(Map<String, dynamic> json) =>
      CategoryWiseProduct(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final List<Product>? products;
  final List<Brand>? brands;
  final Variations? variations;
  final int? maxPrice;
  final int? currentPage;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  Data({
    this.products,
    this.brands,
    this.variations,
    this.maxPrice,
    this.currentPage,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
        brands: json["brands"] == null
            ? []
            : List<Brand>.from(json["brands"]!.map((x) => Brand.fromJson(x))),
        variations: json["variations"] == null
            ? null
            : Variations.fromJson(json["variations"]),
        maxPrice: json["max_price"],
        currentPage: json["current_page"],
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "brands": brands == null
            ? []
            : List<dynamic>.from(brands!.map((x) => x.toJson())),
        "variations": variations?.toJson(),
        "max_price": maxPrice,
        "current_page": currentPage,
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Brand {
  final int? id;
  final String? name;

  Brand({
    this.id,
    this.name,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Link {
  final String? url;
  final String? label;
  final bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}

class Product {
  final int? id;
  final String? name;
  final String? slug;
  final String? currencyPrice;
  final String? cover;
  final bool? flashSale;
  final bool? isOffer;
  final String? discountedPrice;
  final String? ratingStar;
  final int? ratingStarCount;
  final bool? wishlist;

  Product({
    this.id,
    this.name,
    this.slug,
    this.currencyPrice,
    this.cover,
    this.flashSale,
    this.isOffer,
    this.discountedPrice,
    this.ratingStar,
    this.ratingStarCount,
    this.wishlist,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        currencyPrice: json["currency_price"],
        cover: json["cover"],
        flashSale: json["flash_sale"],
        isOffer: json["is_offer"],
        discountedPrice: json["discounted_price"],
        ratingStar: json["rating_star"],
        ratingStarCount: json["rating_star_count"],
        wishlist: json["wishlist"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "currency_price": currencyPrice,
        "cover": cover,
        "flash_sale": flashSale,
        "is_offer": isOffer,
        "discounted_price": discountedPrice,
        "rating_star": ratingStar,
        "rating_star_count": ratingStarCount,
        "wishlist": wishlist,
      };
}

class Variations {
  final List<Color>? color;
  final List<Color>? size;

  Variations({
    this.color,
    this.size,
  });

  factory Variations.fromJson(Map<String, dynamic> json) => Variations(
        color: json["color"] == null
            ? []
            : List<Color>.from(json["color"]!.map((x) => Color.fromJson(x))),
        size: json["size"] == null
            ? []
            : List<Color>.from(json["size"]!.map((x) => Color.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "color": color == null
            ? []
            : List<dynamic>.from(color!.map((x) => x.toJson())),
        "size": size == null
            ? []
            : List<dynamic>.from(size!.map((x) => x.toJson())),
      };
}

class Color {
  final String? attributeName;
  final String? attributeOptionName;
  final int? productAttributeId;
  final int? productAttributeOptionId;

  Color({
    this.attributeName,
    this.attributeOptionName,
    this.productAttributeId,
    this.productAttributeOptionId,
  });

  factory Color.fromJson(Map<String, dynamic> json) => Color(
        attributeName: json["attribute_name"],
        attributeOptionName: json["attribute_option_name"],
        productAttributeId: json["product_attribute_id"],
        productAttributeOptionId: json["product_attribute_option_id"],
      );

  Map<String, dynamic> toJson() => {
        "attribute_name": attributeName,
        "attribute_option_name": attributeOptionName,
        "product_attribute_id": productAttributeId,
        "product_attribute_option_id": productAttributeOptionId,
      };
}
