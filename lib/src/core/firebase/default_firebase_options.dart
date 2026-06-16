import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  const DefaultFirebaseOptions._();

  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return ios;
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        return web;
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'demo-api-key',
    appId: '1:123456789:web:brickclubdev',
    messagingSenderId: '123456789',
    projectId: 'brickclub-dev',
    authDomain: 'brickclub-dev.firebaseapp.com',
    storageBucket: 'brickclub-dev.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'demo-api-key',
    appId: '1:123456789:android:brickclubdev',
    messagingSenderId: '123456789',
    projectId: 'brickclub-dev',
    storageBucket: 'brickclub-dev.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'demo-api-key',
    appId: '1:123456789:ios:brickclubdev',
    messagingSenderId: '123456789',
    projectId: 'brickclub-dev',
    iosBundleId: 'com.example.brickclub',
    storageBucket: 'brickclub-dev.appspot.com',
  );
}
