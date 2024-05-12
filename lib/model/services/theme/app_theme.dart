import 'package:flutter/material.dart';
import 'package:xperience/model/config/logger.dart';
import 'package:xperience/model/services/shared_preference.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

class AppTheme with ChangeNotifier {
  AppTheme() {
    fetchAppTheme();
  }

  late bool isDark;
  late ThemeMode themeMode;

  List<String> themeModes = [
    "System",
    "Light",
    "Dark",
  ];

  ///======================================================== Fetch AppTheme from Device
  fetchAppTheme() async {
    changeThemeMode(SharedPref.getString(SharedPrefKeys.theme) ?? "Light");
    Logger.log("*** AppTheme init ***");
  }

  ///======================================================== getThemeName
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

  ///======================================== Change Theme by ThemeMode (Light , Dark & System)
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

  ///====================================================================================================
  ///============================================ Light Theme ===========================================
  ///====================================================================================================
  ThemeData? lightTheme(BuildContext context) {
    return ThemeData(
      // fontFamily: fontFamily,
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: Colors.white,
      dialogBackgroundColor: Colors.white,
      indicatorColor: AppColors.primaryColor,
      focusColor: AppColors.primaryColor,
      cardColor: Colors.white,
      dividerColor: Colors.grey,
      hintColor: Colors.grey,
      bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.primaryColor,
        secondary: AppColors.accentColor,
        brightness: Brightness.light,
        background: Colors.white,
        error: Colors.redAccent,
      ),

      //============================================ For dropdowm background color
      canvasColor: Colors.white,

      //============================================ Drawer
      drawerTheme: DrawerThemeData(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      //============================================ AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          // fontFamily: fontFamily,
          fontWeight: FontWeight.normal,
          fontSize: 16,
          color: Colors.white,
        ),
      ),

      //============================================ Divider Theme
      dividerTheme: const DividerThemeData(color: Colors.grey, thickness: 1),

