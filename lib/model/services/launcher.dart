import 'package:url_launcher/url_launcher.dart';
import 'package:xperience/model/config/logger.dart';

enum LaunchType { url, email, tel, sms }

class Launcher {
  ///====================================================== Launch URL, EMAIL, TEL, SMS
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
        case LaunchType.email:
          return launchUrl(
            Uri.parse("mailto:$target?subject=${subject ?? ""}&body=${body ?? ""}"),
            mode: mode,
          );
        case LaunchType.tel:
          return launchUrl(Uri.parse("tel:$target"), mode: mode);
        case LaunchType.sms:
          return launchUrl(Uri.parse("sms:$target"), mode: mode);
      }
    } catch (error) {
      Logger.printt(error, isError: true);
      return false;
    }
  }
}
