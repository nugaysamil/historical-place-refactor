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
    apiKey: 'AIzaSyDNsaTca7OtWcqvffhnxAmoOdL37PKJdEQ',
    appId: '1:205275922876:web:3bb23f04bd2ba33c172bb9',
    messagingSenderId: '205275922876',
    projectId: 'newhistorical-b4f75',
    authDomain: 'newhistorical-b4f75.firebaseapp.com',
    storageBucket: 'newhistorical-b4f75.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBrhaQ1kI-LR8nDunXL3mJBL3yh9tUQNIE',
    appId: '1:205275922876:android:1837fae086ece207172bb9',
    messagingSenderId: '205275922876',
    projectId: 'newhistorical-b4f75',
    storageBucket: 'newhistorical-b4f75.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBtFbKA2D-BEEy3UAWg66kxXr6c5rIvLQA',
    appId: '1:205275922876:ios:5d6a5e5745edaef1172bb9',
    messagingSenderId: '205275922876',
    projectId: 'newhistorical-b4f75',
    storageBucket: 'newhistorical-b4f75.appspot.com',
    androidClientId: '205275922876-1u5tiqtfdgj7nvotjh03483ebqc4k8l3.apps.googleusercontent.com',
    iosClientId: '205275922876-8qmrctl7okavfhpham2i7cp80110mh11.apps.googleusercontent.com',
    iosBundleId: 'com.samil_nugayy.mapsuygulama',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBtFbKA2D-BEEy3UAWg66kxXr6c5rIvLQA',
    appId: '1:205275922876:ios:5d6a5e5745edaef1172bb9',
    messagingSenderId: '205275922876',
    projectId: 'newhistorical-b4f75',
    storageBucket: 'newhistorical-b4f75.appspot.com',
    androidClientId: '205275922876-1u5tiqtfdgj7nvotjh03483ebqc4k8l3.apps.googleusercontent.com',
    iosClientId: '205275922876-8qmrctl7okavfhpham2i7cp80110mh11.apps.googleusercontent.com',
    iosBundleId: 'com.samil_nugayy.mapsuygulama',
  );
}
