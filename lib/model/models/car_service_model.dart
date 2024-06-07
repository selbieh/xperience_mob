class CarServiceModel {
  int? id;
  String? model;
  String? make;
  String? description;
  int? numberOfSeats;
  int? year;
  String? color;
  String? type;
  bool? cool;
  String? image;
  List<String>? subscriptionOptions;
  List<Images>? images;

  CarServiceModel({
    this.id,
    this.model,
    this.make,
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
    description = json['description'];
    numberOfSeats = json['number_of_seats'];
    year = json['year'];
    color = json['color'];
    type = json['type'];
    cool = json['cool'];
    image = json['image'];
    if (json['subscription_options'] != null) {
      subscriptionOptions = json['subscription_options'].cast<String>();
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['model'] = model;
    data['make'] = make;
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

class Images {
  int? id;
  String? image;
  int? carService;

  Images({this.id, this.image, this.carService});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    carService = json['car_service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['car_service'] = carService;
    return data;
  }
}
