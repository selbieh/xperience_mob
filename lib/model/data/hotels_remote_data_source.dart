import 'package:xperience/model/models/car_service_model.dart';
import 'package:xperience/model/models/pagination_model.dart';
import 'package:xperience/model/services/api/app_failure.dart';
import 'package:xperience/model/services/api/either.dart';
import 'package:xperience/model/services/api/end_points.dart';
import 'package:xperience/model/services/api/headers.dart';
import 'package:xperience/model/services/api/http_service.dart';

class HotelsRemoteDataSource {
  static Future<Either<AppFailure, PaginationModel<CarServiceModel>>> getCarServices({
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
        final resData = PaginationModel<CarServiceModel>.fromJson(res.right, CarServiceModel.fromJsonModel);
        return Either(right: resData);
      } else {
        return Either(left: res.left);
      }
    } catch (error) {
      return Either(left: AppFailure(message: error.toString()));
    }
  }
}
