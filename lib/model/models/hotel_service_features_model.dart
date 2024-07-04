class HotelServiceFeaturesModel {
  int? id;
  String? name;
  String? description;

  HotelServiceFeaturesModel({
    this.id,
    this.name,
    this.description,
  });

  static HotelServiceFeaturesModel fromJsonModel(Object? json) => HotelServiceFeaturesModel.fromJson(json as Map<String, dynamic>);

  HotelServiceFeaturesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}
