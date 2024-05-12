import 'dart:convert';

UserModel userFromJson(String res) => UserModel.fromJson(jsonDecode(res));

class UserModel {
  dynamic id;
  String? name;
  String? email;
  String? phone;
  int? expireIn;
  int? createAt;
  String? token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.expireIn,
    required this.createAt,
    required this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    expireIn = json["expireIn"];
    createAt = json["createAt"];
    token = json["token"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["phone"] = phone;
    data["expireIn"] = expireIn;
    data["createAt"] = createAt;
    data["token"] = token;
    return data;
  }
}
