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
    apiKey: 'AIzaSyCxhfki6fkE4RQ_uA6VvcENHu4pWnD09F4',
    appId: '1:94056378691:web:6360d607e728f2dcebfff6',
    messagingSenderId: '94056378691',
    projectId: 'chat-app2-9e1f2',
    authDomain: 'chat-app2-9e1f2.firebaseapp.com',
    storageBucket: 'chat-app2-9e1f2.appspot.com',
    measurementId: 'G-2ZXQKQ2HZX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCrBai-gA4a46qQZrlWMBSfj8xoTPdPfOA',
    appId: '1:94056378691:android:a668850f67fc9d1febfff6',
    messagingSenderId: '94056378691',
    projectId: 'chat-app2-9e1f2',
    storageBucket: 'chat-app2-9e1f2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCdZEBEw-EbwKA_8OT0sgSkOqWjd2GrQtY',
    appId: '1:94056378691:ios:2b54732ab39d7853ebfff6',
    messagingSenderId: '94056378691',
    projectId: 'chat-app2-9e1f2',
    storageBucket: 'chat-app2-9e1f2.appspot.com',
    iosBundleId: 'com.example.chatapp2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCdZEBEw-EbwKA_8OT0sgSkOqWjd2GrQtY',
    appId: '1:94056378691:ios:78c92a0847e520beebfff6',
    messagingSenderId: '94056378691',
    projectId: 'chat-app2-9e1f2',
    storageBucket: 'chat-app2-9e1f2.appspot.com',
    iosBundleId: 'com.example.chatapp2.RunnerTests',
  );
}
