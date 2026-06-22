import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sw.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('es'),
    Locale('hi'),
    Locale('it'),
    Locale('ru'),
    Locale('sw'),
    Locale('zh'),
  ];

  /// Application name, shown as the app title.
  ///
  /// In en, this message translates to:
  /// **'BrickClub'**
  String get appTitle;

  /// Label for the language row in the profile settings list.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileLanguage;

  /// App bar title of the language selection screen.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageScreenTitle;

  /// Heading on the language selection screen.
  ///
  /// In en, this message translates to:
  /// **'Display language'**
  String get languageHeading;

  /// Subtitle explaining what the language setting does.
  ///
  /// In en, this message translates to:
  /// **'Choose the language BrickClub uses on this device.'**
  String get languageDescription;

  /// Option that follows the device's language automatically.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get languageSystemDefault;

  /// Label for an email address input field.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get commonEmail;

  /// Placeholder shown inside an email input field.
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get commonEmailHint;

  /// Label for a password input field.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get commonPassword;

  /// Button label while a Google sign-in/sign-up is in progress.
  ///
  /// In en, this message translates to:
  /// **'Connecting...'**
  String get authConnecting;

  /// Sign-in heading shown to members.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get signInWelcomeTitle;

  /// Sign-in heading shown when admin access is toggled on.
  ///
  /// In en, this message translates to:
  /// **'Admin sign in'**
  String get signInAdminTitle;

  /// Sign-in subtitle shown to members.
  ///
  /// In en, this message translates to:
  /// **'Continue to your BrickShares portfolio.'**
  String get signInMemberSubtitle;

  /// Sign-in subtitle shown when admin access is toggled on.
  ///
  /// In en, this message translates to:
  /// **'Access user, asset, and crypto payment operations.'**
  String get signInAdminSubtitle;

  /// Placeholder for the password field on the sign-in screen.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get signInPasswordHint;

  /// Link that triggers a password reset email.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get signInForgotPassword;

  /// Sign-in button label while signing in.
  ///
  /// In en, this message translates to:
  /// **'Signing in...'**
  String get signInProgress;

  /// Sign-in submit button label in admin mode.
  ///
  /// In en, this message translates to:
  /// **'Open admin dashboard'**
  String get signInOpenAdminDashboard;

  /// Sign-in submit button label in member mode.
  ///
  /// In en, this message translates to:
  /// **'Sign in securely'**
  String get signInSubmit;

  /// Google sign-in button label in admin mode.
  ///
  /// In en, this message translates to:
  /// **'Continue as admin with Google'**
  String get signInGoogleAdmin;

  /// Google sign-in button label in member mode.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get signInGoogle;

  /// Button that opens the phone sign-in sheet.
  ///
  /// In en, this message translates to:
  /// **'Continue with phone'**
  String get signInPhone;

  /// Toggle to switch from admin sign-in back to member sign-in.
  ///
  /// In en, this message translates to:
  /// **'Use member sign in'**
  String get signInUseMember;

  /// Toggle to switch to admin sign-in.
  ///
  /// In en, this message translates to:
  /// **'Sign in as an admin'**
  String get signInUseAdmin;

  /// Link from the sign-in screen to account creation.
  ///
  /// In en, this message translates to:
  /// **'Create a BrickClub account'**
  String get signInCreateAccount;

  /// Error when a Google account lacks admin access.
  ///
  /// In en, this message translates to:
  /// **'This Google account does not have admin access.'**
  String get signInGoogleNoAdmin;

  /// Error when an email account lacks admin access.
  ///
  /// In en, this message translates to:
  /// **'This account does not have admin access.'**
  String get signInNoAdmin;

  /// Confirmation after a password reset email is sent.
  ///
  /// In en, this message translates to:
  /// **'Password reset instructions sent'**
  String get signInResetSent;

  /// Marketing headline on the wide sign-in side panel.
  ///
  /// In en, this message translates to:
  /// **'Ownership, made\nmore accessible.'**
  String get signInStoryTitle;

  /// Marketing body text on the wide sign-in side panel.
  ///
  /// In en, this message translates to:
  /// **'Review verified opportunities, settle with confidence, and keep every asset in view.'**
  String get signInStoryBody;

  /// Intro text at the top of the sign-up screen.
  ///
  /// In en, this message translates to:
  /// **'Create your BrickShares account. Wallet verification and KYC come next.'**
  String get signUpIntro;

  /// Sign-up panel title and submit button label.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get signUpCreateAccount;

  /// Guidance under the Create account panel title.
  ///
  /// In en, this message translates to:
  /// **'Use your legal names exactly as they appear on your ID.'**
  String get signUpLegalNamesHint;

  /// Label for the first name field.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get signUpFirstName;

  /// Placeholder for the first name field.
  ///
  /// In en, this message translates to:
  /// **'Legal first name'**
  String get signUpFirstNameHint;

  /// Label for the last name field.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get signUpLastName;

  /// Placeholder for the last name field.
  ///
  /// In en, this message translates to:
  /// **'Legal last name'**
  String get signUpLastNameHint;

  /// Placeholder for the password field on sign-up.
  ///
  /// In en, this message translates to:
  /// **'Create a password'**
  String get signUpPasswordHint;

  /// Label for the confirm password field.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get signUpConfirmPassword;

  /// Placeholder for the confirm password field.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get signUpConfirmPasswordHint;

  /// Consent checkbox label on sign-up.
  ///
  /// In en, this message translates to:
  /// **'I agree to terms, risk disclosures, and settlement confirmation notices.'**
  String get signUpAgree;

  /// Submit button label while the account is being created.
  ///
  /// In en, this message translates to:
  /// **'Creating account...'**
  String get signUpProgress;

  /// Google sign-up button label.
  ///
  /// In en, this message translates to:
  /// **'Sign up with Google'**
  String get signUpGoogle;

  /// Disclosure text near the bottom of the sign-up screen.
  ///
  /// In en, this message translates to:
  /// **'Financial actions require KYC and verified wallet setup after account creation.'**
  String get signUpDisclosure;

  /// Link from sign-up back to sign-in.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign in'**
  String get signUpHaveAccount;

  /// Title of the phone sign-in sheet (number step).
  ///
  /// In en, this message translates to:
  /// **'Sign in with phone'**
  String get phoneTitle;

  /// Title of the phone sign-in sheet (code step).
  ///
  /// In en, this message translates to:
  /// **'Enter verification code'**
  String get phoneOtpTitle;

  /// Instruction on the phone number step.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number with country code (e.g. +1 415 555 2671).'**
  String get phoneSubtitle;

  /// Instruction on the code step, naming the destination number.
  ///
  /// In en, this message translates to:
  /// **'We sent a 6-digit code to {phone}.'**
  String phoneOtpSubtitle(String phone);

  /// Placeholder for the phone number field.
  ///
  /// In en, this message translates to:
  /// **'+1 415 555 2671'**
  String get phoneHint;

  /// Placeholder for the verification code field.
  ///
  /// In en, this message translates to:
  /// **'000000'**
  String get phoneCodeHint;

  /// Button label while the SMS code is being sent.
  ///
  /// In en, this message translates to:
  /// **'Sending code…'**
  String get phoneSendingCode;

  /// Button that requests an SMS verification code.
  ///
  /// In en, this message translates to:
  /// **'Send verification code'**
  String get phoneSendCode;

  /// Button label while the code is being verified.
  ///
  /// In en, this message translates to:
  /// **'Verifying…'**
  String get phoneVerifying;

  /// Button that submits the verification code.
  ///
  /// In en, this message translates to:
  /// **'Confirm code'**
  String get phoneConfirmCode;

  /// Link to return to the phone number step.
  ///
  /// In en, this message translates to:
  /// **'Use a different number'**
  String get phoneUseDifferentNumber;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'en',
    'es',
    'hi',
    'it',
    'ru',
    'sw',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'hi':
      return AppLocalizationsHi();
    case 'it':
      return AppLocalizationsIt();
    case 'ru':
      return AppLocalizationsRu();
    case 'sw':
      return AppLocalizationsSw();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
