class ReturnReasonModel {
  List<Data>? data;

  ReturnReasonModel({this.data});

  ReturnReasonModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  int? status;
  String? details;

  Data({this.id, this.title, this.status, this.details});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['status'] = this.status;
    data['details'] = this.details;
    return data;
  }
}