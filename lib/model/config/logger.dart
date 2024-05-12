import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:xperience/model/config/app_environment.dart';

class Logger {
  static void _defaultPrint(Object? object) {
    if (kDebugMode) {
      print(object);
    }
  }

  static void log(String text) {
    if (AppEnvironment.instance.environment == EnvironmentType.development) {
      developer.log(text);
    }
  }

  static void printt(Object? object, {bool isError = false}) {
    if (AppEnvironment.instance.environment == EnvironmentType.development) {
      // getLoggerLocation();
      if (isError) {
        _defaultPrint("====================================== ❗Error❗");
        _defaultPrint(object);
        _defaultPrint("====================================== ❗Error❗");
      } else {
        _defaultPrint(object);
      }
    }
  }

  static void printObject(Object? object, {String title = ""}) {
    try {
      if (AppEnvironment.instance.environment == EnvironmentType.development) {
        String dividerTop = "╔════════════════════════════════════════════════════════════════════════════════════════════════";
        String dividerBottom = "╚════════════════════════════════════════════════════════════════════════════════════════════════";

        if (Platform.isAndroid) {
          Logger._defaultPrint("\x1B[35m$dividerTop ( $title ) \x1B[0m");
          if (object != null) {
            // ## Spaces is for space between opject items
            const JsonEncoder.withIndent("     ").convert(object).split("\n").forEach(
              (element) {
                Logger._defaultPrint("\x1B[35m║ $element\x1B[0m");
              },
            );
          }
          Logger._defaultPrint("\x1B[35m$dividerBottom \x1B[0m");
        } else {
          Logger._defaultPrint("$dividerTop ( $title )");
          if (object != null) {
            const JsonEncoder.withIndent("     ").convert(object).split("\n").forEach(
              (element) {
                Logger._defaultPrint("║ $element");
              },
            );
          }
          Logger._defaultPrint(dividerBottom);
        }
      }
    } catch (error) {
      Logger._defaultPrint(error);
    }
  }
}
