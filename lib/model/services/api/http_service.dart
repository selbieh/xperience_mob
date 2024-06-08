import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xperience/model/config/app_environment.dart';
import 'package:xperience/model/config/logger.dart';
import 'package:xperience/model/services/api/app_failure.dart';
import 'package:xperience/model/services/api/either.dart';
import 'package:xperience/model/services/localization/app_language.dart';

enum RequestType {
  post,
  get,
  put,
  patch,
  delete,
}

class HttpService {
  ///================================================================================================
  ///========================================================================== Main Request Function
  ///================================================================================================
  static Future<Either<AppFailure, dynamic>> request({
    required RequestType requestType,
    required Map<String, String> header,
    String endPoint = "",
    String? serverURL,
    Map<String, dynamic>? body,
    Map<String, String>? queryParams,
    bool isFirstTime = true,
  }) async {
    try {
      http.Response? response;
      Duration timeoutDuration = const Duration(seconds: 30);
      final Stopwatch stopwatch = Stopwatch();
      stopwatch.start();
      Uri uri = Uri.parse((serverURL ?? AppEnvironment.instance.serverURL) + endPoint);
      uri = uri.replace(queryParameters: queryParams);

      Logger.printt("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
      Logger.printt("URI: $uri");
      Logger.printt("EndPoint: $endPoint");
      Logger.printt("Request Type: ${requestType.name.toUpperCase()}");
      Logger.printt("Header: $header");
      Logger.printt("Body: $body");
      Logger.printt("QueryParams: $queryParams");
      Logger.printt("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");

      switch (requestType) {
        case RequestType.post:
          {
            response = await http
                .post(
                  uri,
                  headers: header,
                  encoding: Encoding.getByName("utf-8"),
                  body: json.encode(body),
                )
                .timeout(timeoutDuration);
          }
          break;
        case RequestType.put:
          {
            response = await http
                .put(
                  uri,
                  headers: header,
                  encoding: Encoding.getByName("utf-8"),
                  body: json.encode(body),
                )
                .timeout(timeoutDuration);
          }
          break;
        case RequestType.patch:
          {
            response = await http
                .patch(
                  uri,
                  headers: header,
                  encoding: Encoding.getByName("utf-8"),
                  body: json.encode(body),
                )
                .timeout(timeoutDuration);
          }
          break;
        case RequestType.get:
          {
            response = await http
                .get(
                  uri,
                  headers: header,
                )
                .timeout(timeoutDuration);
          }
          break;
        case RequestType.delete:
          {
            response = await http
                .delete(
                  uri,
                  headers: header,
                )
                .timeout(timeoutDuration);
          }
          break;
      }
      stopwatch.stop();
      Logger.printt("⏱️ Execution Time: ${stopwatch.elapsedMilliseconds} ms ⏱️");
      // To fix arabic litters from displayed like this "ÙØ±Ù"
      // dynamic responseJson = json.decode(utf8.decode(response.bodyBytes));
      dynamic responseJson = json.decode(response.body);
      Either<AppFailure, dynamic> responseResult = Either();
      switch (response.statusCode) {
        case 200:
        case 201:
          Logger.printt("✅ Request Success ( ${response.statusCode} ) ✅");
          Logger.printObject(responseJson, title: "HTTP request 🛎️🛎️");
          responseResult = Either(right: responseJson);
          break;
        default:
          Logger.printt("❌❌ Request Failed (${response.statusCode}) ❌❌");
          Logger.printObject(responseJson, title: "HTTP request 🛎️🛎️");

          String message = "";
          if (responseJson["detail"] is String) {
            message = responseJson["detail"];
          } else if (responseJson["errors"] is List) {
            for (var errorItem in responseJson["errors"]) {
              message = "$message \n${errorItem["detail"]}";
            }
          } else {
            message = "Something went wrong.".tr();
          }

          // String message = responseJson["message"] ?? "Something went wrong.";
          responseResult = Either(left: ApiFailure(message: message, statusCode: response.statusCode));
      }
      return responseResult;
    } on TimeoutException catch (error) {
      Logger.printt("<<Timeout Exception>> ⌛⌛ ${error.toString()} ⌛⌛", isError: true);
      return Either(left: TimeoutFailure(message: AppFailure.getMessage(AppFailureType.timeout)));
    } on SocketException catch (error) {
      Logger.printt("<<Socket Exception>> 🧨🧨 ${error.toString()} 🧨🧨", isError: true);
      return Either(left: SocketFailure(message: AppFailure.getMessage(AppFailureType.socket)));
    } on HttpException catch (error) {
      Logger.printt("<<Http Exception>> 💥💥 ${error.toString()} 💥💥", isError: true);
      return Either(left: HttpFailure(message: AppFailure.getMessage(AppFailureType.http)));
    } on FormatException catch (error) {
      Logger.printt("<<Format Exception>> 📄❗️ ${error.toString()} ❗️📄", isError: true);
      return Either(left: FormatFailure(message: AppFailure.getMessage(AppFailureType.format)));
    } on Error catch (error) {
      Logger.printt("<<Error Exception>> 💣💣 ${error.toString()} 💣💣", isError: true);
      return Either(left: ErrorFailure(message: AppFailure.getMessage(AppFailureType.error)));
    } catch (error) {
      Logger.printt("<<Exception>> 🚨🚨 ${error.toString()} 🚨🚨", isError: true);
      return Either(left: OtherFailure(message: AppFailure.getMessage(AppFailureType.other)));
    }
  }
}
