// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDPDCkk3d8gZAGe0t6aVaYI1b9JNsJ2mGs',
    appId: '1:176763569340:android:1e139cef3fbd64fbe47cb9',
    messagingSenderId: '176763569340',
    projectId: 'flutter-poc-a3b74',
    storageBucket: 'flutter-poc-a3b74.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBLrJmM3x7A8hCf1zgpPgpLTcp1BFYjIgo',
    appId: '1:176763569340:ios:0954c0894f7caad7e47cb9',
    messagingSenderId: '176763569340',
    projectId: 'flutter-poc-a3b74',
    storageBucket: 'flutter-poc-a3b74.appspot.com',
    androidClientId: '176763569340-slejqtum57u7276ah2v2aqtmpo29vl40.apps.googleusercontent.com',
    iosClientId: '176763569340-66g7m1mb591q4c5tc9r9soegrl7ggpak.apps.googleusercontent.com',
    iosBundleId: 'com.example.shopee',
  );
}
