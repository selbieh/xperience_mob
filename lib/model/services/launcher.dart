import 'package:url_launcher/url_launcher.dart';
import 'package:xperience/model/config/logger.dart';

enum LaunchType { url }

class Launcher {
  static Future<bool> launcherFun(
    String target,
    LaunchType launchType, {
    String? subject,
    String? body,
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    // String target = "http://google.com/";
    try {
      switch (launchType) {
        case LaunchType.url:
          if (await canLaunchUrl(Uri.parse(target))) {
            return launchUrl(Uri.parse(target), mode: mode);
          } else {
            throw "Could not launch url";
          }
      }
    } catch (error) {
      Logger.printt(error, isError: true);
      return false;
    }
  }
}