      //============================================ Floating Action Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.accentColor,
      ),

      //============================================ SnackBar Theme
      snackBarTheme: const SnackBarThemeData(
        actionTextColor: AppColors.primaryColor,
        backgroundColor: AppColors.snackBarDarkBackground,
        contentTextStyle: TextStyle(
          // fontFamily: fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),

      //============================================ Dialog Theme
      dialogTheme: DialogTheme(
        elevation: 5,
        backgroundColor: Colors.white,
        iconColor: AppColors.primaryColor,
        shadowColor: Colors.black87,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),

      //============================================ Text Theme
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodySmall: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
        displaySmall: TextStyle(color: Colors.black),
        displayLarge: TextStyle(color: Colors.black),
        displayMedium: TextStyle(color: Colors.black),
        headlineLarge: TextStyle(color: Colors.black),
        headlineSmall: TextStyle(color: Colors.black),
        headlineMedium: TextStyle(color: Colors.black),
        labelLarge: TextStyle(color: Colors.black),
        labelMedium: TextStyle(color: Colors.black),
        labelSmall: TextStyle(color: Colors.black),
        titleLarge: TextStyle(color: Colors.black),
        titleMedium: TextStyle(color: Colors.black),
        titleSmall: TextStyle(color: Colors.black),
      ),

      primaryTextTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodySmall: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
        displaySmall: TextStyle(color: Colors.black),
        displayLarge: TextStyle(color: Colors.black),
        displayMedium: TextStyle(color: Colors.black),
        headlineLarge: TextStyle(color: Colors.black),
        headlineSmall: TextStyle(color: Colors.black),
        headlineMedium: TextStyle(color: Colors.black),
        labelLarge: TextStyle(color: Colors.black),
        labelMedium: TextStyle(color: Colors.black),
        labelSmall: TextStyle(color: Colors.black),
        titleLarge: TextStyle(color: Colors.black),
        titleMedium: TextStyle(color: Colors.black),
        titleSmall: TextStyle(color: Colors.black),
      ),

      //============================================  ListTile Theme
      listTileTheme: const ListTileThemeData(
        iconColor: AppColors.primaryColor,
        textColor: Colors.black,
      ),

      //============================================ ElevatedButton Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            // fontFamily: fontFamily,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),

      //============================================ Slider Theme
      sliderTheme: const SliderThemeData(
        thumbColor: AppColors.primaryColor,
        // overlayColor: AppColors.,
        valueIndicatorColor: Colors.black87,
        activeTrackColor: AppColors.primaryColor,
        // inactiveTrackColor: Colors.pink,
      ),

      //============================================ TextSelection Theme
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.primaryColor,
        selectionHandleColor: AppColors.primaryColor,
      ),
      //============================================ InputDecoration Theme
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(
          // fontFamily: fontFamily,
          color: Colors.black,
        ),
        hintStyle: TextStyle(
          color: Colors.grey,
          // fontFamily: fontFamily,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(style: BorderStyle.solid, color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(style: BorderStyle.solid, color: AppColors.primaryColor),
        ),
        // disabledBorder: UnderlineInputBorder(
        //   borderSide: BorderSide(
        //     style: BorderStyle.solid,
        //     color: Colors.red,
        //   ),
        // ),
        // border: UnderlineInputBorder(
        //   borderSide: BorderSide(
        //     style: BorderStyle.solid,
        //     color: Colors.green,
        //   ),
        // ),
        // errorBorder: UnderlineInputBorder(
        //   borderSide: BorderSide(
        //     style: BorderStyle.solid,
        //     color: Colors.teal,
        //   ),
        // ),
      ),
      //============================================ TextButton Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          textStyle: const TextStyle(
            // fontFamily: fontFamily,
            fontSize: 16,
            color: AppColors.primaryColor,
          ),
        ),
      ),

      //============================================ Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.primaryColor,
      ),
      primaryIconTheme: const IconThemeData(
        color: Colors.black,
      ),

      //============================================ Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
        trackColor: MaterialStateProperty.all<Color>(AppColors.primaryColor.withOpacity(0.5)),
        overlayColor: MaterialStateProperty.all<Color>(AppColors.primaryColor.withOpacity(0.2)),
        trackOutlineColor: MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.5)),
        splashRadius: 0.0,
        trackOutlineWidth: MaterialStateProperty.all<double>(2),
        // thumbIcon: MaterialStateProperty.all<Icon>(const Icon(Icons.brightness_2)),
      ),
      //============================================ Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        // fillColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
        checkColor: MaterialStateProperty.all<Color>(Colors.white),
        overlayColor: MaterialStateProperty.all<Color>(AppColors.primaryColor.withOpacity(0.2)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        side: MaterialStateBorderSide.resolveWith(
          (states) => const BorderSide(width: 1.5, color: AppColors.primaryColor),
        ),
      ),
      //============================================ Radio Theme
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
        overlayColor: MaterialStateProperty.all<Color>(AppColors.primaryColor.withOpacity(0.2)),
      ),

      ///=====================================================================================================================================================
      ///================================================================================================================ under construction (theme test area)
      ///=====================================================================================================================================================

      //=========================================================================================================================================================================
    );
  }

  ///====================================================================================================
  ///============================================ Dark Theme ============================================
  ///====================================================================================================

  ThemeData? darkTheme(BuildContext context) {
    return ThemeData(
      // fontFamily: fontFamily,
      brightness: Brightness.dark,
      primaryColor: Colors.blueGrey.shade900,
      scaffoldBackgroundColor: Colors.grey.shade900,
      dialogBackgroundColor: Colors.grey.shade900,
      indicatorColor: AppColors.primaryColor,
      focusColor: AppColors.primaryColor,
      cardColor: Colors.blueGrey.shade900,
      dividerColor: Colors.white54,
      hintColor: Colors.grey.shade700,
      bottomAppBarTheme: BottomAppBarTheme(color: Colors.grey.shade900),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.primaryColor,
        secondary: AppColors.accentColor,
        brightness: Brightness.dark,
        background: Colors.grey.shade900,
        error: Colors.redAccent,
      ),

      //============================================ For dropdowm background color
      canvasColor: Colors.grey.shade900,

      //============================================ Drawer
      drawerTheme: DrawerThemeData(
        backgroundColor: Colors.grey.shade900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      //============================================ AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blueGrey.shade900,
        foregroundColor: Colors.white,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          // fontFamily: fontFamily,
          fontWeight: FontWeight.normal,
          fontSize: 16,
          color: Colors.white,
        ),
      ),

      //============================================ Divider Theme
      dividerTheme: const DividerThemeData(color: Colors.grey, thickness: 1),

      //============================================ Floating Action Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.blueGrey.shade900,
      ),

      //============================================ SnackBar Theme
      snackBarTheme: SnackBarThemeData(
        actionTextColor: AppColors.primaryColor,
        backgroundColor: Colors.grey.shade600,
        contentTextStyle: const TextStyle(
          // fontFamily: fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),

      //============================================ Dialog Theme
      dialogTheme: DialogTheme(
        elevation: 5,
        backgroundColor: Colors.grey.shade900,
        iconColor: Colors.white,
        shadowColor: Colors.grey.shade900,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),

      //============================================ Text Theme
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodySmall: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
        displaySmall: TextStyle(color: Colors.white),
        displayLarge: TextStyle(color: Colors.white),
        displayMedium: TextStyle(color: Colors.white),
        headlineLarge: TextStyle(color: Colors.white),
        headlineSmall: TextStyle(color: Colors.white),
        headlineMedium: TextStyle(color: Colors.white),
        labelLarge: TextStyle(color: Colors.white),
        labelMedium: TextStyle(color: Colors.white),
        labelSmall: TextStyle(color: Colors.white),
        titleLarge: TextStyle(color: Colors.white),
        titleMedium: TextStyle(color: Colors.white),
        titleSmall: TextStyle(color: Colors.white),
      ),

      primaryTextTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodySmall: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
        displaySmall: TextStyle(color: Colors.white),
        displayLarge: TextStyle(color: Colors.white),
        displayMedium: TextStyle(color: Colors.white),
        headlineLarge: TextStyle(color: Colors.white),
        headlineSmall: TextStyle(color: Colors.white),
        headlineMedium: TextStyle(color: Colors.white),
        labelLarge: TextStyle(color: Colors.white),
        labelMedium: TextStyle(color: Colors.white),
        labelSmall: TextStyle(color: Colors.white),
        titleLarge: TextStyle(color: Colors.white),
        titleMedium: TextStyle(color: Colors.white),
        titleSmall: TextStyle(color: Colors.white),
      ),

      //============================================  ListTile Theme
      listTileTheme: const ListTileThemeData(
        iconColor: Colors.white,
        textColor: Colors.white,
      ),

      //============================================ ElevatedButton Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueGrey.shade900,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            // fontFamily: fontFamily,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),

      //============================================ Slider Theme
      sliderTheme: const SliderThemeData(
        thumbColor: AppColors.primaryColor,
        // overlayColor: AppColors.,
        valueIndicatorColor: Colors.black87,
        activeTrackColor: AppColors.primaryColor,
        // inactiveTrackColor: Colors.pink,
      ),

      //============================================ TextSelection Theme
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.primaryColor,
        selectionHandleColor: AppColors.primaryColor,
      ),

      //============================================ InputDecoration Theme
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(
          // fontFamily: fontFamily,
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.grey,
          // fontFamily: fontFamily,
        ),

        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(style: BorderStyle.solid, color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(style: BorderStyle.solid, color: AppColors.primaryColor),
        ),
        // disabledBorder: UnderlineInputBorder(
        //   borderSide: BorderSide(
        //     style: BorderStyle.solid,
        //     color: Colors.red,
        //   ),
        // ),
        // border: UnderlineInputBorder(
        //   borderSide: BorderSide(
        //     style: BorderStyle.solid,
        //     color: Colors.green,
        //   ),
        // ),
        // errorBorder: UnderlineInputBorder(
        //   borderSide: BorderSide(
        //     style: BorderStyle.solid,
        //     color: Colors.teal,
        //   ),
        // ),
      ),

      //============================================ TextButton Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.blueGrey.shade900,
          textStyle: const TextStyle(
            // fontFamily: fontFamily,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),

      //============================================ Icon Theme
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      primaryIconTheme: const IconThemeData(
        color: Colors.white,
      ),

      //============================================ Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
        trackColor: MaterialStateProperty.all<Color>(AppColors.primaryColor.withOpacity(0.5)),
        overlayColor: MaterialStateProperty.all<Color>(AppColors.primaryColor.withOpacity(0.2)),
        trackOutlineColor: MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.5)),
        splashRadius: 0.0,
        trackOutlineWidth: MaterialStateProperty.all<double>(2),
        // thumbIcon: MaterialStateProperty.all<Icon>(const Icon(Icons.brightness_2)),
      ),
      //============================================ Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        // fillColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
        checkColor: MaterialStateProperty.all<Color>(Colors.white),
        overlayColor: MaterialStateProperty.all<Color>(AppColors.primaryColor.withOpacity(0.2)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        side: MaterialStateBorderSide.resolveWith(
          (states) => const BorderSide(width: 1.5, color: AppColors.primaryColor),
        ),
      ),
      //============================================ Radio Theme
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
        overlayColor: MaterialStateProperty.all<Color>(AppColors.primaryColor.withOpacity(0.2)),
      ),
    );
  }
}
