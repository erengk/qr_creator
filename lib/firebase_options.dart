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
    apiKey: 'AIzaSyC1LvRKkVJhb6A3G6wPNbjPZ_H5ye_IsuU',
    appId: '1:330478696994:web:ee85e9dc1babc0a50b287b',
    messagingSenderId: '330478696994',
    projectId: 'my-qr-creator-app',
    authDomain: 'my-qr-creator-app.firebaseapp.com',
    storageBucket: 'my-qr-creator-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDUF5Z3FDsjWJEjqlw29iwO2sloUtJiqIw',
    appId: '1:330478696994:android:92a8a18d3abed46b0b287b',
    messagingSenderId: '330478696994',
    projectId: 'my-qr-creator-app',
    storageBucket: 'my-qr-creator-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDsZFhk2iTx9wiYI4-hX_0FhKrf36V6RVs',
    appId: '1:330478696994:ios:d61b478e91918d9d0b287b',
    messagingSenderId: '330478696994',
    projectId: 'my-qr-creator-app',
    storageBucket: 'my-qr-creator-app.appspot.com',
    iosBundleId: 'com.example.qrCreator',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDsZFhk2iTx9wiYI4-hX_0FhKrf36V6RVs',
    appId: '1:330478696994:ios:daf23f1457d1ced10b287b',
    messagingSenderId: '330478696994',
    projectId: 'my-qr-creator-app',
    storageBucket: 'my-qr-creator-app.appspot.com',
    iosBundleId: 'com.example.qrCreator.RunnerTests',
  );
}
