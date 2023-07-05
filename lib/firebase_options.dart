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
    apiKey: 'AIzaSyDuIS3Xp1cH_QfEOBB3bmO4AnCDOeZfbaw',
    appId: '1:334595696604:web:d95f3a110c7fad420f1119',
    messagingSenderId: '334595696604',
    projectId: 'seller-e5d9e',
    authDomain: 'seller-e5d9e.firebaseapp.com',
    databaseURL: 'https://seller-e5d9e-default-rtdb.firebaseio.com',
    storageBucket: 'seller-e5d9e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBfw3G8PjyoLXOqEP2Xmc0qPYhsDr_UmRo',
    appId: '1:334595696604:android:791fc3ad9871981e0f1119',
    messagingSenderId: '334595696604',
    projectId: 'seller-e5d9e',
    databaseURL: 'https://seller-e5d9e-default-rtdb.firebaseio.com',
    storageBucket: 'seller-e5d9e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBW4mgePsfa3L5-nrg3qbRYRuDXEj5EY74',
    appId: '1:334595696604:ios:8496f2b36a8c7b8d0f1119',
    messagingSenderId: '334595696604',
    projectId: 'seller-e5d9e',
    databaseURL: 'https://seller-e5d9e-default-rtdb.firebaseio.com',
    storageBucket: 'seller-e5d9e.appspot.com',
    iosClientId: '334595696604-ajnpe4o8m1aoggt3ts3uhr8o4akbamdg.apps.googleusercontent.com',
    iosBundleId: 'com.example.adminApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBW4mgePsfa3L5-nrg3qbRYRuDXEj5EY74',
    appId: '1:334595696604:ios:8496f2b36a8c7b8d0f1119',
    messagingSenderId: '334595696604',
    projectId: 'seller-e5d9e',
    databaseURL: 'https://seller-e5d9e-default-rtdb.firebaseio.com',
    storageBucket: 'seller-e5d9e.appspot.com',
    iosClientId: '334595696604-ajnpe4o8m1aoggt3ts3uhr8o4akbamdg.apps.googleusercontent.com',
    iosBundleId: 'com.example.adminApp',
  );
}
