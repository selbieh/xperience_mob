import 'package:xperience/model/models/checkout_data_model.dart';

class ReservationBookingModel {
  int? id;
  int? user;
  List<CarReservations>? carReservations;
  CreatedBy? createdBy;
  String? status;
  String? createdAt;

  ReservationBookingModel({
    this.id,
    this.user,
    this.carReservations,
    this.createdBy,
    this.status,
    this.createdAt,
  });

  ReservationBookingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    if (json['car_reservations'] != null) {
      carReservations = <CarReservations>[];
      json['car_reservations'].forEach((v) {
        carReservations!.add(CarReservations.fromJson(v));
      });
    }
    createdBy = json['created_by'] != null ? CreatedBy.fromJson(json['created_by']) : null;
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    if (carReservations != null) {
      data['car_reservations'] = carReservations!.map((v) => v.toJson()).toList();
    }
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}

class CarReservations {
  int? id;
  CarService? carService;
  String? pickupTime;
  String? pickupAddress;
  double? pickupLat;
  double? pickupLong;
  String? pickupUrl;
  String? dropoffAddress;
  double? dropoffLat;
  double? dropoffLong;
  String? dropoffUrl;
  String? terminal;
  String? flightNumber;
  String? extras;
  String? finalPrice;
  int? subscriptionOption;
  List<Options>? options;

  CarReservations({
    this.id,
    this.carService,
    this.pickupTime,
    this.pickupAddress,
    this.pickupLat,
    this.pickupLong,
    this.pickupUrl,
    this.dropoffAddress,
    this.dropoffLat,
    this.dropoffLong,
    this.dropoffUrl,
    this.terminal,
    this.flightNumber,
    this.extras,
    this.finalPrice,
    this.subscriptionOption,
    this.options,
  });

  CarReservations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carService = json['car_service'] != null ? CarService.fromJson(json['car_service']) : null;
    pickupTime = json['pickup_time'];
    pickupAddress = json['pickup_address'];
    pickupLat = json['pickup_lat'];
    pickupLong = json['pickup_long'];
    pickupUrl = json['pickup_url'];
    dropoffAddress = json['dropoff_address'];
    dropoffLat = json['dropoff_lat'];
    dropoffLong = json['dropoff_long'];
    dropoffUrl = json['dropoff_url'];
    terminal = json['terminal'];
    flightNumber = json['flight_number'];
    extras = json['extras'];
    finalPrice = json['final_price'];
    subscriptionOption = json['subscription_option'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (carService != null) {
      data['car_service'] = carService!.toJson();
    }
    data['pickup_time'] = pickupTime;
    data['pickup_address'] = pickupAddress;
    data['pickup_lat'] = pickupLat;
    data['pickup_long'] = pickupLong;
    data['pickup_url'] = pickupUrl;
    data['dropoff_address'] = dropoffAddress;
    data['dropoff_lat'] = dropoffLat;
    data['dropoff_long'] = dropoffLong;
    data['dropoff_url'] = dropoffUrl;
    data['terminal'] = terminal;
    data['flight_number'] = flightNumber;
    data['extras'] = extras;
    data['final_price'] = finalPrice;
    data['subscription_option'] = subscriptionOption;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
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

class CreatedBy {
  int? id;
  String? name;
  String? email;
  String? mobile;
  int? wallet;
  bool? isStaff;

  CreatedBy({this.id, this.name, this.email, this.mobile, this.wallet, this.isStaff});

  CreatedBy.fromJson(Map<String, dynamic> json) {
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
