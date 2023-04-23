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
    apiKey: 'AIzaSyBfkknBqYhrdV71RC8L2xoS4xjFfFGgBt8',
    appId: '1:606248872773:web:b020778d9f562b11e06c2c',
    messagingSenderId: '606248872773',
    projectId: 'chat-app-3987f',
    authDomain: 'chat-app-3987f.firebaseapp.com',
    storageBucket: 'chat-app-3987f.appspot.com',
    measurementId: 'G-QQMR0PF8VN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBOIhujMZpHygYDWfW0ml-cQtbk32uzDqo',
    appId: '1:606248872773:android:f9e643687ecaec5fe06c2c',
    messagingSenderId: '606248872773',
    projectId: 'chat-app-3987f',
    storageBucket: 'chat-app-3987f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJtEVVqsDD_7bywuUbB8G_FQ2iXUDGHGU',
    appId: '1:606248872773:ios:05fd1af937dc4eece06c2c',
    messagingSenderId: '606248872773',
    projectId: 'chat-app-3987f',
    storageBucket: 'chat-app-3987f.appspot.com',
    iosClientId: '606248872773-njnj4c06v6gc56ig0b1jskhkq7tbrfe7.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBJtEVVqsDD_7bywuUbB8G_FQ2iXUDGHGU',
    appId: '1:606248872773:ios:05fd1af937dc4eece06c2c',
    messagingSenderId: '606248872773',
    projectId: 'chat-app-3987f',
    storageBucket: 'chat-app-3987f.appspot.com',
    iosClientId: '606248872773-njnj4c06v6gc56ig0b1jskhkq7tbrfe7.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );
}
