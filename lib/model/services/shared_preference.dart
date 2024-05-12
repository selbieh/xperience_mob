import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xperience/model/config/logger.dart';

class SharedPrefKeys {
  static const String isFirstLaunch = "isFirstLaunch";
  static const String isUserLoggedIn = "isUserLoggedIn";
  static const String languageCode = "languageCode";
  static const String theme = "theme";
  static const String user = "user";
  static const String tokenAccess = "tokenAccess";
  static const String tokenRefresh = "tokenRefresh";
}

class SharedPref {
  static SharedPreferences? sharedPref;
  static Future<void> initialize() async {
    if (sharedPref == null) {
      sharedPref = await SharedPreferences.getInstance();
      setDefaultValues(getString(SharedPrefKeys.theme) == null);
    }
  }

  static void setDefaultValues(bool isNullValue) {
    if (isNullValue) {
      setString(SharedPrefKeys.theme, "Dark");
      setString(SharedPrefKeys.languageCode, "en");
      setBool(SharedPrefKeys.isFirstLaunch, true);
      setBool(SharedPrefKeys.isUserLoggedIn, false);
      log("*** setDefaultValues is called ***");
    }
  }

  static String? getString(String key) {
    try {
      return sharedPref!.getString(key);
    } catch (error) {
      Logger.printt(error, isError: true);
      return null;
    }
  }

  static bool? getBool(String key) {
    try {
      return sharedPref!.getBool(key);
    } catch (error) {
      Logger.printt(error, isError: true);
      return null;
    }
  }

  static int? getInt(String key) {
    try {
      return sharedPref!.getInt(key);
    } catch (error) {
      Logger.printt(error, isError: true);
      return null;
    }
  }

  static Future<bool> setString(String key, String value) async {
    try {
      return await sharedPref!.setString(key, value);
    } catch (error) {
      Logger.printt(error, isError: true);
      return false;
    }
  }

  static Future<bool> setBool(String key, bool value) async {
    try {
      return await sharedPref!.setBool(key, value);
    } catch (error) {
      Logger.printt(error, isError: true);
      return false;
    }
  }

  static Future<bool> setInt(String key, int value) async {
    try {
      return await sharedPref!.setInt(key, value);
    } catch (error) {
      Logger.printt(error, isError: true);
      return false;
    }
  }

  static Future<void> reload() async {
    try {
      await sharedPref!.reload();
    } catch (error) {
      Logger.printt(error, isError: true);
    }
  }

  static Future<bool> remove(String key) async {
    try {
      return await sharedPref!.remove(key);
    } catch (error) {
      Logger.printt(error, isError: true);
      return false;
    }
  }

  static Future<bool> clear() async {
    try {
      return await sharedPref!.clear();
    } catch (error) {
      Logger.printt(error, isError: true);
      return false;
    }
  }
}
