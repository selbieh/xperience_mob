import 'package:xperience/model/models/pagination_model.dart';
import 'package:xperience/model/models/reservation_model.dart';
import 'package:xperience/model/services/api/app_failure.dart';
import 'package:xperience/model/services/api/either.dart';
import 'package:xperience/model/services/api/end_points.dart';
import 'package:xperience/model/services/api/headers.dart';
import 'package:xperience/model/services/api/http_service.dart';

class ReservationDataSource {
  static Future<Either<AppFailure, PaginationModel<ReservationModel>>> getReservation({
    Map<String, String>? queryParams,
  }) async {
    try {
      final res = await HttpService.request(
        endPoint: EndPoints.reservations,
        requestType: RequestType.get,
        header: Headers.userHeader,
        queryParams: queryParams,
      );
      if (res.right != null) {
        final resData = PaginationModel<ReservationModel>.fromJson(res.right, ReservationModel.fromJsonModel);
        return Either(right: resData);
      } else {
        return Either(left: res.left);
      }
    } catch (error) {
      return Either(left: AppFailure(message: error.toString()));
    }
  }

  static Future<Either<AppFailure, ReservationModel>> getReservationById({
    required int reservationId,
  }) async {
    try {
      final res = await HttpService.request(
        endPoint: "${EndPoints.reservations}$reservationId/",
        requestType: RequestType.get,
        header: Headers.userHeader,
      );
      if (res.right != null) {
        final resData = ReservationModel.fromJson(res.right);
        return Either(right: resData);
      } else {
        return Either(left: res.left);
      }
    } catch (error) {
      return Either(left: AppFailure(message: error.toString()));
    }
  }
}
