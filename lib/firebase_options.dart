// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    if (kIsWeb) {
      return web;
    }
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDLGmnXBSm-p-X9QWerhD9AXkBdg7Nyn8U',
    appId: '1:1069494412563:web:5689800b42dfd2502f26e6',
    messagingSenderId: '1069494412563',
    projectId: 'remainder-9bc1d',
    authDomain: 'remainder-9bc1d.firebaseapp.com',
    storageBucket: 'remainder-9bc1d.appspot.com',
    measurementId: 'G-0NW19LY8E9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBL-Cvh8FETCIXmiK6g1YCf4KW8p1WHFxQ',
    appId: '1:1069494412563:android:2cfc2f4990acf1d12f26e6',
    messagingSenderId: '1069494412563',
    projectId: 'remainder-9bc1d',
    storageBucket: 'remainder-9bc1d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBo2oomWj9UlcA4f8wZUA2oq0I5AL4P-WY',
    appId: '1:1069494412563:ios:5c3079a956140a4a2f26e6',
    messagingSenderId: '1069494412563',
    projectId: 'remainder-9bc1d',
    storageBucket: 'remainder-9bc1d.appspot.com',
    iosBundleId: 'com.example.notification',
  );
}
