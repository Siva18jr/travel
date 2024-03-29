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
    apiKey: 'AIzaSyD1sJXDMuvdP_cGDVkwnbmUFIP2kPOiVwg',
    appId: '1:851722716180:web:766e58eba2107dc5be9301',
    messagingSenderId: '851722716180',
    projectId: 'fran-e8add',
    authDomain: 'fran-e8add.firebaseapp.com',
    storageBucket: 'fran-e8add.appspot.com',
    measurementId: 'G-1KKS5Y844K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA8qRS2v3_fF8TvJ0LXiH9d_HUxIpcDWUw',
    appId: '1:851722716180:android:8bc00bc7da241127be9301',
    messagingSenderId: '851722716180',
    projectId: 'fran-e8add',
    storageBucket: 'fran-e8add.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA2HF3C22JlvOm-QR0wCFjVEyIqo-0jUHM',
    appId: '1:851722716180:ios:c5800b7d6dd64de3be9301',
    messagingSenderId: '851722716180',
    projectId: 'fran-e8add',
    storageBucket: 'fran-e8add.appspot.com',
    iosBundleId: 'com.feline.levitate',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA2HF3C22JlvOm-QR0wCFjVEyIqo-0jUHM',
    appId: '1:851722716180:ios:3c7c5f18f8643ee1be9301',
    messagingSenderId: '851722716180',
    projectId: 'fran-e8add',
    storageBucket: 'fran-e8add.appspot.com',
    iosBundleId: 'com.feline.levitate.RunnerTests',
  );
}
