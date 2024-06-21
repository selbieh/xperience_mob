import 'package:xperience/model/models/hotel_service_model.dart';
import 'package:xperience/model/models/pagination_model.dart';
import 'package:xperience/model/models/reservation_booking_model.dart';
import 'package:xperience/model/services/api/app_failure.dart';
import 'package:xperience/model/services/api/either.dart';
import 'package:xperience/model/services/api/end_points.dart';
import 'package:xperience/model/services/api/headers.dart';
import 'package:xperience/model/services/api/http_service.dart';

class HotelsServicesDataSource {
  static Future<Either<AppFailure, HotelServiceModel>> getHotelServiceById({
    required int serviceId,
  }) async {
    try {
      final res = await HttpService.request(
        endPoint: "${EndPoints.hotelServices}$serviceId/",
        requestType: RequestType.get,
        header: Headers.guestHeader,
      );
      if (res.right != null) {
        final resData = HotelServiceModel.fromJson(res.right);
        return Either(right: resData);
      } else {
        return Either(left: res.left);
      }
    } catch (error) {
      return Either(left: AppFailure(message: error.toString()));
    }
  }

  static Future<Either<AppFailure, PaginationModel<HotelServiceModel>>> getHotelsServices({
    Map<String, String>? queryParams,
  }) async {
    try {
      final res = await HttpService.request(
        endPoint: EndPoints.hotelServices,
        requestType: RequestType.get,
        header: Headers.guestHeader,
        queryParams: queryParams,
      );
      if (res.right != null) {
        final resData = PaginationModel<HotelServiceModel>.fromJson(res.right, HotelServiceModel.fromJsonModel);
        return Either(right: resData);
      } else {
        return Either(left: res.left);
      }
    } catch (error) {
      return Either(left: AppFailure(message: error.toString()));
    }
  }

  static Future<Either<AppFailure, ReservationBookingModel>> bookingHotelService({
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
}
