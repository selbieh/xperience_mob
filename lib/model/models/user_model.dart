// UserModel userFromJson(String res) => UserModel.fromJson(jsonDecode(res));

class UserModel {
  String? refresh;
  String? access;
  UserInfo? user;

  UserModel({this.refresh, this.access, this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
    user = json['user'] != null ? UserInfo.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refresh'] = refresh;
    data['access'] = access;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class UserInfo {
  int? id;
  String? name;
  String? email;
  String? mobile;
  int? wallet;
  bool? isStaff;

  UserInfo({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.wallet,
    this.isStaff,
  });

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    wallet = json['wallet'];
    isStaff = json['is_staff'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['wallet'] = wallet;
    data['is_staff'] = isStaff;
    return data;
  }
}
