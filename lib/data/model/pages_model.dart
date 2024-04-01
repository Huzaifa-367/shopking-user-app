class PagesModel {
  List<Data>? data;

  PagesModel({this.data});

  PagesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  int? id;
  String? title;
  String? slug;
  String? description;
  int? menuSectionId;
  int? templateId;
  int? status;
  String? image;

  Data(
      {this.id,
      this.title,
      this.slug,
      this.description,
      this.menuSectionId,
      this.templateId,
      this.status,
      this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    menuSectionId = json['menu_section_id'];
    templateId = json['template_id'];
    status = json['status'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['description'] = description;
    data['menu_section_id'] = menuSectionId;
    data['template_id'] = templateId;
    data['status'] = status;
    data['image'] = image;
    return data;
  }
}
