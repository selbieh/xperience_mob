import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:xperience/model/config/logger.dart';
import 'package:xperience/model/services/shared_preference.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';

class FirebaseNotificationService {
  /// ======================================================================= Get FCM Token
  static Future<String?> getFcmToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      await SharedPref.setString(SharedPrefKeys.fcmToken, token!);
      Logger.log("FCM Token From Preference ---> ${SharedPref.getString(SharedPrefKeys.fcmToken)}");
      return token;
    } catch (error) {
      Logger.printt(error, isError: true);
      return null;
    }
  }

  /// ======================================================================= Delete FCM Token
  static Future<void> deleteFcmToken() async {
    try {
      await FirebaseMessaging.instance.deleteToken();
      await SharedPref.remove(SharedPrefKeys.fcmToken);
      Logger.log("FCM Token Deleted Preference");
    } catch (error) {
      Logger.printt(error, isError: true);
    }
  }

  /// ======================================================================= Initialize firebase messaging listener
  static Future<void> initializeFirebaseMessagingListener() async {
    try {
      await FirebaseMessaging.instance.requestPermission();
      await FirebaseMessaging.instance.getInitialMessage();

      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) {
          Logger.printt("FirebaseMessaging onMessage()");
          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android;
          AppleNotification? apple = message.notification?.apple;
          Logger.log("${message.notification?.title}");
          Logger.log("${message.notification?.body}");

          DialogsHelper.notifyDialog(
            title: "${message.notification?.title}",
            subtitle: "${message.notification?.body}",
            leading: const Icon(Icons.notifications_active, color: AppColors.goldColor),
          );
          if (notification != null && android != null) {
            Logger.printt("FirebaseMessaging onMessage() (Android)");
          } else if (notification != null && apple != null) {
            Logger.printt("FirebaseMessaging onMessage() (Apple)");
          }
        },
      );
      FirebaseMessaging.onMessageOpenedApp.listen(handleOnMessageOpenedApp);
    } catch (error) {
      Logger.printt(error, isError: true);
    }
  }
}

/// ======================================================================= Firebase Messaging OnMessageOpenedApp
void handleOnMessageOpenedApp(RemoteMessage message) async {
  Logger.printt("FirebaseMessaging onMessageOpenedApp()");
  // AuthService auth = AuthService();
  // await auth.loadUser();
  // if (auth.isLogged && (auth.userModel?.isActive ?? false)) {
  //   switch (message.data["NotificationType"]) {
  //     case "Friend Request":
  //       {
  //         NavService.instance.pushKey(const FriendRequestScreen());
  //       }
  //       break;
  //     default:
  //       {
  //         Logger.printt("${message.data["payload"]}");
  //         Logger.log("${message.data["payload"]}");
  //       }
  //   }
  // }
}
