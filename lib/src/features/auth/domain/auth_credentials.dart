class SignInCredentials {
  const SignInCredentials({required this.email, required this.password});

  final String email;
  final String password;
}

class SignUpCredentials {
  const SignUpCredentials({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
}
