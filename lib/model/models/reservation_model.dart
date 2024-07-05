import 'package:xperience/model/models/user_model.dart';

class ReservationModel {
  int? id;
  // int? user;
  UserInfo? user;
  List<CarReservationData>? carReservations;
  List<HotelReservationData>? hotelReservations;
  CreatedBy? createdBy;
  String? status;
  String? createdAt;

  ReservationModel({
    this.id,
    this.user,
    this.carReservations,
    this.hotelReservations,
    this.createdBy,
    this.status,
    this.createdAt,
  });

  static ReservationModel fromJsonModel(Object? json) => ReservationModel.fromJson(json as Map<String, dynamic>);

  ReservationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // user = json['user'];
    user = json['user'] != null ? UserInfo.fromJson(json['user']) : null;
    if (json['car_reservations'] != null) {
      carReservations = <CarReservationData>[];
      json['car_reservations'].forEach((v) {
        carReservations!.add(CarReservationData.fromJson(v));
      });
    }
    if (json['hotel_reservations'] != null) {
      hotelReservations = <HotelReservationData>[];
      json['hotel_reservations'].forEach((v) {
        hotelReservations!.add(HotelReservationData.fromJson(v));
      });
    }
    createdBy = json['created_by'] != null ? CreatedBy.fromJson(json['created_by']) : null;
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    // data['user'] = user;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (carReservations != null) {
      data['car_reservations'] = carReservations!.map((v) => v.toJson()).toList();
    }
    if (hotelReservations != null) {
      data['hotel_reservations'] = hotelReservations!.map((v) => v.toJson()).toList();
    }
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}

class CarReservationData {
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
  List<String>? options;

  CarReservationData({
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

  CarReservationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // carService = json['car_service'];
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
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    // data['car_service'] = carService;
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
    data['options'] = options;
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

class HotelReservationData {
  int? id;
  HotelService? hotelService;
  String? checkInDate;
  String? checkOutDate;
  String? extras;
  String? finalPrice;
  List<HotelOptions>? options;

  HotelReservationData({this.id, this.hotelService, this.checkInDate, this.checkOutDate, this.extras, this.finalPrice, this.options});

  HotelReservationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hotelService = json['hotel_service'] != null ? HotelService.fromJson(json['hotel_service']) : null;
    checkInDate = json['check_in_date'];
    checkOutDate = json['check_out_date'];
    extras = json['extras'];
    finalPrice = json['final_price'];
    if (json['options'] != null) {
      options = <HotelOptions>[];
      json['options'].forEach((v) {
        options!.add(HotelOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (hotelService != null) {
      data['hotel_service'] = hotelService!.toJson();
    }
    data['check_in_date'] = checkInDate;
    data['check_out_date'] = checkOutDate;
    data['extras'] = extras;
    data['final_price'] = finalPrice;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HotelService {
  int? id;
  String? name;
  String? address;

  HotelService({this.id, this.name, this.address});

  HotelService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    return data;
  }
}

class HotelOptions {
  int? serviceOption;
  int? quantity;

  HotelOptions({this.serviceOption, this.quantity});

  HotelOptions.fromJson(Map<String, dynamic> json) {
    serviceOption = json['service_option'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_option'] = serviceOption;
    data['quantity'] = quantity;
    return data;
  }
}
