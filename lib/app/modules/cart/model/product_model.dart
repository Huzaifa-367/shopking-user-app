// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    Data? data;

    ProductModel({
        this.data,
    });

    ProductModel copyWith({
        Data? data,
    }) => 
        ProductModel(
            data: data ?? this.data,
        );

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class Data {
    int? id;
    String? name;
    String? slug;
    dynamic price;
    String? currencyPrice;
    dynamic oldPrice;
    String? oldCurrencyPrice;
    dynamic discount;
    int? discountPercentage;
    bool? flashSale;
    bool? isOffer;
    String? ratingStar;
    int? ratingStarCount;
    String? image;
    List<String>? images;
    List<Tax>? taxes;
    List<Review>? reviews;
    List<Video>? videos;
    Seo? seo;
    bool? wishlist;
    String? details;
    String? shippingAndReturn;
    String? categorySlug;
    String? unit;
    int? stock;
    String? sku;
    Shipping? shipping;

    Data({
        this.id,
        this.name,
        this.slug,
        this.price,
        this.currencyPrice,
        this.oldPrice,
        this.oldCurrencyPrice,
        this.discount,
        this.discountPercentage,
        this.flashSale,
        this.isOffer,
        this.ratingStar,
        this.ratingStarCount,
        this.image,
        this.images,
        this.taxes,
        this.reviews,
        this.videos,
        this.seo,
        this.wishlist,
        this.details,
        this.shippingAndReturn,
        this.categorySlug,
        this.unit,
        this.stock,
        this.sku,
        this.shipping,
    });

    Data copyWith({
        int? id,
        String? name,
        String? slug,
        dynamic price,
        String? currencyPrice,
        dynamic oldPrice,
        String? oldCurrencyPrice,
        dynamic discount,
        int? discountPercentage,
        bool? flashSale,
        bool? isOffer,
        String? ratingStar,
        int? ratingStarCount,
        String? image,
        List<String>? images,
        List<Tax>? taxes,
        List<Review>? reviews,
        List<Video>? videos,
        Seo? seo,
        bool? wishlist,
        String? details,
        String? shippingAndReturn,
        String? categorySlug,
        String? unit,
        int? stock,
        String? sku,
        Shipping? shipping,
    }) => 
        Data(
            id: id ?? this.id,
            name: name ?? this.name,
            slug: slug ?? this.slug,
            price: price ?? this.price,
            currencyPrice: currencyPrice ?? this.currencyPrice,
            oldPrice: oldPrice ?? this.oldPrice,
            oldCurrencyPrice: oldCurrencyPrice ?? this.oldCurrencyPrice,
            discount: discount ?? this.discount,
            discountPercentage: discountPercentage ?? this.discountPercentage,
            flashSale: flashSale ?? this.flashSale,
            isOffer: isOffer ?? this.isOffer,
            ratingStar: ratingStar ?? this.ratingStar,
            ratingStarCount: ratingStarCount ?? this.ratingStarCount,
            image: image ?? this.image,
            images: images ?? this.images,
            taxes: taxes ?? this.taxes,
            reviews: reviews ?? this.reviews,
            videos: videos ?? this.videos,
            seo: seo ?? this.seo,
            wishlist: wishlist ?? this.wishlist,
            details: details ?? this.details,
            shippingAndReturn: shippingAndReturn ?? this.shippingAndReturn,
            categorySlug: categorySlug ?? this.categorySlug,
            unit: unit ?? this.unit,
            stock: stock ?? this.stock,
            sku: sku ?? this.sku,
            shipping: shipping ?? this.shipping,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        price: json["price"],
        currencyPrice: json["currency_price"],
        oldPrice: json["old_price"],
        oldCurrencyPrice: json["old_currency_price"],
        discount: json["discount"],
        discountPercentage: json["discount_percentage"],
        flashSale: json["flash_sale"],
        isOffer: json["is_offer"],
        ratingStar: json["rating_star"],
        ratingStarCount: json["rating_star_count"],
        image: json["image"],
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        taxes: json["taxes"] == null ? [] : List<Tax>.from(json["taxes"]!.map((x) => Tax.fromJson(x))),
        reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
        videos: json["videos"] == null ? [] : List<Video>.from(json["videos"]!.map((x) => Video.fromJson(x))),
        seo: json["seo"] == null ? null : Seo.fromJson(json["seo"]),
        wishlist: json["wishlist"],
        details: json["details"],
        shippingAndReturn: json["shipping_and_return"],
        categorySlug: json["category_slug"],
        unit: json["unit"],
        stock: json["stock"],
        sku: json["sku"],
        shipping: json["shipping"] == null ? null : Shipping.fromJson(json["shipping"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "price": price,
        "currency_price": currencyPrice,
        "old_price": oldPrice,
        "old_currency_price": oldCurrencyPrice,
        "discount": discount,
        "discount_percentage": discountPercentage,
        "flash_sale": flashSale,
        "is_offer": isOffer,
        "rating_star": ratingStar,
        "rating_star_count": ratingStarCount,
        "image": image,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "taxes": taxes == null ? [] : List<dynamic>.from(taxes!.map((x) => x.toJson())),
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x.toJson())),
        "seo": seo?.toJson(),
        "wishlist": wishlist,
        "details": details,
        "shipping_and_return": shippingAndReturn,
        "category_slug": categorySlug,
        "unit": unit,
        "stock": stock,
        "sku": sku,
        "shipping": shipping?.toJson(),
    };
}

