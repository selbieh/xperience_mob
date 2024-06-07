import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyDo2pozKWpVhdSyCgZBr67iRfZ8l_CxqGM",
    appId: "1:514143788543:android:4cdebdcf95e763d3025bca",
    messagingSenderId: "514143788543",
    projectId: "experience-9062b",
    storageBucket: "experience-9062b.appspot.com",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AAAAAAAAAAAAAAAAAAAAAAAA",
    appId: "AAAAAAAAAAAAAAAAAAAAAAAA",
    messagingSenderId: "AAAAAAAAAAAAAAAAAAAAAAAA",
    projectId: "AAAAAAAAAAAAAAAAAAAAAAAA",
    storageBucket: "AAAAAAAAAAAAAAAAAAAAAAAA",
    iosClientId: "AAAAAAAAAAAAAAAAAAAAAAAA",
    iosBundleId: "AAAAAAAAAAAAAAAAAAAAAAAA",
  );
}
