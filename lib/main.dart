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
    await dotenv.load(fileName: "assets/.env");
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
 - Car 360 image 
 - implement cars list 
 - implement hotel list 

==================================================================================
{
    "id": 10,
    "model": "8Glld",
    "make": "BMW",
    "description": "Comfort Car",
    "number_of_seats": 6,
    "year": 2022,
    "color": "Black",
    "type": "SUV",
    "cool": true,
    "image": "http://impressive-domini-royals-1be52931.koyeb.app/media/car_image/Screenshot_from_2024-05-26_16-50-46.png",
    "subscription_options": [ "" ],
     "images": [
    {
      "id": 0,
      "image": "string",
      "car_service": 0
    }
  ]
}


Launching lib/main.dart on sdk gphone arm64 in debug mode...
✓  Built build/app/outputs/flutter-apk/app-debug.apk.
Connecting to VM Service at ws://127.0.0.1:49620/DQphuRCnIes=/ws
[log] *** setDefaultValues is called ***
I/FirebaseApp( 6468): Device unlocked: initializing all Firebase APIs for app [DEFAULT]
I/TetheringManager( 6468): registerTetheringEventCallback:com.codemaker.xperience
I/DynamiteModule( 6468): Considering local module com.google.android.gms.measurement.dynamite:115 and remote module com.google.android.gms.measurement.dynamite:109
I/DynamiteModule( 6468): Selected local version of com.google.android.gms.measurement.dynamite
I/FA      ( 6468): App measurement initialized, version: 95001
I/FA      ( 6468): To enable debug logging run: adb shell setprop log.tag.FA VERBOSE
I/FA      ( 6468): To enable faster debug mode event logging run:
I/FA      ( 6468):   adb shell setprop debug.firebase.analytics.app com.codemaker.xperience
E/FA      ( 6468): Missing google_app_id. Firebase Analytics disabled. See https://goo.gl/NAOOOI
E/FA      ( 6468): Uploading is not possible. App measurement disabled
[log] FCM Token From Preference ---> eF3KPzcGT4aEiHKpQ2jO2l:APA91bE9KRCqasDwraJu2jVCLSVEtIK-kKCH2mGsvK5DCKKZPE7JCg0aAju3bZKZhdyFKMV7PHzvB8j4PYmjGJQXdZCnzgvLi-wEBecps679rmlc2VDgeNQGrJAoCRzgy9PeUtAKTqI-

D/FLTFireMsgReceiver( 6987): broadcast received for message
W/maker.xperienc( 6987): Accessing hidden method Landroid/os/WorkSource;->add(I)Z (greylist,test-api, reflection, allowed)
W/maker.xperienc( 6987): Accessing hidden method Landroid/os/WorkSource;->add(ILjava/lang/String;)Z (greylist,test-api, reflection, allowed)
W/maker.xperienc( 6987): Accessing hidden method Landroid/os/WorkSource;->get(I)I (greylist, reflection, allowed)
W/maker.xperienc( 6987): Accessing hidden method Landroid/os/WorkSource;->getName(I)Ljava/lang/String; (greylist, reflection, allowed)
I/FA      ( 6987): Tag Manager is not found and thus will not be used
E/FA      ( 6987): Missing google_app_id. Firebase Analytics disabled. See https://goo.gl/NAOOOI

==================================================================================

endpoint: api/reservations
body:

{
    "car_reservations": [
        {
            "car_service": 2,
            "pickup_time": "2023-01-15T15:00:00Z",
            "pickup_address": "Cairo",
            "pickup_lat": 2343,
            "pickup_long": 2134123,
            "pickup_url": "http://example.com",
            "dropoff_address": "Shubra",
            "dropoff_lat": 2343,
            "dropoff_long": 2134123,
            "dropoff_url": "http://example.com",
            "terminal": "asdfADSF",
            "flight_number": "asf5551244",
            "extras": "sadgadsfghsdhfgsdfghdsfghdfghdfgh",
            "options": [
                {
                    "service_option": 1,
                    "quantity": 2
                },
                {
                    "service_option": 2,
                    "quantity": 2
                }
            ],
            "subscription_option": 1
        }
    ],
    
    "hotel_reservations": [
        {
            "hotel_service": 1,
            "check_in_date": "2023-01-15",
            "check_out_date": "2023-01-17",
            "address": "Downtown",
            "location_lat": 30.0444,
            "location_long": 31.2357,
            "location_url": "http://example.com",
            "extras": "extra bed",
            "options": [
                {
                    "service_option": 1,
                    "quantity": 2
                },
                {
                    "service_option": 2,
                    "quantity": 2
                }
            ]
        }
    ]
}


 {
      "count": 1,
      "next": null,
      "previous": null,
      "results": [
           {
                "id": 1,
                "user": 3,
                "car_reservations": [
                     {
                          "id": 1,
                          "car_service": {
                               "id": 10,
                               "model": null,
                               "make": null,
                               "number_of_seats": 6,
                               "year": 2022,
                               "type": "SUV"
                          },
                          "pickup_time": "2023-06-15T15:00:00Z",
                          "pickup_address": "Giza, 6th of october city",
                          "pickup_lat": 29.970402,
                          "pickup_long": 30.952246,
                          "pickup_url": null,
                          "dropoff_address": "Cairo, tahrir square",
                          "dropoff_lat": 30.044318,
                          "dropoff_long": 31.235752,
                          "dropoff_url": null,
                          "terminal": "",
                          "flight_number": "",
                          "extras": "sadgadsf ghsdhfgsdfg hdsfgh dfghdfgh",
                          "final_price": "0.00",
                          "subscription_option": null,
                          "options": []
                     }
                ],
                "hotel_reservations": [],
                "created_by": {
                     "id": 3,
                     "name": "ahmed2",
                     "email": "ahmed2@test.com",
                     "mobile": "+201009658566",
                     "wallet": 0,
                     "is_staff": false
                },
                "status": "CONFIRMED",
                "created_at": "2024-06-08T15:36:18.823070Z"
           }
      ]
 }

