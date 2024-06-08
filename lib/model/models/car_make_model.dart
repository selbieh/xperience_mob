class CarMakeModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  bool? active;
  String? name;

  CarMakeModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.active,
    this.name,
  });

  static CarMakeModel fromJsonModel(Object? json) => CarMakeModel.fromJson(json as Map<String, dynamic>);

  CarMakeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    active = json['active'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['active'] = active;
    data['name'] = name;
    return data;
  }
}
