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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyD_tSW8qTIMDiJWs7Val1mWJ_4RGub1aDQ',
    appId: '1:209405563746:web:092b10ef31733f2d72123b',
    messagingSenderId: '209405563746',
    projectId: 'hotel-9bc20',
    authDomain: 'hotel-9bc20.firebaseapp.com',
    storageBucket: 'hotel-9bc20.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCDo-K89ORwkN4X2HiPsRmsnaT31koPanA',
    appId: '1:209405563746:android:dbce490aead192b072123b',
    messagingSenderId: '209405563746',
    projectId: 'hotel-9bc20',
    storageBucket: 'hotel-9bc20.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_YAzYkOvNo9KFoOtQaMU1Mubvnwj8w7k',
    appId: '1:209405563746:ios:5490d19b3f8106a672123b',
    messagingSenderId: '209405563746',
    projectId: 'hotel-9bc20',
    storageBucket: 'hotel-9bc20.appspot.com',
    iosBundleId: 'com.example.hotelflutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD_YAzYkOvNo9KFoOtQaMU1Mubvnwj8w7k',
    appId: '1:209405563746:ios:ab4d9c2dbc130a7172123b',
    messagingSenderId: '209405563746',
    projectId: 'hotel-9bc20',
    storageBucket: 'hotel-9bc20.appspot.com',
    iosBundleId: 'com.example.hotelflutter.RunnerTests',
  );
}