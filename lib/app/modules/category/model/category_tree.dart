// To parse this JSON data, do
//
//     final categoryTreeModel = categoryTreeModelFromJson(jsonString);

import 'dart:convert';

List<CategoryTreeModel> categoryTreeModelFromJson(String str) =>
    List<CategoryTreeModel>.from(
        json.decode(str).map((x) => CategoryTreeModel.fromJson(x)));

String categoryTreeModelToJson(List<CategoryTreeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryTreeModel {
  final int? id;
  final String? name;
  final String? slug;
  final dynamic description;
  final int? status;
  final int? parentId;
  final dynamic creatorType;
  final dynamic creatorId;
  final dynamic editorType;
  final dynamic editorId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic depth;
  final String? path;
  final String? cover;
  final List<CategoryTreeModel>? children;
  final List<Media>? media;

  CategoryTreeModel({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.status,
    this.parentId,
    this.creatorType,
    this.creatorId,
    this.editorType,
    this.editorId,
    this.createdAt,
    this.updatedAt,
    this.depth,
    this.path,
    this.cover,
    this.children,
    this.media,
  });

  factory CategoryTreeModel.fromJson(Map<String, dynamic> json) =>
      CategoryTreeModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        status: json["status"],
        parentId: json["parent_id"],
        creatorType: json["creator_type"],
        creatorId: json["creator_id"],
        editorType: json["editor_type"],
        editorId: json["editor_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        depth: json["depth"],
        path: json["path"],
        cover: json["cover"],
        children: json["children"] == null
            ? []
            : List<CategoryTreeModel>.from(
                json["children"]!.map((x) => CategoryTreeModel.fromJson(x))),
        media: json["media"] == null
            ? []
            : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "description": description,
        "status": status,
        "parent_id": parentId,
        "creator_type": creatorType,
        "creator_id": creatorId,
        "editor_type": editorType,
        "editor_id": editorId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "depth": depth,
        "path": path,
        "cover": cover,
        "children": children == null
            ? []
            : List<dynamic>.from(children!.map((x) => x.toJson())),
        "media": media == null
            ? []
            : List<dynamic>.from(media!.map((x) => x.toJson())),
      };
}

class Media {
  final int? id;
  final ModelType? modelType;
  final dynamic modelId;
  final String? uuid;
  final CollectionName? collectionName;
  final String? name;
  final String? fileName;
  final MimeType? mimeType;
  final Disk? disk;
  final Disk? conversionsDisk;
  final dynamic size;
  final List<dynamic>? manipulations;
  final List<dynamic>? customProperties;
  final GeneratedConversions? generatedConversions;
  final List<dynamic>? responsiveImages;
  final dynamic orderColumn;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? originalUrl;
  final String? previewUrl;

  Media({
    this.id,
    this.modelType,
    this.modelId,
    this.uuid,
    this.collectionName,
    this.name,
    this.fileName,
    this.mimeType,
    this.disk,
    this.conversionsDisk,
    this.size,
    this.manipulations,
    this.customProperties,
    this.generatedConversions,
    this.responsiveImages,
    this.orderColumn,
    this.createdAt,
    this.updatedAt,
    this.originalUrl,
    this.previewUrl,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        modelType: modelTypeValues.map[json["model_type"]]!,
        modelId: json["model_id"],
        uuid: json["uuid"],
        collectionName: collectionNameValues.map[json["collection_name"]],
        name: json["name"],
        fileName: json["file_name"],
        mimeType: mimeTypeValues.map[json["mime_type"]],
        disk: diskValues.map[json["disk"]]!,
        conversionsDisk: diskValues.map[json["conversions_disk"]]!,
        size: json["size"],
        manipulations: json["manipulations"] == null
            ? []
            : List<dynamic>.from(json["manipulations"]!.map((x) => x)),
        customProperties: json["custom_properties"] == null
            ? []
            : List<dynamic>.from(json["custom_properties"]!.map((x) => x)),
        generatedConversions: json["generated_conversions"] == null
            ? null
            : GeneratedConversions.fromJson(json["generated_conversions"]),
        responsiveImages: json["responsive_images"] == null
            ? []
            : List<dynamic>.from(json["responsive_images"]!.map((x) => x)),
        orderColumn: json["order_column"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        originalUrl: json["original_url"],
        previewUrl: json["preview_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "model_type": modelTypeValues.reverse[modelType],
        "model_id": modelId,
        "uuid": uuid,
        "collection_name": collectionNameValues.reverse[collectionName],
        "name": name,
        "file_name": fileName,
        "mime_type": mimeTypeValues.reverse[mimeType],
        "disk": diskValues.reverse[disk],
        "conversions_disk": diskValues.reverse[conversionsDisk],
        "size": size,
        "manipulations": manipulations == null
            ? []
            : List<dynamic>.from(manipulations!.map((x) => x)),
        "custom_properties": customProperties == null
            ? []
            : List<dynamic>.from(customProperties!.map((x) => x)),
        "generated_conversions": generatedConversions?.toJson(),
        "responsive_images": responsiveImages == null
            ? []
            : List<dynamic>.from(responsiveImages!.map((x) => x)),
        "order_column": orderColumn,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "original_url": originalUrl,
        "preview_url": previewUrl,
      };
}

enum CollectionName { PRODUCT_CATEGORY }

final collectionNameValues =
    EnumValues({"product-category": CollectionName.PRODUCT_CATEGORY});

enum Disk { PUBLIC }

final diskValues = EnumValues({"public": Disk.PUBLIC});

class GeneratedConversions {
  final bool? cover;
  final bool? thumb;

  GeneratedConversions({
    this.cover,
    this.thumb,
  });

  factory GeneratedConversions.fromJson(Map<String, dynamic> json) =>
      GeneratedConversions(
        cover: json["cover"],
        thumb: json["thumb"],
      );

  Map<String, dynamic> toJson() => {
        "cover": cover,
        "thumb": thumb,
      };
}

enum MimeType { IMAGE_PNG }

final mimeTypeValues = EnumValues({"image/png": MimeType.IMAGE_PNG});

enum ModelType { APP_MODELS_PRODUCT_CATEGORY }

final modelTypeValues = EnumValues(
    {"App\\Models\\ProductCategory": ModelType.APP_MODELS_PRODUCT_CATEGORY});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
