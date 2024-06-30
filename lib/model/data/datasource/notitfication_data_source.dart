import 'package:xperience/model/models/notification_model.dart';
import 'package:xperience/model/models/pagination_model.dart';
import 'package:xperience/model/services/api/app_failure.dart';
import 'package:xperience/model/services/api/either.dart';
import 'package:xperience/model/services/api/end_points.dart';
import 'package:xperience/model/services/api/headers.dart';
import 'package:xperience/model/services/api/http_service.dart';

class NotificationDataSource {
  static Future<Either<AppFailure, PaginationModel<NotificationModel>>> getNotifications({
    Map<String, String>? queryParams,
  }) async {
    try {
      final res = await HttpService.request(
        endPoint: EndPoints.notifications,
        requestType: RequestType.get,
        header: Headers.userHeader,
        queryParams: queryParams,
      );
      if (res.right != null) {
        final resData = PaginationModel<NotificationModel>.fromJson(res.right, NotificationModel.fromJsonModel);
        return Either(right: resData);
      } else {
        return Either(left: res.left);
      }
    } catch (error) {
      return Either(left: AppFailure(message: error.toString()));
    }
  }
}
