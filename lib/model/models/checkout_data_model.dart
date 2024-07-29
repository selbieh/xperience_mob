class CheckoutDataModel {
  int? user;
  List<CarReservations>? carReservations;
  List<String>? hotelReservations;
  String? status;
  String? paymentMethod;
  String? promocode;
  num? discount;
  num? finalReservationPrice;
  num? totalPointsPrice;

  CheckoutDataModel({
    this.user,
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
    user = json['user'];
    if (json['car_reservations'] != null) {
      carReservations = <CarReservations>[];
      json['car_reservations'].forEach((v) {
        carReservations!.add(CarReservations.fromJson(v));
      });
    }
    hotelReservations = json['hotel_reservations'].cast<String>();
    status = json['status'];
    paymentMethod = json['payment_method'];
    promocode = json['promocode'];
    discount = json['discount'];
    finalReservationPrice = json['final_reservation_price'];
    totalPointsPrice = json['total_points_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    if (carReservations != null) {
      data['car_reservations'] = carReservations!.map((v) => v.toJson()).toList();
    }
    data['hotel_reservations'] = hotelReservations;
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

  CarReservations(
      {this.carService,
      this.pickupTime,
      this.pickupAddress,
      this.dropoffAddress,
      this.terminal,
      this.flightNumber,
      this.extras,
      this.finalPrice,
      this.subscriptionOption,
      this.options});

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
  String? pointsPrice;

  Options({this.serviceOption, this.quantity, this.price, this.maxFree, this.pointsPrice});

  Options.fromJson(Map<String, dynamic> json) {
    serviceOption = json['service_option'];
    quantity = json['quantity'];
    price = json['price'];
    maxFree = json['max_free'];
    pointsPrice = json['points_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_option'] = serviceOption;
    data['quantity'] = quantity;
    data['price'] = price;
    data['max_free'] = maxFree;
    data['points_price'] = pointsPrice;
    return data;
  }
}