================================================================================== Reservation Request (Booking)

I/flutter (10554): =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
I/flutter (10554): URI: https://impressive-domini-royals-1be52931.koyeb.app/api/reservations/
I/flutter (10554): EndPoint: /api/reservations/
I/flutter (10554): Request Type: POST
I/flutter (10554): Header: {Accept: application/json, Content-Type: application/json, Accept-Language: en, Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwOTQzMjA0LCJpYXQiOjE3MTgzNTEyMDQsImp0aSI6Ijc2ZGI0MDc1MzhjMTQzNzBiMjQyNzYyZTE2ODY0MzkzIiwidXNlcl9pZCI6M30.UdCv6Gxhz_ms7_lsA_AaVXw9_GtxQO8aPl5RO6MflQQ}
I/flutter (10554): Body: {car_reservations: [{car_service_id: 6, pickup_time: 2024-06-26T05:30:00.000Z, pickup_address: Giza, 6th of october city, pickup_lat: 29.970402, pickup_long: 30.952246, dropoff_address: Cairo, tahrir square, dropoff_lat: 30.044318, dropoff_long: 31.235752, extras: , options: [{service_option: 4, quantity: 2}, {service_option: 6, quantity: 1}], subscription_option: 2}]}
I/flutter (10554): QueryParams: null
I/flutter (10554): =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 {
      "id": 4,
      "user": 3,
      "car_reservations": [
           {
                "id": 3,
                "car_service": {
                     "id": 6,
                     "model": "COROLLA 68",
                     "make": "",
                     "number_of_seats": 6,
                     "year": 2022,
                     "type": "SUV"
                },
                "pickup_time": "2024-06-26T05:30:00Z",
                "pickup_address": "Giza, 6th of october city",
                "pickup_lat": 29.970402,
                "pickup_long": 30.952246,
                "pickup_url": "null",
                "dropoff_address": "Cairo, tahrir square",
                "dropoff_lat": 30.044318,
                "dropoff_long": 31.235752,
                "dropoff_url": "null",
                "terminal": "null",
                "flight_number": "null",
                "extras": "",
                "final_price": "6.00",
                "subscription_option": 2,
                "options": [
                     {
                          "service_option": 4,
                          "quantity": 2
                     },
                     {
                          "service_option": 6,
                          "quantity": 1
                     }
                ]
           }
      ],
      "hotel_reservations": [],
      "created_by": {
           "id": 3,
           "name": "ahmed2",
           "email": "ahmed2@test.com",
           "mobile": "+201009658566",
           "wallet": 0,
           "is_staff": false
      },
      "status": "CONFIRMED",
      "created_at": "2024-06-14T09:14:42.350743Z"
 }
================================================================================== Service search error
 =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 URI: https://impressive-domini-royals-1be52931.koyeb.app/api/car-services/?offset=0&limit=10&search=test
 EndPoint: /api/car-services/
 Request Type: GET
 Header: {Accept: application/json, Content-Type: application/json, Accept-Language: en}
 Body: null
 QueryParams: {offset: 0, limit: 10, search: test}
W/IInputConnectionWrapper( 5931): getTextAfterCursor on inactive InputConnection
 =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 ❌❌ Request Failed (500) ❌❌
 {
      "type": "server_error",
      "errors": [
           {
                "code": "error",
                "detail": "Unsupported lookup 'icontains' for ForeignKey or join on the field not permitted.",
                "attr": null
           }
      ]
 }
==================================================================================
==================================================================================
==================================================================================

*/