import 'dart:async';
import 'package:xperience/model/services/api/app_failure.dart';
import 'package:xperience/model/services/api/either.dart';
import 'package:xperience/model/services/api/end_points.dart';
import 'package:xperience/model/services/api/headers.dart';
import 'package:xperience/model/services/api/http_service.dart';

class HttpApi {
  Future<Either<AppFailure, dynamic>> getUsers() async {
    final res = await HttpService.request(
      endPoint: EndPoints.loginRegister,
      requestType: RequestType.get,
      header: Headers.userHeader,
    );
    if (res.right != null) {
      return Either(right: res.right);
    } else {
      return Either(left: res.left);
    }
  }
}
