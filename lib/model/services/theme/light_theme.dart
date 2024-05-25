import 'package:flutter/material.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

ThemeData? lightTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColorLight,
    scaffoldBackgroundColor: Colors.white,
    dialogBackgroundColor: Colors.white,
    indicatorColor: AppColors.primaryColorLight,
    focusColor: AppColors.primaryColorLight,
    cardColor: Colors.white,
    dividerColor: Colors.grey,
    hintColor: Colors.grey,
    bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
    // colorScheme: ColorScheme.fromSwatch().copyWith(
    //   primary: AppColors.primaryColor,
    //   secondary: AppColors.accentColor,
    //   brightness: Brightness.light,
    //   background: Colors.white,
    //   error: Colors.redAccent,
    // ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColorLight,
      primary: AppColors.primaryColorLight,
      secondary: AppColors.primaryColorLight,
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
        borderRadius: BorderRadius.circular(25),
      ),
    ),

    //============================================ AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColorLight,
      foregroundColor: Colors.white,
      centerTitle: false,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16,
        color: Colors.white,
      ),
    ),

    //============================================ Divider Theme
    dividerTheme: const DividerThemeData(color: Colors.grey, thickness: 1),

    //============================================ Floating Action Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColorLight,
    ),

    //============================================ SnackBar Theme
    snackBarTheme: const SnackBarThemeData(
      actionTextColor: AppColors.primaryColorLight,
      backgroundColor: AppColors.snackBarDarkBackground,
      contentTextStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    ),

    //============================================ Dialog Theme
    dialogTheme: DialogTheme(
      elevation: 5,
      backgroundColor: Colors.white,
      iconColor: AppColors.primaryColorLight,
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
      iconColor: AppColors.primaryColorLight,
      textColor: Colors.black,
    ),

    //============================================ ElevatedButton Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColorLight,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    ),

    //============================================ Slider Theme
    sliderTheme: const SliderThemeData(
      thumbColor: AppColors.primaryColorLight,
      // overlayColor: AppColors.,
      valueIndicatorColor: Colors.black87,
      activeTrackColor: AppColors.primaryColorLight,
      // inactiveTrackColor: Colors.pink,
    ),

    //============================================ TextSelection Theme
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primaryColorLight,
      selectionHandleColor: AppColors.primaryColorLight,
    ),
    //============================================ InputDecoration Theme
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.black),
      hintStyle: TextStyle(
        color: Colors.grey,
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(style: BorderStyle.solid, color: Colors.grey),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(style: BorderStyle.solid, color: AppColors.primaryColorLight),
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
        foregroundColor: AppColors.primaryColorLight,
        textStyle: const TextStyle(
          fontSize: 16,
          color: AppColors.primaryColorLight,
        ),
      ),
    ),

    //============================================ Icon Theme
    iconTheme: const IconThemeData(
      color: AppColors.primaryColorLight,
    ),
    primaryIconTheme: const IconThemeData(
      color: Colors.black,
    ),

    //============================================ Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all<Color>(AppColors.primaryColorLight),
      trackColor: MaterialStateProperty.all<Color>(AppColors.primaryColorLight.withOpacity(0.5)),
      overlayColor: MaterialStateProperty.all<Color>(AppColors.primaryColorLight.withOpacity(0.2)),
      trackOutlineColor: MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.5)),
      splashRadius: 0.0,
      trackOutlineWidth: MaterialStateProperty.all<double>(2),
      // thumbIcon: MaterialStateProperty.all<Icon>(const Icon(Icons.brightness_2)),
    ),
    //============================================ Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      // fillColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
      checkColor: MaterialStateProperty.all<Color>(Colors.white),
      overlayColor: MaterialStateProperty.all<Color>(AppColors.primaryColorLight.withOpacity(0.2)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      side: MaterialStateBorderSide.resolveWith(
        (states) => const BorderSide(width: 1.5, color: AppColors.primaryColorLight),
      ),
    ),
    //============================================ Radio Theme
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all<Color>(AppColors.primaryColorLight),
      overlayColor: MaterialStateProperty.all<Color>(AppColors.primaryColorLight.withOpacity(0.2)),
    ),
  );
}
