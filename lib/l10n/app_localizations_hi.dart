// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'BrickClub';

  @override
  String get profileLanguage => 'भाषा';

  @override
  String get languageScreenTitle => 'भाषा';

  @override
  String get languageHeading => 'प्रदर्शन भाषा';

  @override
  String get languageDescription =>
      'इस डिवाइस पर BrickClub द्वारा उपयोग की जाने वाली भाषा चुनें।';

  @override
  String get languageSystemDefault => 'सिस्टम डिफ़ॉल्ट';

  @override
  String get commonEmail => 'ईमेल';

  @override
  String get commonEmailHint => 'you@example.com';

  @override
  String get commonPassword => 'पासवर्ड';

  @override
  String get authConnecting => 'कनेक्ट हो रहा है…';

  @override
  String get signInWelcomeTitle => 'वापसी पर स्वागत है';

  @override
  String get signInAdminTitle => 'एडमिन साइन इन';

  @override
  String get signInMemberSubtitle =>
      'अपने BrickShares पोर्टफ़ोलियो पर जारी रखें।';

  @override
  String get signInAdminSubtitle =>
      'उपयोगकर्ता, संपत्ति और क्रिप्टो भुगतान संचालन तक पहुँचें।';

  @override
  String get signInPasswordHint => 'अपना पासवर्ड दर्ज करें';

  @override
  String get signInForgotPassword => 'पासवर्ड भूल गए?';

  @override
  String get signInProgress => 'साइन इन हो रहा है…';

  @override
  String get signInOpenAdminDashboard => 'एडमिन डैशबोर्ड खोलें';

  @override
  String get signInSubmit => 'सुरक्षित रूप से साइन इन करें';

  @override
  String get signInGoogleAdmin => 'Google के साथ एडमिन के रूप में जारी रखें';

  @override
  String get signInGoogle => 'Google के साथ जारी रखें';

  @override
  String get signInPhone => 'फ़ोन के साथ जारी रखें';

  @override
  String get signInUseMember => 'सदस्य साइन इन का उपयोग करें';

  @override
  String get signInUseAdmin => 'एडमिन के रूप में साइन इन करें';

  @override
  String get signInCreateAccount => 'BrickClub खाता बनाएँ';

  @override
  String get signInGoogleNoAdmin =>
      'इस Google खाते के पास एडमिन एक्सेस नहीं है।';

  @override
  String get signInNoAdmin => 'इस खाते के पास एडमिन एक्सेस नहीं है।';

  @override
  String get signInResetSent => 'पासवर्ड रीसेट निर्देश भेज दिए गए';

  @override
  String get signInStoryTitle => 'स्वामित्व, अब\nऔर भी सुलभ।';

  @override
  String get signInStoryBody =>
      'सत्यापित अवसरों की समीक्षा करें, आत्मविश्वास के साथ निपटान करें, और हर संपत्ति पर नज़र रखें।';

  @override
  String get signUpIntro =>
      'अपना BrickShares खाता बनाएँ। इसके बाद वॉलेट सत्यापन और KYC आता है।';

  @override
  String get signUpCreateAccount => 'खाता बनाएँ';

  @override
  String get signUpLegalNamesHint =>
      'अपने कानूनी नाम ठीक वैसे ही दर्ज करें जैसे वे आपके पहचान-पत्र पर हैं।';

  @override
  String get signUpFirstName => 'पहला नाम';

  @override
  String get signUpFirstNameHint => 'कानूनी पहला नाम';

  @override
  String get signUpLastName => 'उपनाम';

  @override
  String get signUpLastNameHint => 'कानूनी उपनाम';

  @override
  String get signUpPasswordHint => 'एक पासवर्ड बनाएँ';

  @override
  String get signUpConfirmPassword => 'पासवर्ड की पुष्टि करें';

  @override
  String get signUpConfirmPasswordHint => 'अपने पासवर्ड की पुष्टि करें';

  @override
  String get signUpAgree =>
      'मैं नियमों, जोखिम प्रकटीकरण और निपटान पुष्टिकरण सूचनाओं से सहमत हूँ।';

  @override
  String get signUpProgress => 'खाता बन रहा है…';

  @override
  String get signUpGoogle => 'Google के साथ साइन अप करें';

  @override
  String get signUpDisclosure =>
      'खाता बनाने के बाद वित्तीय कार्यों के लिए KYC और सत्यापित वॉलेट सेटअप आवश्यक है।';

  @override
  String get signUpHaveAccount => 'पहले से खाता है? साइन इन करें';

  @override
  String get phoneTitle => 'फ़ोन से साइन इन करें';

  @override
  String get phoneOtpTitle => 'सत्यापन कोड दर्ज करें';

  @override
  String get phoneSubtitle =>
      'देश कोड के साथ अपना फ़ोन नंबर दर्ज करें (जैसे +1 415 555 2671)।';

  @override
  String phoneOtpSubtitle(String phone) {
    return 'हमने $phone पर 6 अंकों का कोड भेजा है।';
  }

  @override
  String get phoneHint => '+1 415 555 2671';

  @override
  String get phoneCodeHint => '000000';

  @override
  String get phoneSendingCode => 'कोड भेजा जा रहा है…';

  @override
  String get phoneSendCode => 'सत्यापन कोड भेजें';

  @override
  String get phoneVerifying => 'सत्यापित किया जा रहा है…';

  @override
  String get phoneConfirmCode => 'कोड की पुष्टि करें';

  @override
  String get phoneUseDifferentNumber => 'दूसरा नंबर उपयोग करें';
}
