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
    apiKey: 'AIzaSyAHpB0q_cH82iH-lJJrGCsiW8O1O1sxTEA',
    appId: '1:571934156463:web:c0d6d9f52618548fef165a',
    messagingSenderId: '571934156463',
    projectId: 'asasa-ba607',
    authDomain: 'asasa-ba607.firebaseapp.com',
    storageBucket: 'asasa-ba607.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC-Ph_Glx-k_IWPbO2DkpS0-aGyMKOR9Ao',
    appId: '1:571934156463:android:f2bf5765dd998484ef165a',
    messagingSenderId: '571934156463',
    projectId: 'asasa-ba607',
    storageBucket: 'asasa-ba607.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC7ubhvEgrBjSHzCTjZkoZv5xZSTnoypTY',
    appId: '1:571934156463:ios:69d22fd38fbf9698ef165a',
    messagingSenderId: '571934156463',
    projectId: 'asasa-ba607',
    storageBucket: 'asasa-ba607.appspot.com',
    iosClientId: '571934156463-q7b7pi2o8ojt2c7709kkfjaqpspcskfn.apps.googleusercontent.com',
    iosBundleId: 'com.example.nou',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC7ubhvEgrBjSHzCTjZkoZv5xZSTnoypTY',
    appId: '1:571934156463:ios:69d22fd38fbf9698ef165a',
    messagingSenderId: '571934156463',
    projectId: 'asasa-ba607',
    storageBucket: 'asasa-ba607.appspot.com',
    iosClientId: '571934156463-q7b7pi2o8ojt2c7709kkfjaqpspcskfn.apps.googleusercontent.com',
    iosBundleId: 'com.example.nou',
  );
}
