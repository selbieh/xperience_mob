import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'dart:convert';
import 'package:xperience/model/services/shared_preference.dart';

part 'app_localization.dart';

class AppLanguage extends ChangeNotifier {
  AppLanguage() {
    fetchLocale();
  }

  Locale _appLocale = const Locale("en");
  Locale get appLocale => _appLocale;

  final List<Locale> supportedLocales = const [
    Locale("en"),
    Locale("ar"),
  ];

  final List<String> languages = [
    "English",
    "العَرَبِيَّة",
  ];

  TextDirection textDirection(BuildContext context) {
    if (Directionality.of(context).name.contains("ltr")) {
      return TextDirection.ltr;
    } else {
      return TextDirection.rtl;
    }
  }

  bool isLTR() {
    if (appLocale.languageCode == "ar") {
      return false;
    } else {
      return true;
    }
  }

  ///======================================================== getLanguageName
  String getLanguageName() {
    switch (_appLocale.languageCode) {
      case "en":
        return "English";
      case "ar":
        return "العَرَبِيَّة";
      default:
        return "English";
    }
  }

  ///======================================================== Fetch Language from Device or
  fetchLocale() async {
    if (SharedPref.getString(SharedPrefKeys.languageCode) == null) {
      ///============= Get the device language code
      // String deviceLanguageCode = ui.window.locale.languageCode;
      // changeLanguage( Locale(deviceLanguageCode));
      changeLanguage(const Locale("en"));
    } else {
      _appLocale = Locale(SharedPref.getString(SharedPrefKeys.languageCode)!);
    }
    notifyListeners();
  }

  void changeLanguage(Locale locale) async {
    if (_appLocale != locale) {
      switch (locale.languageCode) {
        case "en":
          {
            _appLocale = const Locale("en");
            await SharedPref.setString(SharedPrefKeys.languageCode, "en");
          }
        case "ar":
          {
            _appLocale = const Locale("ar");
            await SharedPref.setString(SharedPrefKeys.languageCode, "ar");
          }
          break;
        default:
          {
            _appLocale = const Locale("en");
            await SharedPref.setString(SharedPrefKeys.languageCode, "en");
          }
      }
      notifyListeners();
    }
  }

  void changeLanguageByName({required String languageName}) {
    switch (languageName) {
      case "English":
        {
          changeLanguage(const Locale("en"));
        }
        break;
      case "العَرَبِيَّة":
        {
          changeLanguage(const Locale("ar"));
        }
        break;
      default:
        {
          changeLanguage(const Locale("en"));
        }
    }
    notifyListeners();
  }
}
