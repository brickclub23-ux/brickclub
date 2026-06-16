import 'auth_credentials.dart';

abstract interface class AuthRepository {
  Future<void> signIn(SignInCredentials credentials);

  Future<void> createAccount(SignUpCredentials credentials);

  Future<void> sendPasswordResetEmail(String email);

  Future<void> signOut();
}
