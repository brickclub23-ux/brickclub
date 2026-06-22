// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'BrickClub';

  @override
  String get profileLanguage => 'Idioma';

  @override
  String get languageScreenTitle => 'Idioma';

  @override
  String get languageHeading => 'Idioma de visualización';

  @override
  String get languageDescription =>
      'Elige el idioma que BrickClub usa en este dispositivo.';

  @override
  String get languageSystemDefault => 'Predeterminado del sistema';

  @override
  String get commonEmail => 'Correo electrónico';

  @override
  String get commonEmailHint => 'tu@ejemplo.com';

  @override
  String get commonPassword => 'Contraseña';

  @override
  String get authConnecting => 'Conectando…';

  @override
  String get signInWelcomeTitle => 'Bienvenido de nuevo';

  @override
  String get signInAdminTitle => 'Inicio de sesión de administrador';

  @override
  String get signInMemberSubtitle => 'Continúa con tu cartera de BrickShares.';

  @override
  String get signInAdminSubtitle =>
      'Accede a las operaciones de usuarios, activos y pagos con cripto.';

  @override
  String get signInPasswordHint => 'Introduce tu contraseña';

  @override
  String get signInForgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get signInProgress => 'Iniciando sesión…';

  @override
  String get signInOpenAdminDashboard => 'Abrir panel de administración';

  @override
  String get signInSubmit => 'Iniciar sesión de forma segura';

  @override
  String get signInGoogleAdmin => 'Continuar como administrador con Google';

  @override
  String get signInGoogle => 'Continuar con Google';

  @override
  String get signInPhone => 'Continuar con el teléfono';

  @override
  String get signInUseMember => 'Usar inicio de sesión de miembro';

  @override
  String get signInUseAdmin => 'Iniciar sesión como administrador';

  @override
  String get signInCreateAccount => 'Crear una cuenta de BrickClub';

  @override
  String get signInGoogleNoAdmin =>
      'Esta cuenta de Google no tiene acceso de administrador.';

  @override
  String get signInNoAdmin => 'Esta cuenta no tiene acceso de administrador.';

  @override
  String get signInResetSent =>
      'Instrucciones de restablecimiento de contraseña enviadas';

  @override
  String get signInStoryTitle => 'La propiedad, ahora\nmás accesible.';

  @override
  String get signInStoryBody =>
      'Revisa oportunidades verificadas, liquida con confianza y mantén cada activo a la vista.';

  @override
  String get signUpIntro =>
      'Crea tu cuenta de BrickShares. La verificación de la cartera y el KYC vienen a continuación.';

  @override
  String get signUpCreateAccount => 'Crear cuenta';

  @override
  String get signUpLegalNamesHint =>
      'Usa tus nombres legales exactamente como aparecen en tu documento de identidad.';

  @override
  String get signUpFirstName => 'Nombre';

  @override
  String get signUpFirstNameHint => 'Nombre legal';

  @override
  String get signUpLastName => 'Apellido';

  @override
  String get signUpLastNameHint => 'Apellido legal';

  @override
  String get signUpPasswordHint => 'Crea una contraseña';

  @override
  String get signUpConfirmPassword => 'Confirmar contraseña';

  @override
  String get signUpConfirmPasswordHint => 'Confirma tu contraseña';

  @override
  String get signUpAgree =>
      'Acepto los términos, las divulgaciones de riesgo y los avisos de confirmación de liquidación.';

  @override
  String get signUpProgress => 'Creando cuenta…';

  @override
  String get signUpGoogle => 'Registrarse con Google';

  @override
  String get signUpDisclosure =>
      'Las acciones financieras requieren KYC y la configuración de una cartera verificada tras crear la cuenta.';

  @override
  String get signUpHaveAccount => '¿Ya tienes una cuenta? Inicia sesión';

  @override
  String get phoneTitle => 'Iniciar sesión con el teléfono';

  @override
  String get phoneOtpTitle => 'Introduce el código de verificación';

  @override
  String get phoneSubtitle =>
      'Introduce tu número de teléfono con el código de país (p. ej. +1 415 555 2671).';

  @override
  String phoneOtpSubtitle(String phone) {
    return 'Enviamos un código de 6 dígitos a $phone.';
  }

  @override
  String get phoneHint => '+1 415 555 2671';

  @override
  String get phoneCodeHint => '000000';

  @override
  String get phoneSendingCode => 'Enviando código…';

  @override
  String get phoneSendCode => 'Enviar código de verificación';

  @override
  String get phoneVerifying => 'Verificando…';

  @override
  String get phoneConfirmCode => 'Confirmar código';

  @override
  String get phoneUseDifferentNumber => 'Usar otro número';
}
