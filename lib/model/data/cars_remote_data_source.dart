import 'package:xperience/model/models/car_make_model.dart';
import 'package:xperience/model/models/car_service_model.dart';
import 'package:xperience/model/models/pagination_model.dart';
import 'package:xperience/model/models/subscription_option_model.dart';
import 'package:xperience/model/services/api/app_failure.dart';
import 'package:xperience/model/services/api/either.dart';
import 'package:xperience/model/services/api/end_points.dart';
import 'package:xperience/model/services/api/headers.dart';
import 'package:xperience/model/services/api/http_service.dart';

class CarsRemoteDataSource {
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
}
