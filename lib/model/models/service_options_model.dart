class ServiceOptionsModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? serviceType;
  String? type;
  String? name;
  int? maxFree;
  String? price;
  String? dollarPrice;
  bool? active;
  int? count;
  bool? isSelected;

  ServiceOptionsModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.serviceType,
    this.type,
    this.name,
    this.maxFree,
    this.price,
    this.dollarPrice,
    this.active,
    this.count,
    this.isSelected,
  });

  static ServiceOptionsModel fromJsonModel(Object? json) => ServiceOptionsModel.fromJson(json as Map<String, dynamic>);

  ServiceOptionsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    serviceType = json['service_type'];
    type = json['type'];
    name = json['name'];
    maxFree = json['max_free'];
    price = json['price'];
    dollarPrice = json['dollar_price'];
    active = json['active'];
    count = 0;
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['service_type'] = serviceType;
    data['type'] = type;
    data['name'] = name;
    data['max_free'] = maxFree;
    data['price'] = price;
    data['dollar_price'] = dollarPrice;
    data['active'] = active;
    return data;
  }
}
