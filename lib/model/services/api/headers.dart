import 'package:xperience/model/services/shared_preference.dart';

class Headers {
  static Map<String, String> get guestHeader => {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Accept-Language": SharedPref.getString(SharedPrefKeys.languageCode) ?? "en",
        // "Authorization": "Bearer ========== Bearer Guest_Token ==========",
      };

  static Map<String, String> get userHeader => {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Accept-Language": SharedPref.getString(SharedPrefKeys.languageCode) ?? "en",
        "Authorization": "Bearer ${SharedPref.getString(SharedPrefKeys.tokenAccess) ?? "=== TOKEN_NOT_FOUND ==="}",
      };
}
