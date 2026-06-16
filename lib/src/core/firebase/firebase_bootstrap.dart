import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'default_firebase_options.dart';

class FirebaseBootstrap {
  const FirebaseBootstrap._();

  static const bool useEmulators = bool.fromEnvironment(
    'USE_FIREBASE_EMULATORS',
    defaultValue: kDebugMode,
  );

  static const String emulatorHostOverride = String.fromEnvironment(
    'FIREBASE_EMULATOR_HOST',
  );

  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if (useEmulators) {
      await _connectEmulators();
    }
  }

  static Future<void> _connectEmulators() async {
    final host = emulatorHostOverride.isNotEmpty
        ? emulatorHostOverride
        : _defaultHost;

    await FirebaseAuth.instance.useAuthEmulator(host, 9099);
    FirebaseFunctions.instance.useFunctionsEmulator(host, 5001);
  }

  static String get _defaultHost {
    if (kIsWeb) {
      return 'localhost';
    }

    return switch (defaultTargetPlatform) {
      TargetPlatform.android => '10.0.2.2',
      _ => 'localhost',
    };
  }
}