class Review {
    int? id;
    int? userId;
    String? name;
    int? productId;
    int? star;
    String? review;
    List<String>? images;

    Review({
        this.id,
        this.userId,
        this.name,
        this.productId,
        this.star,
        this.review,
        this.images,
    });

    Review copyWith({
        int? id,
        int? userId,
        String? name,
        int? productId,
        int? star,
        String? review,
        List<String>? images,
    }) => 
        Review(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            name: name ?? this.name,
            productId: productId ?? this.productId,
            star: star ?? this.star,
            review: review ?? this.review,
            images: images ?? this.images,
        );

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        productId: json["product_id"],
        star: json["star"],
        review: json["review"],
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "product_id": productId,
        "star": star,
        "review": review,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    };
}

class Seo {
    int? id;
    int? productId;
    String? title;
    String? description;
    String? metaKeyword;
    String? thumb;
    String? cover;

    Seo({
        this.id,
        this.productId,
        this.title,
        this.description,
        this.metaKeyword,
        this.thumb,
        this.cover,
    });

    Seo copyWith({
        int? id,
        int? productId,
        String? title,
        String? description,
        String? metaKeyword,
        String? thumb,
        String? cover,
    }) => 
        Seo(
            id: id ?? this.id,
            productId: productId ?? this.productId,
            title: title ?? this.title,
            description: description ?? this.description,
            metaKeyword: metaKeyword ?? this.metaKeyword,
            thumb: thumb ?? this.thumb,
            cover: cover ?? this.cover,
        );

    factory Seo.fromJson(Map<String, dynamic> json) => Seo(
        id: json["id"],
        productId: json["product_id"],
        title: json["title"],
        description: json["description"],
        metaKeyword: json["meta_keyword"],
        thumb: json["thumb"],
        cover: json["cover"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "title": title,
        "description": description,
        "meta_keyword": metaKeyword,
        "thumb": thumb,
        "cover": cover,
    };
}

class Shipping {
    int? shippingType;
    String? shippingCost;
    int? isProductQuantityMultiply;

    Shipping({
        this.shippingType,
        this.shippingCost,
        this.isProductQuantityMultiply,
    });

    Shipping copyWith({
        int? shippingType,
        String? shippingCost,
        int? isProductQuantityMultiply,
    }) => 
        Shipping(
            shippingType: shippingType ?? this.shippingType,
            shippingCost: shippingCost ?? this.shippingCost,
            isProductQuantityMultiply: isProductQuantityMultiply ?? this.isProductQuantityMultiply,
        );

    factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
        shippingType: json["shipping_type"],
        shippingCost: json["shipping_cost"],
        isProductQuantityMultiply: json["is_product_quantity_multiply"],
    );

    Map<String, dynamic> toJson() => {
        "shipping_type": shippingType,
        "shipping_cost": shippingCost,
        "is_product_quantity_multiply": isProductQuantityMultiply,
    };
}

class Tax {
    int? id;
    String? name;
    String? code;
    String? taxRate;
    int? status;

    Tax({
        this.id,
        this.name,
        this.code,
        this.taxRate,
        this.status,
    });

    Tax copyWith({
        int? id,
        String? name,
        String? code,
        String? taxRate,
        int? status,
    }) => 
        Tax(
            id: id ?? this.id,
            name: name ?? this.name,
            code: code ?? this.code,
            taxRate: taxRate ?? this.taxRate,
            status: status ?? this.status,
        );

    factory Tax.fromJson(Map<String, dynamic> json) => Tax(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        taxRate: json["tax_rate"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "tax_rate": taxRate,
        "status": status,
    };
}

class Video {
    int? id;
    int? productId;
    int? videoProvider;
    String? providerName;
    String? link;

    Video({
        this.id,
        this.productId,
        this.videoProvider,
        this.providerName,
        this.link,
    });

    Video copyWith({
        int? id,
        int? productId,
        int? videoProvider,
        String? providerName,
        String? link,
    }) => 
        Video(
            id: id ?? this.id,
            productId: productId ?? this.productId,
            videoProvider: videoProvider ?? this.videoProvider,
            providerName: providerName ?? this.providerName,
            link: link ?? this.link,
        );

    factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        productId: json["product_id"],
        videoProvider: json["video_provider"],
        providerName: json["provider_name"],
        link: json["link"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "video_provider": videoProvider,
        "provider_name": providerName,
        "link": link,
    };
}