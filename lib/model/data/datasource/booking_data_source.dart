import 'package:xperience/model/models/checkout_data_model.dart';
import 'package:xperience/model/models/reservation_booking_model.dart';
import 'package:xperience/model/services/api/app_failure.dart';
import 'package:xperience/model/services/api/either.dart';
import 'package:xperience/model/services/api/end_points.dart';
import 'package:xperience/model/services/api/headers.dart';
import 'package:xperience/model/services/api/http_service.dart';

class BookingDataSource {
  static Future<Either<AppFailure, ReservationBookingModel>> bookingServices({
    required Map<String, dynamic> body,
  }) async {
    try {
      final res = await HttpService.request(
        endPoint: EndPoints.reservations,
        requestType: RequestType.post,
        header: Headers.userHeader,
        body: body,
      );
      if (res.right != null) {
        final resData = ReservationBookingModel.fromJson(res.right);
        return Either(right: resData);
      } else {
        return Either(left: res.left);
      }
    } catch (error) {
      return Either(left: AppFailure(message: error.toString()));
    }
  }

  static Future<Either<AppFailure, String>> getPaymentURL({
    required Map<String, dynamic> body,
  }) async {
    try {
      final res = await HttpService.request(
        endPoint: EndPoints.payment,
        requestType: RequestType.post,
        header: Headers.userHeader,
        body: body,
      );
      if (res.right != null) {
        String? redirectURL = res.right["redirect_url"];
        if (redirectURL == null) {
          return Either(left: AppFailure(message: "Redirect url not found"));
        } else {
          return Either(right: redirectURL);
        }
      } else {
        return Either(left: res.left);
      }
    } catch (error) {
      return Either(left: AppFailure(message: error.toString()));
    }
  }

  static Future<Either<AppFailure, ReservationBookingModel>> refundService({
    required Map<String, dynamic> body,
  }) async {
    try {
      final res = await HttpService.request(
        endPoint: EndPoints.refund,
        requestType: RequestType.post,
        header: Headers.userHeader,
        body: body,
      );
      if (res.right != null) {
        final resData = ReservationBookingModel.fromJson(res.right);
        return Either(right: resData);
      } else {
        return Either(left: res.left);
      }
    } catch (error) {
      return Either(left: AppFailure(message: error.toString()));
    }
  }

  static Future<Either<AppFailure, CheckoutDataModel>> getCalculateReservationData({
    required Map<String, dynamic> body,
  }) async {
    try {
      final res = await HttpService.request(
        endPoint: EndPoints.calculateReservation,
        requestType: RequestType.post,
        header: Headers.userHeader,
        body: body,
      );
      if (res.right != null) {
        final resData = CheckoutDataModel.fromJson(res.right);
        return Either(right: resData);
      } else {
        return Either(left: res.left);
      }
    } catch (error) {
      return Either(left: AppFailure(message: error.toString()));
    }
  }
}
