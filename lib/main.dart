import 'package:flutter/widgets.dart';

import 'src/app/brickclub_app.dart';
import 'src/core/firebase/firebase_bootstrap.dart';
import 'src/features/auth/data/firebase_auth_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseBootstrap.initialize();

  runApp(BrickClubApp(authRepository: FirebaseAuthRepository()));
}
