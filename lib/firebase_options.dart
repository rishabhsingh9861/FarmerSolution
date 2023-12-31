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
    apiKey: 'AIzaSyB4RzcS-T2f-LwUTdYhgQbSZmK-50vpIjg',
    appId: '1:898702441458:web:e494c11c7cc9270b22c96b',
    messagingSenderId: '898702441458',
    projectId: 'farmer-solution',
    authDomain: 'farmer-solution.firebaseapp.com',
    storageBucket: 'farmer-solution.appspot.com',
    measurementId: 'G-W5ZF3P8R5H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyACfQm_y4eOCbpayzbcLqR4yK7rcHoXqFI',
    appId: '1:898702441458:android:3bb52bf855ec981a22c96b',
    messagingSenderId: '898702441458',
    projectId: 'farmer-solution',
    storageBucket: 'farmer-solution.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD0sUwfRh8iIUTvDoIXWTDJ-9bHyMUpOPk',
    appId: '1:898702441458:ios:f92a7a8b0b48fce922c96b',
    messagingSenderId: '898702441458',
    projectId: 'farmer-solution',
    storageBucket: 'farmer-solution.appspot.com',
    iosBundleId: 'com.example.farmerSolution',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD0sUwfRh8iIUTvDoIXWTDJ-9bHyMUpOPk',
    appId: '1:898702441458:ios:f92a7a8b0b48fce922c96b',
    messagingSenderId: '898702441458',
    projectId: 'farmer-solution',
    storageBucket: 'farmer-solution.appspot.com',
    iosBundleId: 'com.example.farmerSolution',
  );
}
