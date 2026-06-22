// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class AppLocalizationsSw extends AppLocalizations {
  AppLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get appTitle => 'BrickClub';

  @override
  String get profileLanguage => 'Lugha';

  @override
  String get languageScreenTitle => 'Lugha';

  @override
  String get languageHeading => 'Lugha ya kuonyesha';

  @override
  String get languageDescription =>
      'Chagua lugha ambayo BrickClub hutumia kwenye kifaa hiki.';

  @override
  String get languageSystemDefault => 'Chaguomsingi la mfumo';

  @override
  String get commonEmail => 'Barua pepe';

  @override
  String get commonEmailHint => 'wewe@mfano.com';

  @override
  String get commonPassword => 'Nenosiri';

  @override
  String get authConnecting => 'Inaunganisha…';

  @override
  String get signInWelcomeTitle => 'Karibu tena';

  @override
  String get signInAdminTitle => 'Kuingia kwa msimamizi';

  @override
  String get signInMemberSubtitle =>
      'Endelea kwenye kasha lako la BrickShares.';

  @override
  String get signInAdminSubtitle =>
      'Fikia shughuli za watumiaji, mali na malipo ya sarafu-fiche.';

  @override
  String get signInPasswordHint => 'Weka nenosiri lako';

  @override
  String get signInForgotPassword => 'Umesahau nenosiri?';

  @override
  String get signInProgress => 'Inaingia…';

  @override
  String get signInOpenAdminDashboard => 'Fungua dashibodi ya msimamizi';

  @override
  String get signInSubmit => 'Ingia kwa usalama';

  @override
  String get signInGoogleAdmin => 'Endelea kama msimamizi kwa Google';

  @override
  String get signInGoogle => 'Endelea na Google';

  @override
  String get signInPhone => 'Endelea na simu';

  @override
  String get signInUseMember => 'Tumia kuingia kwa mwanachama';

  @override
  String get signInUseAdmin => 'Ingia kama msimamizi';

  @override
  String get signInCreateAccount => 'Fungua akaunti ya BrickClub';

  @override
  String get signInGoogleNoAdmin =>
      'Akaunti hii ya Google haina ufikiaji wa msimamizi.';

  @override
  String get signInNoAdmin => 'Akaunti hii haina ufikiaji wa msimamizi.';

  @override
  String get signInResetSent => 'Maelekezo ya kuweka upya nenosiri yametumwa';

  @override
  String get signInStoryTitle => 'Umiliki, sasa\nunapatikana zaidi.';

  @override
  String get signInStoryBody =>
      'Kagua fursa zilizothibitishwa, lipa kwa uhakika, na uweke kila mali mbele ya macho yako.';

  @override
  String get signUpIntro =>
      'Fungua akaunti yako ya BrickShares. Uthibitishaji wa kasha na KYC vinafuata.';

  @override
  String get signUpCreateAccount => 'Fungua akaunti';

  @override
  String get signUpLegalNamesHint =>
      'Tumia majina yako rasmi kama yanavyoonekana kwenye kitambulisho chako.';

  @override
  String get signUpFirstName => 'Jina la kwanza';

  @override
  String get signUpFirstNameHint => 'Jina rasmi la kwanza';

  @override
  String get signUpLastName => 'Jina la ukoo';

  @override
  String get signUpLastNameHint => 'Jina rasmi la ukoo';

  @override
  String get signUpPasswordHint => 'Tengeneza nenosiri';

  @override
  String get signUpConfirmPassword => 'Thibitisha nenosiri';

  @override
  String get signUpConfirmPasswordHint => 'Thibitisha nenosiri lako';

  @override
  String get signUpAgree =>
      'Ninakubali masharti, ufichuzi wa hatari, na arifa za uthibitisho wa malipo.';

  @override
  String get signUpProgress => 'Inafungua akaunti…';

  @override
  String get signUpGoogle => 'Jisajili na Google';

  @override
  String get signUpDisclosure =>
      'Shughuli za kifedha zinahitaji KYC na usanidi wa kasha lililothibitishwa baada ya kufungua akaunti.';

  @override
  String get signUpHaveAccount => 'Tayari una akaunti? Ingia';

  @override
  String get phoneTitle => 'Ingia kwa simu';

  @override
  String get phoneOtpTitle => 'Weka msimbo wa uthibitisho';

  @override
  String get phoneSubtitle =>
      'Weka nambari yako ya simu na msimbo wa nchi (mf. +1 415 555 2671).';

  @override
  String phoneOtpSubtitle(String phone) {
    return 'Tumetuma msimbo wa tarakimu 6 kwa $phone.';
  }

  @override
  String get phoneHint => '+1 415 555 2671';

  @override
  String get phoneCodeHint => '000000';

  @override
  String get phoneSendingCode => 'Inatuma msimbo…';

  @override
  String get phoneSendCode => 'Tuma msimbo wa uthibitisho';

  @override
  String get phoneVerifying => 'Inathibitisha…';

  @override
  String get phoneConfirmCode => 'Thibitisha msimbo';

  @override
  String get phoneUseDifferentNumber => 'Tumia nambari nyingine';
}
