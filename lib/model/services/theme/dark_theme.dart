import 'package:flutter/material.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

ThemeData? darkTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey.shade900,
    // scaffoldBackgroundColor: Colors.grey.shade900,
    // dialogBackgroundColor: Colors.grey.shade900,
    scaffoldBackgroundColor: AppColors.primaryColorDark,
    dialogBackgroundColor: AppColors.primaryColorDark,
    indicatorColor: AppColors.primaryColorLight,
    focusColor: AppColors.primaryColorLight,
    cardColor: Colors.blueGrey.shade900,
    dividerColor: Colors.white54,
    hintColor: Colors.grey.shade700,
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.grey.shade900),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColorLight,
      primary: AppColors.primaryColorLight,
      secondary: AppColors.primaryColorLight,
      brightness: Brightness.dark,
      background: Colors.white,
      error: Colors.redAccent,
    ),

    //============================================ For dropdowm background color
    canvasColor: Colors.grey.shade900,

    //============================================ Drawer
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.grey.shade900,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    ),

    //============================================ AppBar Theme
    appBarTheme: const AppBarTheme(
      // backgroundColor: Colors.blueGrey.shade900,
      backgroundColor: AppColors.primaryColorLight,
      // foregroundColor: Colors.white,
      foregroundColor: AppColors.goldColor,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
      iconTheme: IconThemeData(color: Colors.white),
      // iconTheme: IconThemeData(color: AppColors.goldColor),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16,
        color: Colors.white,
        // color: AppColors.goldColor,
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
      actionTextColor: AppColors.primaryColorLight,
      backgroundColor: Colors.grey.shade600,
      contentTextStyle: const TextStyle(
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
      cursorColor: AppColors.grey,
      selectionHandleColor: AppColors.goldColor,
      selectionColor: Colors.blue,
    ),

    //============================================ InputDecoration Theme
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.white),
      hintStyle: TextStyle(color: Colors.grey),

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
        foregroundColor: Colors.blueGrey.shade900,
        textStyle: const TextStyle(
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
      // fillColor: MaterialStateProperty.all<Color>(AppColors.primaryColorLight),
      // checkColor: MaterialStateProperty.all<Color>(Colors.white),
      checkColor: MaterialStateProperty.all<Color>(AppColors.goldColor),
      overlayColor: MaterialStateProperty.all<Color>(AppColors.primaryColorLight.withOpacity(0.2)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      side: MaterialStateBorderSide.resolveWith(
        (states) => const BorderSide(width: 1.5, color: AppColors.grey),
      ),
    ),
    //============================================ Radio Theme
    radioTheme: RadioThemeData(
      // fillColor: MaterialStateProperty.all<Color>(AppColors.primaryColorLight),
      fillColor: MaterialStateProperty.all<Color>(AppColors.goldColor),
      overlayColor: MaterialStateProperty.all<Color>(AppColors.primaryColorLight.withOpacity(0.2)),
    ),
  );
}
