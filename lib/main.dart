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
      "car_reservations": [],
      "hotel_reservations": [
           {
                "hotel_service": 6,
                "hotel_service_price": 1.0,
                "check_in_date": "2024-08-08",
                "check_out_date": "2024-08-09",
                "extras": "",
                "final_price": 601.0,
                "options": [
                     {
                          "service_option": 7,
                          "service_option_name": "Shisha Service",
                          "quantity": 2,
                          "price": 300.0,
                          "max_free": 1,
                          "points_price": null
                     },
                     {
                          "service_option": 8,
                          "service_option_name": "Private bulter",
                          "quantity": 1,
                          "price": 300.0,
                          "max_free": 0,
                          "points_price": null
                     }
                ]
           }
      ],
      "status": "WAITING_FOR_PAYMENT",
      "payment_method": "CREDIT_CARD",
      "promocode": null,
      "discount": 0,
      "final_reservation_price": 601.0,
      "total_points_price": 0
 }
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
 URI: https://api.xperiences.vip/api/calculate-reservation/
 EndPoint: /api/calculate-reservation/
 Request Type: POST
 Header: {Accept: application/json, Content-Type: application/json, Accept-Language: en, Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzI0Nzg5NDQ0LCJpYXQiOjE3MjIxOTc0NDQsImp0aSI6Ijg4NmU0MzRjM2I2MjQyOWY4ZGIwNDBhN2FmNWEyNWM5IiwidXNlcl9pZCI6NH0.UziWE2bT_yxW-ilGPJbLZ7_Kxu1mLjz8O0QGbQV_oME}
 Body: {hotel_reservations: [{hotel_service_id: 6, check_in_date: 2024-08-07, check_out_date: 2024-08-08, extras: , options: [{service_option: 7, quantity: 3}, {service_option: 8, quantity: 1}]}], payment_method: CREDIT_CARD}
 QueryParams: null
 
 ❌❌ Request Failed (500) ❌❌
  {
       "type": "server_error",
       "errors": [
            {
                 "code": "error",
                 "detail": "'HotelService' object has no attribute 'price'",
                 "attr": null
            }
       ]
  }
==================================================================================
{
     "hotel_reservations": [""],
     "created_by": {
          "id": 4,
          "name": "Ahmed Ezzeldin2",
          "email": "ahmedezz@test.com",
          "mobile": "+201009658566",
          "wallet": 0,
          "is_staff": false,
          "points": null
     },
     "status": "PAID",
     "created_at": "2024-07-30T19:51:50.881270Z",
     "payment_method": "CREDIT_CARD",
     "promocode": {
          "id": 2,
          "code": "5545",
          "discount_type": "FIXED",
          "discount_value": "50.00",
          "is_active": true,
          "expiration_date": "2024-12-29T00:00:00Z"
     }
}

==================================================================================
==================================================================================

*/