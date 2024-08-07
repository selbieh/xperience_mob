import 'package:xperience/model/models/car_service_model.dart';

class HotelServiceModel {
  int? id;
  String? name;
  String? nameAr;
  String? nameEn;
  String? description;
  String? view;
  int? numberOfRooms;
  int? numberOfBeds;
  String? dayPrice;
  List<Features>? features;
  List<ImagesModel>? images;
  String? image;
  String? address;
  int? locationLat;
  int? locationLong;
  String? locationUrl;
  num? points;
  num? pointsPrice;
  String? dollarDayPrice;

  HotelServiceModel({
    this.id,
    this.name,
    this.nameAr,
    this.nameEn,
    this.description,
    this.view,
    this.numberOfRooms,
    this.numberOfBeds,
    this.dayPrice,
    this.features,
    this.images,
    this.image,
    this.address,
    this.locationLat,
    this.locationLong,
    this.locationUrl,
    this.points,
    this.pointsPrice,
    this.dollarDayPrice,
  });

  static HotelServiceModel fromJsonModel(Object? json) => HotelServiceModel.fromJson(json as Map<String, dynamic>);

  HotelServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    description = json['description'];
    view = json['view'];
    numberOfRooms = json['number_of_rooms'];
    numberOfBeds = json['number_of_beds'];
    dayPrice = json['day_price'];
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(Features.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <ImagesModel>[];
      json['images'].forEach((v) {
        images!.add(ImagesModel.fromJson(v));
      });
    }
    image = json['image'];
    address = json['address'];
    locationLat = json['location_lat'];
    locationLong = json['location_long'];
    locationUrl = json['location_url'];
    points = json['points'];
    pointsPrice = json['points_price'];
    dollarDayPrice = json['dollar_day_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    data['description'] = description;
    data['view'] = view;
    data['number_of_rooms'] = numberOfRooms;
    data['number_of_beds'] = numberOfBeds;
    data['day_price'] = dayPrice;
    if (features != null) {
      data['features'] = features!.map((v) => v.toJson()).toList();
    }
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['image'] = image;
    data['address'] = address;
    data['location_lat'] = locationLat;
    data['location_long'] = locationLong;
    data['location_url'] = locationUrl;
    data['points'] = points;
    data['points_price'] = pointsPrice;
    data['dollar_day_price'] = dollarDayPrice;
    return data;
  }
}

class Features {
  int? id;
  String? name;
  String? description;
  String? image;

  Features({this.id, this.name, this.description, this.image});

  Features.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    return data;
  }
}
