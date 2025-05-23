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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyA26-mbn6AvUGqhJTKmTpOwWUQpMST29BQ',
    appId: '1:307957961132:web:3a70269026acac818cea09',
    messagingSenderId: '307957961132',
    projectId: 'our-spotify',
    authDomain: 'our-spotify.firebaseapp.com',
    storageBucket: 'our-spotify.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB9fAMs-Rsq9vs0GFpYmJAqEbCnC2zK1SM',
    appId: '1:307957961132:android:c246e414b1a31f258cea09',
    messagingSenderId: '307957961132',
    projectId: 'our-spotify',
    storageBucket: 'our-spotify.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBik312RqXhJDlwanaS9h9ULySLXYWpxeg',
    appId: '1:307957961132:ios:a7478fb1c63beccb8cea09',
    messagingSenderId: '307957961132',
    projectId: 'our-spotify',
    storageBucket: 'our-spotify.firebasestorage.app',
    iosBundleId: 'com.bldsht.ourSpotify',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBik312RqXhJDlwanaS9h9ULySLXYWpxeg',
    appId: '1:307957961132:ios:a7478fb1c63beccb8cea09',
    messagingSenderId: '307957961132',
    projectId: 'our-spotify',
    storageBucket: 'our-spotify.firebasestorage.app',
    iosBundleId: 'com.bldsht.ourSpotify',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA26-mbn6AvUGqhJTKmTpOwWUQpMST29BQ',
    appId: '1:307957961132:web:13c7beebc91259668cea09',
    messagingSenderId: '307957961132',
    projectId: 'our-spotify',
    authDomain: 'our-spotify.firebaseapp.com',
    storageBucket: 'our-spotify.firebasestorage.app',
  );
}
