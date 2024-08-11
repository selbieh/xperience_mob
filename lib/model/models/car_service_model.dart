class CarServiceModel {
  int? id;
  int? model;
  int? make;
  String? modelName;
  String? makeName;
  String? description;
  int? numberOfSeats;
  int? year;
  String? color;
  String? type;
  bool? cool;
  String? image;
  List<SubscriptionOptions>? subscriptionOptions;
  List<ImagesModel>? images;

  CarServiceModel({
    this.id,
    this.model,
    this.make,
    this.modelName,
    this.makeName,
    this.description,
    this.numberOfSeats,
    this.year,
    this.color,
    this.type,
    this.cool,
    this.image,
    this.subscriptionOptions,
    this.images,
  });

  static CarServiceModel fromJsonModel(Object? json) => CarServiceModel.fromJson(json as Map<String, dynamic>);

  CarServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    model = json['model'];
    make = json['make'];
    modelName = json['model_name'];
    makeName = json['make_name'];
    description = json['description'];
    numberOfSeats = json['number_of_seats'];
    year = json['year'];
    color = json['color'];
    type = json['type'];
    cool = json['cool'];
    image = json['image'];
    if (json['subscription_options'] != null) {
      subscriptionOptions = <SubscriptionOptions>[];
      json['subscription_options'].forEach((v) {
        subscriptionOptions!.add(SubscriptionOptions.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <ImagesModel>[];
      json['images'].forEach((v) {
        images!.add(ImagesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['model'] = model;
    data['make'] = make;
    data['model_name'] = modelName;
    data['make_name'] = makeName;
    data['description'] = description;
    data['number_of_seats'] = numberOfSeats;
    data['year'] = year;
    data['color'] = color;
    data['type'] = type;
    data['cool'] = cool;
    data['image'] = image;
    data['subscription_options'] = subscriptionOptions;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubscriptionOptions {
  int? id;
  int? durationHours;
  String? price;
  CarService? carService;
  String? type;
  int? points;

  SubscriptionOptions({this.id, this.durationHours, this.price, this.carService, this.type, this.points});

  SubscriptionOptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    durationHours = json['duration_hours'];
    price = json['price'];
    carService = json['car_service'] != null ? CarService.fromJson(json['car_service']) : null;
    type = json['type'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['duration_hours'] = durationHours;
    data['price'] = price;
    if (carService != null) {
      data['car_service'] = carService!.toJson();
    }
    data['type'] = type;
    data['points'] = points;
    return data;
  }
}

class CarService {
  int? id;
  String? model;
  String? make;
  int? numberOfSeats;
  int? year;
  String? type;

  CarService({
    this.id,
    this.model,
    this.make,
    this.numberOfSeats,
    this.year,
    this.type,
  });

  CarService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    model = json['model'];
    make = json['make'];
    numberOfSeats = json['number_of_seats'];
    year = json['year'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['model'] = model;
    data['make'] = make;
    data['number_of_seats'] = numberOfSeats;
    data['year'] = year;
    data['type'] = type;
    return data;
  }
}

class ImagesModel {
  int? id;
  String? image;
  int? carService;
  bool? is3d;
  int? level;

  ImagesModel({this.id, this.image, this.carService});

  ImagesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    carService = json['car_service'];
    is3d = json['is_3d'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['car_service'] = carService;
    data['is_3d'] = is3d;
    data['level'] = level;
    return data;
  }
}
