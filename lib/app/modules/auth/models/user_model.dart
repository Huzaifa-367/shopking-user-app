// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final bool? status;
  final String? message;
  final String? token;
  final User? user;
  final List<Menu>? menu;
  final List<Permission>? permission;
  final DefaultPermission? defaultPermission;

  UserModel({
    this.status,
    this.message,
    this.token,
    this.user,
    this.menu,
    this.permission,
    this.defaultPermission,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        menu: json["menu"] == null
            ? []
            : List<Menu>.from(json["menu"]!.map((x) => Menu.fromJson(x))),
        permission: json["permission"] == null
            ? []
            : List<Permission>.from(
                json["permission"]!.map((x) => Permission.fromJson(x))),
        defaultPermission: json["defaultPermission"] == null
            ? null
            : DefaultPermission.fromJson(json["defaultPermission"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
        "user": user?.toJson(),
        "menu": menu == null
            ? []
            : List<dynamic>.from(menu!.map((x) => x.toJson())),
        "permission": permission == null
            ? []
            : List<dynamic>.from(permission!.map((x) => x.toJson())),
        "defaultPermission": defaultPermission?.toJson(),
      };
}

class DefaultPermission {
  DefaultPermission();

  factory DefaultPermission.fromJson(Map<String, dynamic> json) =>
      DefaultPermission();

  Map<String, dynamic> toJson() => {};
}

class Menu {
  final int? id;
  final String? name;
  final String? language;
  final String? url;
  final String? icon;
  final int? status;
  final int? parent;
  final int? type;
  final int? priority;
  final List<Menu>? children;

  Menu({
    this.id,
    this.name,
    this.language,
    this.url,
    this.icon,
    this.status,
    this.parent,
    this.type,
    this.priority,
    this.children,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json["id"],
        name: json["name"],
        language: json["language"],
        url: json["url"],
        icon: json["icon"],
        status: json["status"],
        parent: json["parent"],
        type: json["type"],
        priority: json["priority"],
        children: json["children"] == null
            ? []
            : List<Menu>.from(json["children"]!.map((x) => Menu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "language": language,
        "url": url,
        "icon": icon,
        "status": status,
        "parent": parent,
        "type": type,
        "priority": priority,
        "children": children == null
            ? []
            : List<dynamic>.from(children!.map((x) => x.toJson())),
      };
}

class Permission {
  final int? id;
  final String? title;
  final String? name;
  final String? url;
  final bool? access;

  Permission({
    this.id,
    this.title,
    this.name,
    this.url,
    this.access,
  });

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
        id: json["id"],
        title: json["title"],
        name: json["name"],
        url: json["url"],
        access: json["access"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "name": name,
        "url": url,
        "access": access,
      };
}

class User {
  final int? id;
  final String? name;
  final dynamic phone;
  final String? email;
  final String? username;
  final String? balance;
  final String? currencyBalance;
  final String? image;
  final int? roleId;
  final dynamic countryCode;
  final int? order;
  final String? createDate;
  final String? updateDate;

  User({
    this.id,
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
    this.updateDate,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        username: json["username"],
        balance: json["balance"],
        currencyBalance: json["currency_balance"],
        image: json["image"],
        roleId: json["role_id"],
        countryCode: json["country_code"],
        order: json["order"],
        createDate: json["create_date"],
        updateDate: json["update_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "username": username,
        "balance": balance,
        "currency_balance": currencyBalance,
        "image": image,
        "role_id": roleId,
        "country_code": countryCode,
        "order": order,
        "create_date": createDate,
        "update_date": updateDate,
      };
}
