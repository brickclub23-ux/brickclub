// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'BrickClub';

  @override
  String get profileLanguage => 'Lingua';

  @override
  String get languageScreenTitle => 'Lingua';

  @override
  String get languageHeading => 'Lingua di visualizzazione';

  @override
  String get languageDescription =>
      'Scegli la lingua che BrickClub usa su questo dispositivo.';

  @override
  String get languageSystemDefault => 'Predefinito di sistema';

  @override
  String get commonEmail => 'Email';

  @override
  String get commonEmailHint => 'tu@esempio.com';

  @override
  String get commonPassword => 'Password';

  @override
  String get authConnecting => 'Connessione…';

  @override
  String get signInWelcomeTitle => 'Bentornato';

  @override
  String get signInAdminTitle => 'Accesso amministratore';

  @override
  String get signInMemberSubtitle =>
      'Continua verso il tuo portafoglio BrickShares.';

  @override
  String get signInAdminSubtitle =>
      'Accedi alle operazioni su utenti, asset e pagamenti in cripto.';

  @override
  String get signInPasswordHint => 'Inserisci la tua password';

  @override
  String get signInForgotPassword => 'Password dimenticata?';

  @override
  String get signInProgress => 'Accesso in corso…';

  @override
  String get signInOpenAdminDashboard => 'Apri la dashboard amministratore';

  @override
  String get signInSubmit => 'Accedi in modo sicuro';

  @override
  String get signInGoogleAdmin => 'Continua come amministratore con Google';

  @override
  String get signInGoogle => 'Continua con Google';

  @override
  String get signInPhone => 'Continua con il telefono';

  @override
  String get signInUseMember => 'Usa l\'accesso membro';

  @override
  String get signInUseAdmin => 'Accedi come amministratore';

  @override
  String get signInCreateAccount => 'Crea un account BrickClub';

  @override
  String get signInGoogleNoAdmin =>
      'Questo account Google non dispone dell\'accesso amministratore.';

  @override
  String get signInNoAdmin =>
      'Questo account non dispone dell\'accesso amministratore.';

  @override
  String get signInResetSent =>
      'Istruzioni per la reimpostazione della password inviate';

  @override
  String get signInStoryTitle => 'La proprietà, resa\npiù accessibile.';

  @override
  String get signInStoryBody =>
      'Esamina opportunità verificate, regola con sicurezza e tieni d\'occhio ogni asset.';

  @override
  String get signUpIntro =>
      'Crea il tuo account BrickShares. La verifica del portafoglio e il KYC arrivano subito dopo.';

  @override
  String get signUpCreateAccount => 'Crea account';

  @override
  String get signUpLegalNamesHint =>
      'Usa i tuoi nomi legali esattamente come compaiono sul documento d\'identità.';

  @override
  String get signUpFirstName => 'Nome';

  @override
  String get signUpFirstNameHint => 'Nome legale';

  @override
  String get signUpLastName => 'Cognome';

  @override
  String get signUpLastNameHint => 'Cognome legale';

  @override
  String get signUpPasswordHint => 'Crea una password';

  @override
  String get signUpConfirmPassword => 'Conferma password';

  @override
  String get signUpConfirmPasswordHint => 'Conferma la tua password';

  @override
  String get signUpAgree =>
      'Accetto i termini, le informative sui rischi e le notifiche di conferma del regolamento.';

  @override
  String get signUpProgress => 'Creazione account…';

  @override
  String get signUpGoogle => 'Registrati con Google';

  @override
  String get signUpDisclosure =>
      'Le azioni finanziarie richiedono il KYC e la configurazione di un portafoglio verificato dopo la creazione dell\'account.';

  @override
  String get signUpHaveAccount => 'Hai già un account? Accedi';

  @override
  String get phoneTitle => 'Accedi con il telefono';

  @override
  String get phoneOtpTitle => 'Inserisci il codice di verifica';

  @override
  String get phoneSubtitle =>
      'Inserisci il tuo numero di telefono con il prefisso internazionale (es. +1 415 555 2671).';

  @override
  String phoneOtpSubtitle(String phone) {
    return 'Abbiamo inviato un codice di 6 cifre a $phone.';
  }

  @override
  String get phoneHint => '+1 415 555 2671';

  @override
  String get phoneCodeHint => '000000';

  @override
  String get phoneSendingCode => 'Invio del codice…';

  @override
  String get phoneSendCode => 'Invia codice di verifica';

  @override
  String get phoneVerifying => 'Verifica…';

  @override
  String get phoneConfirmCode => 'Conferma codice';

  @override
  String get phoneUseDifferentNumber => 'Usa un altro numero';
}
