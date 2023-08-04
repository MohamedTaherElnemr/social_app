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
    apiKey: 'AIzaSyDS8AV3fzSTNbPVv5gOfiCHZ5UubR4UkTg',
    appId: '1:328674907470:web:9dfd7f0b2073574bf27a1f',
    messagingSenderId: '328674907470',
    projectId: 'social-app-ba0c6',
    authDomain: 'social-app-ba0c6.firebaseapp.com',
    storageBucket: 'social-app-ba0c6.appspot.com',
    measurementId: 'G-F5GX0KBG40',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDBx-NHbOwIdqiNHId7VFWDJzPC8RrfMp8',
    appId: '1:328674907470:android:75a46864dc80943bf27a1f',
    messagingSenderId: '328674907470',
    projectId: 'social-app-ba0c6',
    storageBucket: 'social-app-ba0c6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCi0P9zgG647H26gEgOv5Rrw3TZFapSBwk',
    appId: '1:328674907470:ios:dfe7a03a117f9103f27a1f',
    messagingSenderId: '328674907470',
    projectId: 'social-app-ba0c6',
    storageBucket: 'social-app-ba0c6.appspot.com',
    iosClientId: '328674907470-uf3li10q06g184deeo6g8694v4m0bhgh.apps.googleusercontent.com',
    iosBundleId: 'com.example.socialApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCi0P9zgG647H26gEgOv5Rrw3TZFapSBwk',
    appId: '1:328674907470:ios:f635dc89d0c5c6edf27a1f',
    messagingSenderId: '328674907470',
    projectId: 'social-app-ba0c6',
    storageBucket: 'social-app-ba0c6.appspot.com',
    iosClientId: '328674907470-f9b7o64egf22pafkq82o559q5doidutl.apps.googleusercontent.com',
    iosBundleId: 'com.example.socialApp.RunnerTests',
  );
}
