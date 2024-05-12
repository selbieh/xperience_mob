part of 'app_language.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  /// Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  /// Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  late Map<String, String> _localizedMap;

  Future<bool> load() async {
    /// Load the language JSON file from the "lang" folder
    String jsonString = await rootBundle.loadString("lib/model/services/localization/${locale.languageCode}.json");
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedMap = jsonMap.map((key, value) => MapEntry(key, value.toString()));
    return true;
  }

  String get(String key) {
    return _localizedMap[key] ?? key;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    return [
      "en",
      "ar",
    ].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) {
    return false;
  }
}

///======================================================== Extensions
extension StringLocalization on String {
  String localize(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return locale.get(this);
  }
  // *** using ***
  // Text("Home".localize(context))
}

extension TextLocalization on Text {
  Text localize(BuildContext context) {
    return Text(
      "$data".localize(context),
      key: key,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      selectionColor: selectionColor,
      textHeightBehavior: textHeightBehavior,
      textScaler: textScaler,
    );
  }
}
