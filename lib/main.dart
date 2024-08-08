import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/config/app_environment.dart';
import 'package:xperience/model/config/logger.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/notifications/firebase_notification_service.dart';
import 'package:xperience/model/services/notifications/firebase_options.dart';
import 'package:xperience/model/services/providers/provider_setup.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/shared_preference.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/model/services/theme/app_theme.dart';
import 'package:xperience/model/services/theme/dark_theme.dart';
import 'package:xperience/view/screens/auth/splash_screen.dart';

void main() async {
  try {
    AppEnvironment.initialize(EnvironmentType.development);
    WidgetsFlutterBinding.ensureInitialized();
    // await dotenv.load(fileName: "assets/.env");
    await dotenv.load(fileName: ".env");
    await Future.wait([
      SharedPref.initialize(),
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value) {
        FirebaseNotificationService.initializeFirebaseMessagingListener();
      }),
    ]);
    setupLocator();
  } catch (error) {
    Logger.printt(error, isError: true);
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer2<AppLanguage, AppTheme>(
        builder: (context, language, theme, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppEnvironment.instance.appName,

            // Theme
            // theme: ThemeData(
            //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            //   useMaterial3: true,
            // ),
            color: AppColors.primaryColorLight,
            theme: darkTheme(context),
            darkTheme: darkTheme(context),
            themeMode: theme.themeMode,

            // Navigation
            navigatorKey: NavService().navigationKey,
            home: const SplashScreen(),

            // Localizations
            locale: language.appLocale,
            supportedLocales: language.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}



/*
================================================================================== Todo
- 


  



================================================================================== Dashboard info
https://dashboard.xperiences.vip/dashboard
+201095063697

==================================================================================
 {
      "id": 1,
      "name": "Giza Hotel",
      "name_ar": "فندق الجيزة",
      "name_en": "Giza Hotel",
      "description": "Hotel with fascinating view",
      "view": "Egyption pyramids",
      "number_of_rooms": 1,
      "number_of_beds": 1,
      "day_price": "500.00",
      "features": [
           {
                "id": 1,
                "name": "WIFI",
                "description": "Speed wifi",
                "image": ""
           },
           {
                "id": 2,
                "name": "Tea Heater",
                "description": "Original Heater",
                "image": ""
           },
           {
                "id": 3,
                "name": "Paid Parking",
                "description": "Parking is available at location for 25$ per day.",
                "image": ""
           },
           {
                "id": 5,
                "name": "Swimming Pool",
                "description": "The Four Seasons Hotel offers a wide range of indoor as well as outdoor pools.",
                "image": ""
           }
      ],
      "images": [
           {
                "id": 1,
                "image": "https://xperience-media.fra1.digitaloceanspaces.com/xperience-media/hotel_images/Hotel1.jpg",
                "hotel_service": 1
           },
           {
                "id": 2,
                "image": "https://xperience-media.fra1.digitaloceanspaces.com/xperience-media/hotel_images/Hotel2.jpg",
                "hotel_service": 1
           },
           {
                "id": 3,
                "image": "https://xperience-media.fra1.digitaloceanspaces.com/xperience-media/hotel_images/hotel3.jpg",
                "hotel_service": 1
           }
      ],
      "address": "Cairo/ giza",
      "location_lat": 0.000,
      "location_long": 0.000,
      "location_url": "",
      "points": 50,
      "points_price": 500,
      "dollar_day_price": "4.00"
 }
==================================================================================
==================================================================================
==================================================================================

*/