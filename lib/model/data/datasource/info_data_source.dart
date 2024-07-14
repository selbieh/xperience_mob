import 'package:xperience/model/models/faq_model.dart';
import 'package:xperience/model/models/pagination_model.dart';
import 'package:xperience/model/models/policy_model.dart';
import 'package:xperience/model/services/api/app_failure.dart';
import 'package:xperience/model/services/api/either.dart';
import 'package:xperience/model/services/api/end_points.dart';
import 'package:xperience/model/services/api/headers.dart';
import 'package:xperience/model/services/api/http_service.dart';

class InfoDataSource {
  static Future<Either<AppFailure, PaginationModel<FaqModel>>> getFaqs({
    Map<String, String>? queryParams,
  }) async {
    try {
      final res = await HttpService.request(
        endPoint: EndPoints.faqs,
        requestType: RequestType.get,
        // header: Headers.userHeader,
        header: Headers.guestHeader,
        queryParams: queryParams,
      );
      if (res.right != null) {
        final resData = PaginationModel<FaqModel>.fromJson(res.right, FaqModel.fromJsonModel);
        return Either(right: resData);
      } else {
        return Either(left: res.left);
      }
    } catch (error) {
      return Either(left: AppFailure(message: error.toString()));
    }
  }

  static Future<Either<AppFailure, PolicyModel>> getPrivacy({
    Map<String, String>? queryParams,
  }) async {
    try {
      final res = await HttpService.request(
        endPoint: EndPoints.policy,
        requestType: RequestType.get,
        // header: Headers.userHeader,
        header: Headers.guestHeader,
        queryParams: queryParams,
      );
      if (res.right != null) {
        final resData = PolicyModel.fromJson(res.right[0]);
        return Either(right: resData);
      } else {
        return Either(left: res.left);
      }
    } catch (error) {
      return Either(left: AppFailure(message: error.toString()));
    }
  }
}
