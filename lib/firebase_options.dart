//FICHEIRO DE CONFIGURAÇÃO DO FIRESTORE

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
    apiKey: 'AIzaSyDXIXMu7V_v2IQds1Wykp6pTRwloLA2IdY',
    appId: '1:988448113756:web:81b0c4cf74ec31f0f59299',
    messagingSenderId: '988448113756',
    projectId: 'ligaportugal',
    authDomain: 'ligaportugal.firebaseapp.com',
    storageBucket: 'ligaportugal.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAIDUPGz8hy6jemtP9aAJ40JPSR7avz5zw',
    appId: '1:988448113756:android:09e6d3847043b57bf59299',
    messagingSenderId: '988448113756',
    projectId: 'ligaportugal',
    storageBucket: 'ligaportugal.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyASJqiOUx-by-obgZe1ZH2-wgG7rQNUG70',
    appId: '1:988448113756:ios:2371ee6ee4115218f59299',
    messagingSenderId: '988448113756',
    projectId: 'ligaportugal',
    storageBucket: 'ligaportugal.appspot.com',
    iosClientId: '988448113756-qaq2hitd03pa6st5pg085u154vpuk4im.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyASJqiOUx-by-obgZe1ZH2-wgG7rQNUG70',
    appId: '1:988448113756:ios:2371ee6ee4115218f59299',
    messagingSenderId: '988448113756',
    projectId: 'ligaportugal',
    storageBucket: 'ligaportugal.appspot.com',
    iosClientId: '988448113756-qaq2hitd03pa6st5pg085u154vpuk4im.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );
}
