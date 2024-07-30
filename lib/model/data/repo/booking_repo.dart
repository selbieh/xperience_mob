import 'package:flutter/material.dart';
import 'package:xperience/model/data/datasource/booking_data_source.dart';
import 'package:xperience/model/models/checkout_data_model.dart';
import 'package:xperience/model/models/reservation_booking_model.dart';
import 'package:xperience/model/services/api/app_failure.dart';
import 'package:xperience/model/services/api/either.dart';

class BookingRepo extends ChangeNotifier {
  Future<Either<AppFailure, ReservationBookingModel>> bookingServices({
    required Map<String, dynamic> body,
  }) async {
    try {
      var res = await BookingDataSource.bookingServices(body: body);
      if (res.left != null) {
        return Either(left: res.left);
      } else {
        return Either(right: res.right);
      }
    } catch (e) {
      return Either(left: AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, String>> getPaymentURL({
    required Map<String, dynamic> body,
  }) async {
    try {
      var res = await BookingDataSource.getPaymentURL(body: body);
      if (res.left != null) {
        return Either(left: res.left);
      } else {
        return Either(right: res.right);
      }
    } catch (e) {
      return Either(left: AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, ReservationBookingModel>> refundCarService({
    required Map<String, dynamic> body,
  }) async {
    try {
      var res = await BookingDataSource.refundCarService(body: body);
      if (res.left != null) {
        return Either(left: res.left);
      } else {
        return Either(right: res.right);
      }
    } catch (e) {
      return Either(left: AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, CheckoutDataModel>> getCalculateReservationData({
    required Map<String, dynamic> body,
  }) async {
    try {
      var res = await BookingDataSource.getCalculateReservationData(body: body);
      if (res.left != null) {
        return Either(left: res.left);
      } else {
        return Either(right: res.right);
      }
    } catch (e) {
      return Either(left: AppFailure(message: e.toString()));
    }
  }
}
