// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'BrickClub';

  @override
  String get profileLanguage => '语言';

  @override
  String get languageScreenTitle => '语言';

  @override
  String get languageHeading => '显示语言';

  @override
  String get languageDescription => '选择 BrickClub 在此设备上使用的语言。';

  @override
  String get languageSystemDefault => '系统默认';

  @override
  String get commonEmail => '电子邮箱';

  @override
  String get commonEmailHint => 'you@example.com';

  @override
  String get commonPassword => '密码';

  @override
  String get authConnecting => '连接中…';

  @override
  String get signInWelcomeTitle => '欢迎回来';

  @override
  String get signInAdminTitle => '管理员登录';

  @override
  String get signInMemberSubtitle => '继续查看您的 BrickShares 投资组合。';

  @override
  String get signInAdminSubtitle => '访问用户、资产和加密支付操作。';

  @override
  String get signInPasswordHint => '请输入您的密码';

  @override
  String get signInForgotPassword => '忘记密码？';

  @override
  String get signInProgress => '正在登录…';

  @override
  String get signInOpenAdminDashboard => '打开管理后台';

  @override
  String get signInSubmit => '安全登录';

  @override
  String get signInGoogleAdmin => '以管理员身份使用 Google 继续';

  @override
  String get signInGoogle => '使用 Google 继续';

  @override
  String get signInPhone => '使用手机号继续';

  @override
  String get signInUseMember => '使用会员登录';

  @override
  String get signInUseAdmin => '以管理员身份登录';

  @override
  String get signInCreateAccount => '创建 BrickClub 账户';

  @override
  String get signInGoogleNoAdmin => '该 Google 账户没有管理员权限。';

  @override
  String get signInNoAdmin => '该账户没有管理员权限。';

  @override
  String get signInResetSent => '已发送密码重置说明';

  @override
  String get signInStoryTitle => '让拥有，\n更触手可及。';

  @override
  String get signInStoryBody => '查看经过验证的机会，安心完成结算，并随时掌握每一项资产。';

  @override
  String get signUpIntro => '创建您的 BrickShares 账户。接下来需要完成钱包验证和 KYC。';

  @override
  String get signUpCreateAccount => '创建账户';

  @override
  String get signUpLegalNamesHint => '请使用与您证件上完全一致的法定姓名。';

  @override
  String get signUpFirstName => '名字';

  @override
  String get signUpFirstNameHint => '法定名字';

  @override
  String get signUpLastName => '姓氏';

  @override
  String get signUpLastNameHint => '法定姓氏';

  @override
  String get signUpPasswordHint => '创建密码';

  @override
  String get signUpConfirmPassword => '确认密码';

  @override
  String get signUpConfirmPasswordHint => '请确认您的密码';

  @override
  String get signUpAgree => '我同意条款、风险披露和结算确认通知。';

  @override
  String get signUpProgress => '正在创建账户…';

  @override
  String get signUpGoogle => '使用 Google 注册';

  @override
  String get signUpDisclosure => '创建账户后，进行金融操作需完成 KYC 和已验证的钱包设置。';

  @override
  String get signUpHaveAccount => '已有账户？登录';

  @override
  String get phoneTitle => '使用手机号登录';

  @override
  String get phoneOtpTitle => '输入验证码';

  @override
  String get phoneSubtitle => '请输入带国家/地区代码的手机号（例如 +1 415 555 2671）。';

  @override
  String phoneOtpSubtitle(String phone) {
    return '我们已向 $phone 发送了 6 位验证码。';
  }

  @override
  String get phoneHint => '+1 415 555 2671';

  @override
  String get phoneCodeHint => '000000';

  @override
  String get phoneSendingCode => '正在发送验证码…';

  @override
  String get phoneSendCode => '发送验证码';

  @override
  String get phoneVerifying => '正在验证…';

  @override
  String get phoneConfirmCode => '确认验证码';

  @override
  String get phoneUseDifferentNumber => '使用其他号码';
}
