import 'package:xperience/model/services/shared_preference.dart';

class Headers {
  static Map<String, String> get guestHeader => {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer ========== Bearer Guest_Token ==========",
      };

  static Map<String, String> get userHeader => {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SharedPref.getString(SharedPrefKeys.tokenAccess) ?? "=== USER_ACCESS_TOKEN ==="}",
      };
}
