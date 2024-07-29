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
 - Notifications
 - Hide description if null

==================================================================================

 {
      "user": 4,
      "car_reservations": [
           {
                "car_service": null,
                "pickup_time": "2024-07-30T16:15:00Z",
                "pickup_address": "test",
                "dropoff_address": "test",
                "terminal": null,
                "flight_number": null,
                "extras": "",
                "final_price": 1440.0,
                "subscription_option": 1,
                "options": [
                     {
                          "service_option": 6,
                          "quantity": 1,
                          "price": 400.0,
                          "max_free": 0,
                          "points_price": null
                     },
                     {
                          "service_option": 3,
                          "quantity": 1,
                          "price": 30.0,
                          "max_free": 1,
                          "points_price": null
                     },
                     {
                          "service_option": 5,
                          "quantity": 1,
                          "price": 40.0,
                          "max_free": 0,
                          "points_price": null
                     }
                ]
           }
      ],
      "hotel_reservations": [],
      "status": "WAITING_FOR_PAYMENT",
      "payment_method": "CREDIT_CARD",
      "promocode": null,
      "discount": 0,
      "final_reservation_price": 1440.0,
      "total_points_price": 0
 }
==================================================================================
==================================================================================
==================================================================================

*/