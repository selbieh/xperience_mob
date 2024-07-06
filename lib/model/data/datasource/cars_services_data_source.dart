import 'package:xperience/model/models/car_make_model.dart';
import 'package:xperience/model/models/car_service_model.dart';
import 'package:xperience/model/models/pagination_model.dart';
import 'package:xperience/model/models/reservation_booking_model.dart';
import 'package:xperience/model/models/service_options_model.dart';
import 'package:xperience/model/models/subscription_option_model.dart';
import 'package:xperience/model/services/api/app_failure.dart';
import 'package:xperience/model/services/api/either.dart';
import 'package:xperience/model/services/api/end_points.dart';
import 'package:xperience/model/services/api/headers.dart';
import 'package:xperience/model/services/api/http_service.dart';

class CarsServicesDataSource {
  static Future<Either<AppFailure, CarServiceModel>> getCarServiceById({
    required int serviceId,
  }) async {
    try {
      final res = await HttpService.request(
        endPoint: "${EndPoints.carServices}$serviceId/",
        requestType: RequestType.get,
        header: Headers.guestHeader,
      );
      if (res.right != null) {
        final resData = CarServiceModel.fromJson(res.right);
        return Either(right: resData);
      } else {
        return Either(left: res.left);
      }
    } catch (error) {
      return Either(left: AppFailure(message: error.toString()));
    }
  }

  static Future<Either<AppFailure, PaginationModel<CarServiceModel>>> getCarsServices({
    Map<String, String>? queryParams,
  }) async {
    try {
      final res = await HttpService.request(
        endPoint: EndPoints.carServices,
        requestType: RequestType.get,
        header: Headers.guestHeader,
        queryParams: queryParams,
      );
      if (res.right != null) {
        final resData = PaginationModel<CarServiceModel>.fromJson(
          res.right,
          CarServiceModel.fromJsonModel,
        );
        return Either(right: resData);
      } else {
        return Either(left: res.left);
      }
    } catch (error) {
      return Either(left: AppFailure(message: error.toString()));
    }
  }

  static Future<Either<AppFailure, PaginationModel<CarMakeModel>>> getCarMakes({
    Map<String, String>? queryParams,
  }) async {
    try {
      final res = await HttpService.request(
        endPoint: EndPoints.carMakes,
        requestType: RequestType.get,
        header: Headers.guestHeader,
        queryParams: queryParams,
      );
      if (res.right != null) {
        final resData = PaginationModel<CarMakeModel>.fromJson(
          res.right,
          CarMakeModel.fromJsonModel,
        );
        return Either(right: resData);
      } else {
        return Either(left: res.left);
      }
    } catch (error) {
      return Either(left: AppFailure(message: error.toString()));
    }
  }

  static Future<Either<AppFailure, PaginationModel<CarMakeModel>>> getCarModels({
    Map<String, String>? queryParams,
  }) async {
    try {
      final res = await HttpService.request(
        endPoint: EndPoints.carModels,
        requestType: RequestType.get,
        header: Headers.guestHeader,
        queryParams: queryParams,
      );
      if (res.right != null) {
        final resData = PaginationModel<CarMakeModel>.fromJson(
          res.right,
          CarMakeModel.fromJsonModel,
        );
        return Either(right: resData);
      } else {
        return Either(left: res.left);
      }
    } catch (error) {
      return Either(left: AppFailure(message: error.toString()));
    }
  }

  static Future<Either<AppFailure, PaginationModel<SubscriptionOptionModel>>> getSubscriptionOptions({
    Map<String, String>? queryParams,
  }) async {
    try {
      final res = await HttpService.request(
        endPoint: EndPoints.subscriptionOptions,
        requestType: RequestType.get,
        header: Headers.guestHeader,
        queryParams: queryParams,
      );
      if (res.right != null) {
        final resData = PaginationModel<SubscriptionOptionModel>.fromJson(
          res.right,
          SubscriptionOptionModel.fromJsonModel,
        );
        return Either(right: resData);
      } else {
        return Either(left: res.left);
      }
    } catch (error) {
      return Either(left: AppFailure(message: error.toString()));
    }
  }

  static Future<Either<AppFailure, PaginationModel<ServiceOptionsModel>>> getServiceOptions({
    Map<String, String>? queryParams,
  }) async {
    try {
      final res = await HttpService.request(
        endPoint: EndPoints.serviceOptions,
        requestType: RequestType.get,
        header: Headers.guestHeader,
        queryParams: queryParams,
      );
      if (res.right != null) {
        final resData = PaginationModel<ServiceOptionsModel>.fromJson(
          res.right,
          ServiceOptionsModel.fromJsonModel,
        );
        return Either(right: resData);
      } else {
        return Either(left: res.left);
      }
    } catch (error) {
      return Either(left: AppFailure(message: error.toString()));
    }
  }

  static Future<Either<AppFailure, ReservationBookingModel>> bookingCarService({
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
}
