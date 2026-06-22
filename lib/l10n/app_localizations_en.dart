// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'BrickClub';

  @override
  String get profileLanguage => 'Language';

  @override
  String get languageScreenTitle => 'Language';

  @override
  String get languageHeading => 'Display language';

  @override
  String get languageDescription =>
      'Choose the language BrickClub uses on this device.';

  @override
  String get languageSystemDefault => 'System default';

  @override
  String get commonEmail => 'Email';

  @override
  String get commonEmailHint => 'you@example.com';

  @override
  String get commonPassword => 'Password';

  @override
  String get authConnecting => 'Connecting...';

  @override
  String get signInWelcomeTitle => 'Welcome back';

  @override
  String get signInAdminTitle => 'Admin sign in';

  @override
  String get signInMemberSubtitle => 'Continue to your BrickShares portfolio.';

  @override
  String get signInAdminSubtitle =>
      'Access user, asset, and crypto payment operations.';

  @override
  String get signInPasswordHint => 'Enter your password';

  @override
  String get signInForgotPassword => 'Forgot password?';

  @override
  String get signInProgress => 'Signing in...';

  @override
  String get signInOpenAdminDashboard => 'Open admin dashboard';

  @override
  String get signInSubmit => 'Sign in securely';

  @override
  String get signInGoogleAdmin => 'Continue as admin with Google';

  @override
  String get signInGoogle => 'Continue with Google';

  @override
  String get signInPhone => 'Continue with phone';

  @override
  String get signInUseMember => 'Use member sign in';

  @override
  String get signInUseAdmin => 'Sign in as an admin';

  @override
  String get signInCreateAccount => 'Create a BrickClub account';

  @override
  String get signInGoogleNoAdmin =>
      'This Google account does not have admin access.';

  @override
  String get signInNoAdmin => 'This account does not have admin access.';

  @override
  String get signInResetSent => 'Password reset instructions sent';

  @override
  String get signInStoryTitle => 'Ownership, made\nmore accessible.';

  @override
  String get signInStoryBody =>
      'Review verified opportunities, settle with confidence, and keep every asset in view.';

  @override
  String get signUpIntro =>
      'Create your BrickShares account. Wallet verification and KYC come next.';

  @override
  String get signUpCreateAccount => 'Create account';

  @override
  String get signUpLegalNamesHint =>
      'Use your legal names exactly as they appear on your ID.';

  @override
  String get signUpFirstName => 'First name';

  @override
  String get signUpFirstNameHint => 'Legal first name';

  @override
  String get signUpLastName => 'Last name';

  @override
  String get signUpLastNameHint => 'Legal last name';

  @override
  String get signUpPasswordHint => 'Create a password';

  @override
  String get signUpConfirmPassword => 'Confirm password';

  @override
  String get signUpConfirmPasswordHint => 'Confirm your password';

  @override
  String get signUpAgree =>
      'I agree to terms, risk disclosures, and settlement confirmation notices.';

  @override
  String get signUpProgress => 'Creating account...';

  @override
  String get signUpGoogle => 'Sign up with Google';

  @override
  String get signUpDisclosure =>
      'Financial actions require KYC and verified wallet setup after account creation.';

  @override
  String get signUpHaveAccount => 'Already have an account? Sign in';

  @override
  String get phoneTitle => 'Sign in with phone';

  @override
  String get phoneOtpTitle => 'Enter verification code';

  @override
  String get phoneSubtitle =>
      'Enter your phone number with country code (e.g. +1 415 555 2671).';

  @override
  String phoneOtpSubtitle(String phone) {
    return 'We sent a 6-digit code to $phone.';
  }

  @override
  String get phoneHint => '+1 415 555 2671';

  @override
  String get phoneCodeHint => '000000';

  @override
  String get phoneSendingCode => 'Sending code…';

  @override
  String get phoneSendCode => 'Send verification code';

  @override
  String get phoneVerifying => 'Verifying…';

  @override
  String get phoneConfirmCode => 'Confirm code';

  @override
  String get phoneUseDifferentNumber => 'Use a different number';
}
