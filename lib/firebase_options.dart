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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB2KzHojDM6AEmaSlnHsqVTS40mvssFOQo',
    appId: '1:49021389415:web:3d558db358c0e6924ea2c2',
    messagingSenderId: '49021389415',
    projectId: 'kobermart2022',
    authDomain: 'kobermart2022.firebaseapp.com',
    storageBucket: 'kobermart2022.appspot.com',
    measurementId: 'G-ZLSEVT4KB2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBRdZWPmlOjenl_bIvOSw8W6ZCb2QuTOZo',
    appId: '1:49021389415:android:28939c384f276b3e4ea2c2',
    messagingSenderId: '49021389415',
    projectId: 'kobermart2022',
    storageBucket: 'kobermart2022.appspot.com',
  );
}
