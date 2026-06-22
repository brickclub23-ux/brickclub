// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'BrickClub';

  @override
  String get profileLanguage => 'اللغة';

  @override
  String get languageScreenTitle => 'اللغة';

  @override
  String get languageHeading => 'لغة العرض';

  @override
  String get languageDescription =>
      'اختر اللغة التي يستخدمها BrickClub على هذا الجهاز.';

  @override
  String get languageSystemDefault => 'إعداد النظام الافتراضي';

  @override
  String get commonEmail => 'البريد الإلكتروني';

  @override
  String get commonEmailHint => 'you@example.com';

  @override
  String get commonPassword => 'كلمة المرور';

  @override
  String get authConnecting => 'جارٍ الاتصال…';

  @override
  String get signInWelcomeTitle => 'مرحبًا بعودتك';

  @override
  String get signInAdminTitle => 'تسجيل دخول المسؤول';

  @override
  String get signInMemberSubtitle => 'تابع إلى محفظة BrickShares الخاصة بك.';

  @override
  String get signInAdminSubtitle =>
      'الوصول إلى عمليات المستخدمين والأصول ومدفوعات العملات المشفرة.';

  @override
  String get signInPasswordHint => 'أدخل كلمة المرور';

  @override
  String get signInForgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get signInProgress => 'جارٍ تسجيل الدخول…';

  @override
  String get signInOpenAdminDashboard => 'فتح لوحة تحكم المسؤول';

  @override
  String get signInSubmit => 'تسجيل دخول آمن';

  @override
  String get signInGoogleAdmin => 'المتابعة كمسؤول باستخدام Google';

  @override
  String get signInGoogle => 'المتابعة باستخدام Google';

  @override
  String get signInPhone => 'المتابعة عبر الهاتف';

  @override
  String get signInUseMember => 'استخدام تسجيل دخول الأعضاء';

  @override
  String get signInUseAdmin => 'تسجيل الدخول كمسؤول';

  @override
  String get signInCreateAccount => 'إنشاء حساب BrickClub';

  @override
  String get signInGoogleNoAdmin => 'حساب Google هذا لا يملك صلاحية المسؤول.';

  @override
  String get signInNoAdmin => 'هذا الحساب لا يملك صلاحية المسؤول.';

  @override
  String get signInResetSent => 'تم إرسال تعليمات إعادة تعيين كلمة المرور';

  @override
  String get signInStoryTitle => 'الملكية، أصبحت\nأكثر سهولة.';

  @override
  String get signInStoryBody =>
      'راجع الفرص الموثَّقة، وسوِّ معاملاتك بثقة، واحتفظ بكل أصل أمام عينيك.';

  @override
  String get signUpIntro =>
      'أنشئ حساب BrickShares الخاص بك. يأتي بعد ذلك التحقق من المحفظة وإجراءات اعرف عميلك (KYC).';

  @override
  String get signUpCreateAccount => 'إنشاء حساب';

  @override
  String get signUpLegalNamesHint =>
      'استخدم أسماءك القانونية تمامًا كما تظهر في هويتك.';

  @override
  String get signUpFirstName => 'الاسم الأول';

  @override
  String get signUpFirstNameHint => 'الاسم الأول القانوني';

  @override
  String get signUpLastName => 'اسم العائلة';

  @override
  String get signUpLastNameHint => 'اسم العائلة القانوني';

  @override
  String get signUpPasswordHint => 'أنشئ كلمة مرور';

  @override
  String get signUpConfirmPassword => 'تأكيد كلمة المرور';

  @override
  String get signUpConfirmPasswordHint => 'أكِّد كلمة المرور';

  @override
  String get signUpAgree =>
      'أوافق على الشروط وإفصاحات المخاطر وإشعارات تأكيد التسوية.';

  @override
  String get signUpProgress => 'جارٍ إنشاء الحساب…';

  @override
  String get signUpGoogle => 'التسجيل باستخدام Google';

  @override
  String get signUpDisclosure =>
      'تتطلب الإجراءات المالية إكمال اعرف عميلك (KYC) وإعداد محفظة موثَّقة بعد إنشاء الحساب.';

  @override
  String get signUpHaveAccount => 'هل لديك حساب بالفعل؟ سجّل الدخول';

  @override
  String get phoneTitle => 'تسجيل الدخول عبر الهاتف';

  @override
  String get phoneOtpTitle => 'أدخل رمز التحقق';

  @override
  String get phoneSubtitle =>
      'أدخل رقم هاتفك مع رمز الدولة (مثال: +1 415 555 2671).';

  @override
  String phoneOtpSubtitle(String phone) {
    return 'أرسلنا رمزًا مكوّنًا من 6 أرقام إلى $phone.';
  }

  @override
  String get phoneHint => '+1 415 555 2671';

  @override
  String get phoneCodeHint => '000000';

  @override
  String get phoneSendingCode => 'جارٍ إرسال الرمز…';

  @override
  String get phoneSendCode => 'إرسال رمز التحقق';

  @override
  String get phoneVerifying => 'جارٍ التحقق…';

  @override
  String get phoneConfirmCode => 'تأكيد الرمز';

  @override
  String get phoneUseDifferentNumber => 'استخدام رقم آخر';
}
