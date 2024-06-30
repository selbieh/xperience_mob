import 'package:xperience/model/models/car_service_model.dart';

class HotelServiceModel {
  int? id;
  String? name;
  String? description;
  String? view;
  int? numberOfRooms;
  int? numberOfBeds;
  String? dayPrice;
  String? image;
  List<ImagesModel>? images;

  HotelServiceModel({
    this.id,
    this.name,
    this.description,
    this.view,
    this.numberOfRooms,
    this.numberOfBeds,
    this.dayPrice,
    this.image,
    this.images,
  });

  static HotelServiceModel fromJsonModel(Object? json) => HotelServiceModel.fromJson(json as Map<String, dynamic>);

  HotelServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    view = json['view'];
    numberOfRooms = json['number_of_rooms'];
    numberOfBeds = json['number_of_beds'];
    dayPrice = json['day_price'];
    image = json['image'];
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
    data['name'] = name;
    data['description'] = description;
    data['view'] = view;
    data['number_of_rooms'] = numberOfRooms;
    data['number_of_beds'] = numberOfBeds;
    data['day_price'] = dayPrice;
    data['image'] = image;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
