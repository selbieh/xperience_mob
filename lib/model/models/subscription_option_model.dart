class SubscriptionOptionModel {
  int? id;
  int? durationHours;
  String? price;
  CarService? carService;
  String? type;

  SubscriptionOptionModel({
    this.id,
    this.durationHours,
    this.price,
    this.carService,
    this.type,
  });

  static SubscriptionOptionModel fromJsonModel(Object? json) => SubscriptionOptionModel.fromJson(json as Map<String, dynamic>);
  SubscriptionOptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    durationHours = json['duration_hours'];
    price = json['price'];
    carService = json['car_service'] != null ? CarService.fromJson(json['car_service']) : null;
    type = json['type'];
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

  CarService({this.id, this.model, this.make, this.numberOfSeats, this.year, this.type});

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
