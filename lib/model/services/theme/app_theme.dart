import 'package:flutter/material.dart';
import 'package:xperience/model/services/shared_preference.dart';

class AppTheme with ChangeNotifier {
  AppTheme() {
    fetchAppTheme();
  }

  late ThemeMode themeMode;

  List<String> themeModes = [
    "System",
    "Light",
    "Dark",
  ];

  fetchAppTheme() async {
    changeThemeMode(SharedPref.getString(SharedPrefKeys.theme) ?? "Dark");
  }

  String getThemeName() {
    switch (themeMode) {
      case ThemeMode.system:
        return "System";
      case ThemeMode.light:
        return "Light";
      case ThemeMode.dark:
        return "Dark";
    }
  }

  Future<void> changeThemeMode(String theme) async {
    switch (theme) {
      case "System":
        {
          themeMode = ThemeMode.system;
          await SharedPref.setString(SharedPrefKeys.theme, theme);
        }
        break;
      case "Light":
        {
          themeMode = ThemeMode.light;
          await SharedPref.setString(SharedPrefKeys.theme, theme);
        }
        break;
      case "Dark":
        {
          themeMode = ThemeMode.dark;
          await SharedPref.setString(SharedPrefKeys.theme, theme);
        }
        break;
    }
    notifyListeners();
  }
}
