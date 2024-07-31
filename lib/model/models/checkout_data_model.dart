class CheckoutDataModel {
  List<CarReservations>? carReservations;
  List<HotelReservations>? hotelReservations;
  String? status;
  String? paymentMethod;
  String? promocode;
  num? discount;
  num? finalReservationPrice;
  num? totalPointsPrice;

  CheckoutDataModel({
    this.carReservations,
    this.hotelReservations,
    this.status,
    this.paymentMethod,
    this.promocode,
    this.discount,
    this.finalReservationPrice,
    this.totalPointsPrice,
  });

  CheckoutDataModel.fromJson(Map<String, dynamic> json) {
    if (json['car_reservations'] != null) {
      carReservations = <CarReservations>[];
      json['car_reservations'].forEach((v) {
        carReservations!.add(CarReservations.fromJson(v));
      });
    }
    if (json['hotel_reservations'] != null) {
      hotelReservations = <HotelReservations>[];
      json['hotel_reservations'].forEach((v) {
        hotelReservations!.add(HotelReservations.fromJson(v));
      });
    }
    status = json['status'];
    paymentMethod = json['payment_method'];
    promocode = json['promocode'];
    discount = json['discount'];
    finalReservationPrice = json['final_reservation_price'];
    totalPointsPrice = json['total_points_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (carReservations != null) {
      data['car_reservations'] = carReservations!.map((v) => v.toJson()).toList();
    }
    if (hotelReservations != null) {
      data['hotel_reservations'] = hotelReservations!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['payment_method'] = paymentMethod;
    data['promocode'] = promocode;
    data['discount'] = discount;
    data['final_reservation_price'] = finalReservationPrice;
    data['total_points_price'] = totalPointsPrice;
    return data;
  }
}

class CarReservations {
  String? carService;
  String? pickupTime;
  String? pickupAddress;
  String? dropoffAddress;
  String? terminal;
  String? flightNumber;
  String? extras;
  num? finalPrice;
  int? subscriptionOption;
  List<Options>? options;
  num? subscriptionOptionPrice;

  CarReservations({
    this.carService,
    this.pickupTime,
    this.pickupAddress,
    this.dropoffAddress,
    this.terminal,
    this.flightNumber,
    this.extras,
    this.finalPrice,
    this.subscriptionOption,
    this.options,
    this.subscriptionOptionPrice,
  });

  CarReservations.fromJson(Map<String, dynamic> json) {
    carService = json['car_service'];
    pickupTime = json['pickup_time'];
    pickupAddress = json['pickup_address'];
    dropoffAddress = json['dropoff_address'];
    terminal = json['terminal'];
    flightNumber = json['flight_number'];
    extras = json['extras'];
    finalPrice = json['final_price'];
    subscriptionOption = json['subscription_option'];
    subscriptionOptionPrice = json['subscription_option_price'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['car_service'] = carService;
    data['pickup_time'] = pickupTime;
    data['pickup_address'] = pickupAddress;
    data['dropoff_address'] = dropoffAddress;
    data['terminal'] = terminal;
    data['flight_number'] = flightNumber;
    data['extras'] = extras;
    data['final_price'] = finalPrice;
    data['subscription_option'] = subscriptionOption;
    data['subscription_option_price'] = subscriptionOptionPrice;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HotelReservations {
  int? hotelService;
  num? hotelServicePrice;
  String? checkInDate;
  String? checkOutDate;
  String? extras;
  num? finalPrice;
  List<Options>? options;

  HotelReservations({this.hotelService, this.hotelServicePrice, this.checkInDate, this.checkOutDate, this.extras, this.finalPrice, this.options});

  HotelReservations.fromJson(Map<String, dynamic> json) {
    hotelService = json['hotel_service'];
    hotelServicePrice = json['hotel_service_price'];
    checkInDate = json['check_in_date'];
    checkOutDate = json['check_out_date'];
    extras = json['extras'];
    finalPrice = json['final_price'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hotel_service'] = hotelService;
    data['hotel_service_price'] = hotelServicePrice;
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

class Options {
  int? serviceOption;
  int? quantity;
  num? price;
  int? maxFree;
  num? pointsPrice;
  String? serviceOptionName;

  Options({
    this.serviceOption,
    this.quantity,
    this.price,
    this.maxFree,
    this.pointsPrice,
    this.serviceOptionName,
  });

  Options.fromJson(Map<String, dynamic> json) {
    serviceOption = json['service_option'];
    quantity = json['quantity'];
    price = json['price'];
    maxFree = json['max_free'];
    pointsPrice = json['points_price'];
    serviceOptionName = json['service_option_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_option'] = serviceOption;
    data['quantity'] = quantity;
    data['price'] = price;
    data['max_free'] = maxFree;
    data['points_price'] = pointsPrice;
    data['service_option_name'] = serviceOptionName;
    return data;
  }
}
