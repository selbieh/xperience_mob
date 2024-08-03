import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static FirebaseOptions android = FirebaseOptions(
    apiKey: dotenv.env["ANDROID_API_KEY"] ?? "",
    appId: dotenv.env["ANDROID_APP_ID"] ?? "",
    messagingSenderId: dotenv.env["ANDROID_MESSAGE_SENDER_ID"] ?? "",
    projectId: dotenv.env["ANDROID_PROJECT_ID"] ?? "",
    storageBucket: dotenv.env["ANDROID_STORAGE_BUCKET"] ?? "",
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: dotenv.env["IOS_API_KEY"] ?? "",
    appId: dotenv.env["GOOGLE_APP_ID"] ?? "",
    messagingSenderId: dotenv.env["IOS_GCM_SENDER_ID"] ?? "",
    projectId: dotenv.env["IOS_PROJECT_ID"] ?? "",
    storageBucket: dotenv.env["IOS_STORAGE_BUCKET"] ?? "",
    iosClientId: dotenv.env["IOS_CLIENT_ID"] ?? "",
    iosBundleId: dotenv.env["IOS_BUNDLE_ID"] ?? "",
  );
}
