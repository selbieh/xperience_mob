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
  bool? isStaff;
  num? wallet;
  num? points;

  UserInfo({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.isStaff,
    this.wallet,
    this.points,
  });

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    isStaff = json['is_staff'];
    wallet = json['wallet'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['is_staff'] = isStaff;
    data['wallet'] = wallet;
    data['points'] = points;
    return data;
  }
}
