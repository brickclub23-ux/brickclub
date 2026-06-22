// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'BrickClub';

  @override
  String get profileLanguage => 'Язык';

  @override
  String get languageScreenTitle => 'Язык';

  @override
  String get languageHeading => 'Язык интерфейса';

  @override
  String get languageDescription =>
      'Выберите язык, который BrickClub использует на этом устройстве.';

  @override
  String get languageSystemDefault => 'Системный язык';

  @override
  String get commonEmail => 'Электронная почта';

  @override
  String get commonEmailHint => 'you@example.com';

  @override
  String get commonPassword => 'Пароль';

  @override
  String get authConnecting => 'Подключение…';

  @override
  String get signInWelcomeTitle => 'С возвращением';

  @override
  String get signInAdminTitle => 'Вход для администратора';

  @override
  String get signInMemberSubtitle => 'Перейдите к своему портфелю BrickShares.';

  @override
  String get signInAdminSubtitle =>
      'Доступ к операциям с пользователями, активами и криптоплатежами.';

  @override
  String get signInPasswordHint => 'Введите пароль';

  @override
  String get signInForgotPassword => 'Забыли пароль?';

  @override
  String get signInProgress => 'Выполняется вход…';

  @override
  String get signInOpenAdminDashboard => 'Открыть панель администратора';

  @override
  String get signInSubmit => 'Безопасный вход';

  @override
  String get signInGoogleAdmin => 'Продолжить как администратор через Google';

  @override
  String get signInGoogle => 'Продолжить через Google';

  @override
  String get signInPhone => 'Продолжить по телефону';

  @override
  String get signInUseMember => 'Войти как участник';

  @override
  String get signInUseAdmin => 'Войти как администратор';

  @override
  String get signInCreateAccount => 'Создать аккаунт BrickClub';

  @override
  String get signInGoogleNoAdmin =>
      'У этого аккаунта Google нет прав администратора.';

  @override
  String get signInNoAdmin => 'У этого аккаунта нет прав администратора.';

  @override
  String get signInResetSent => 'Инструкции по сбросу пароля отправлены';

  @override
  String get signInStoryTitle => 'Владение стало\nдоступнее.';

  @override
  String get signInStoryBody =>
      'Изучайте проверенные возможности, проводите расчёты уверенно и держите каждый актив на виду.';

  @override
  String get signUpIntro =>
      'Создайте аккаунт BrickShares. Далее — проверка кошелька и KYC.';

  @override
  String get signUpCreateAccount => 'Создать аккаунт';

  @override
  String get signUpLegalNamesHint =>
      'Укажите официальные имена точно так, как в вашем документе.';

  @override
  String get signUpFirstName => 'Имя';

  @override
  String get signUpFirstNameHint => 'Официальное имя';

  @override
  String get signUpLastName => 'Фамилия';

  @override
  String get signUpLastNameHint => 'Официальная фамилия';

  @override
  String get signUpPasswordHint => 'Создайте пароль';

  @override
  String get signUpConfirmPassword => 'Подтвердите пароль';

  @override
  String get signUpConfirmPasswordHint => 'Подтвердите ваш пароль';

  @override
  String get signUpAgree =>
      'Я принимаю условия, раскрытие рисков и уведомления о подтверждении расчётов.';

  @override
  String get signUpProgress => 'Создание аккаунта…';

  @override
  String get signUpGoogle => 'Зарегистрироваться через Google';

  @override
  String get signUpDisclosure =>
      'Для финансовых операций после создания аккаунта требуются KYC и настройка проверенного кошелька.';

  @override
  String get signUpHaveAccount => 'Уже есть аккаунт? Войти';

  @override
  String get phoneTitle => 'Вход по телефону';

  @override
  String get phoneOtpTitle => 'Введите код подтверждения';

  @override
  String get phoneSubtitle =>
      'Введите номер телефона с кодом страны (например, +1 415 555 2671).';

  @override
  String phoneOtpSubtitle(String phone) {
    return 'Мы отправили 6-значный код на $phone.';
  }

  @override
  String get phoneHint => '+1 415 555 2671';

  @override
  String get phoneCodeHint => '000000';

  @override
  String get phoneSendingCode => 'Отправка кода…';

  @override
  String get phoneSendCode => 'Отправить код подтверждения';

  @override
  String get phoneVerifying => 'Проверка…';

  @override
  String get phoneConfirmCode => 'Подтвердить код';

  @override
  String get phoneUseDifferentNumber => 'Использовать другой номер';
}
