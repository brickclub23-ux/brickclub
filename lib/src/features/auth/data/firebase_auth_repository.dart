import 'package:firebase_auth/firebase_auth.dart';

import '../domain/auth_credentials.dart';
import '../domain/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  @override
  Future<void> signIn(SignInCredentials credentials) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: credentials.email.trim(),
      password: credentials.password,
    );
  }

  @override
  Future<void> createAccount(SignUpCredentials credentials) async {
    if (credentials.password != credentials.confirmPassword) {
      throw const AuthValidationException('Passwords do not match');
    }

    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: credentials.email.trim(),
      password: credentials.password,
    );

    await userCredential.user?.updateDisplayName(
      '${credentials.firstName.trim()} ${credentials.lastName.trim()}'.trim(),
    );
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return _firebaseAuth.sendPasswordResetEmail(email: email.trim());
  }

  @override
  Future<void> signOut() => _firebaseAuth.signOut();
}

class AuthValidationException implements Exception {
  const AuthValidationException(this.message);

  final String message;
}
