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

  @override
  String get installIosTitle => 'Установка на iPhone или iPad';

  @override
  String get installIosIntro =>
      'Добавьте BrickClub на главный экран прямо из Safari — без App Store.';

  @override
  String get installIosStep1 =>
      'Нажмите кнопку «Поделиться» на панели инструментов Safari.';

  @override
  String get installIosStep2 =>
      'Прокрутите вниз и выберите «На экран «Домой»».';

  @override
  String get installIosStep3 =>
      'Нажмите «Добавить» — BrickClub появится на главном экране.';

  @override
  String get installAndroidTitle => 'Установка на Android';

  @override
  String get installAndroidIntro =>
      'Добавьте BrickClub на устройство в пару нажатий из браузера.';

  @override
  String get installAndroidStep1 =>
      'Откройте меню браузера (⋮ в верхнем углу).';

  @override
  String get installAndroidStep2 =>
      'Нажмите «Установить приложение» или «Добавить на главный экран».';

  @override
  String get installAndroidStep3 =>
      'Подтвердите — BrickClub появится в списке приложений.';

  @override
  String get installDesktopTitle => 'Установка на компьютере';

  @override
  String get installDesktopIntro =>
      'Установите BrickClub как приложение из Chrome или Edge.';

  @override
  String get installDesktopStep1 =>
      'Нажмите значок установки в адресной строке или откройте меню браузера.';

  @override
  String get installDesktopStep2 =>
      'Выберите «Установить», чтобы открыть BrickClub в отдельном окне.';

  @override
  String get installGotIt => 'Понятно';

  @override
  String get installAlready => 'BrickClub уже установлен на этом устройстве.';

  @override
  String get installInstalling => 'Установка BrickClub на ваше устройство…';

  @override
  String get installDismissed =>
      'Установка отменена. Вы можете установить приложение в любое время.';

  @override
  String get navFeatures => 'Возможности';

  @override
  String get navHowItWorks => 'Как это работает';

  @override
  String get navTestimonials => 'Отзывы';

  @override
  String get landingSignIn => 'Войти';

  @override
  String get landingSignUp => 'Регистрация';

  @override
  String get landingJoin => 'Присоединиться';

  @override
  String get landingCreateAccount => 'Создать аккаунт';

  @override
  String get heroTitle => 'Владейте большим,\nчем мечта.';

  @override
  String get heroBody =>
      'Создавайте реальную собственность с помощью проверенных BrickShares, обеспеченных недвижимостью, с прозрачной доходностью и надёжными крипторасчётами в одном безопасном приложении.';

  @override
  String get heroInstall => 'Установить приложение';

  @override
  String get heroExplore => 'Изучить BrickShares';

  @override
  String get proofVerifiedAssets => 'Проверенные активы';

  @override
  String get proofTrustedSettlement => 'Надёжные расчёты';

  @override
  String get proofClearPerformance => 'Понятная доходность';

  @override
  String get previewPortfolioValue => 'Стоимость портфеля';

  @override
  String get previewMinimum => 'Минимум';

  @override
  String get previewTargetReturn => 'Целевая доходность';

  @override
  String get heroCardTargetReturn => 'Целевая годовая доходность';

  @override
  String get assetVerifiedBadge => 'ПРОВЕРЕННЫЙ АКТИВ';

  @override
  String get assetSampleDescription => 'Доходная жилая недвижимость';

  @override
  String get assetFunded => 'Профинансировано';

  @override
  String get trustDueDiligence => 'ПРОВЕРКА НЕДВИЖИМОСТИ';

  @override
  String get trustKycVerified => 'УЧАСТНИКИ С ПРОВЕРКОЙ KYC';

  @override
  String get trustUsdtSettlement => 'РАСЧЁТЫ В USDT';

  @override
  String get trustOwnershipRecords => 'ЧЁТКИЕ ЗАПИСИ О СОБСТВЕННОСТИ';

  @override
  String get statTargetReturn => 'Средняя целевая доходность';

  @override
  String get statMinimum => 'Минимум для старта';

  @override
  String get statSettlement => 'Расчёты в блокчейне';

  @override
  String get statVisibility => 'Прозрачность портфеля';

  @override
  String get howTitle => 'От регистрации к собственности.';

  @override
  String get howSubtitle =>
      'Понятный путь для инвесторов, которым нужна уверенность на каждом шаге.';

  @override
  String get howStep1Title => 'Создайте и подтвердите';

  @override
  String get howStep1Body =>
      'Откройте аккаунт, пройдите KYC и подключите проверенный кошелёк.';

  @override
  String get howStep2Title => 'Выберите BrickShares';

  @override
  String get howStep2Body =>
      'Изучите проверенные активы, целевую доходность, риски и условия собственности.';

  @override
  String get howStep3Title => 'Финансируйте и отслеживайте';

  @override
  String get howStep3Body =>
      'Проводите расчёты безопасно поддерживаемой криптовалютой и следите за портфелем.';

  @override
  String get featuresTitle => 'Создано ради ясности,\nа не спекуляций.';

  @override
  String get featuresBody =>
      'Каждая возможность сразу показывает важное: структуру собственности, проверку актива, целевую доходность, риски, сеть финансирования и статус расчётов.';

  @override
  String get feature1 => 'Проверенная документация по активам';

  @override
  String get feature2 => 'Прозрачные котировки крипты и комиссии сети';

  @override
  String get feature3 => 'Подтверждение перед каждым финансовым действием';

  @override
  String get testimonialsTitle => 'Построено на доверии инвесторов.';

  @override
  String get testimonialsSubtitle =>
      'Что больше всего ценят в работе первые участники BrickClub.';

  @override
  String get testimonial1Quote =>
      'BrickClub делает важные детали понятными. Я знаю, чем владею, как это работает и что происходит до финансирования.';

  @override
  String get testimonial1Role => 'Предприниматель, Лондон';

  @override
  String get testimonial2Quote =>
      'Процесс проверки и подтверждения вселил уверенность. Это похоже на серьёзную инвестиционную платформу, а не на очередной криптообходной путь.';

  @override
  String get testimonial2Role => 'Руководитель продукта, Сингапур';

  @override
  String get testimonial3Quote =>
      'Я могу начать с разумной суммы и при этом получить доступ к активам, за которыми обычно наблюдал бы только со стороны.';

  @override
  String get testimonial3Role => 'Консультант, Дубай';

  @override
  String get ctaBadge => 'НАЧНИТЕ ЗА НЕСКОЛЬКО МИНУТ';

  @override
  String get ctaTitle => 'Ваш следующий актив может начаться здесь.';

  @override
  String get ctaBody =>
      'Установите BrickClub, создайте аккаунт и изучите проверенные BrickShares, созданные для долгосрочной собственности.';

  @override
  String get ctaHaveAccount => 'У меня уже есть аккаунт';

  @override
  String get ctaSecureKyc => 'Безопасный KYC';

  @override
  String get ctaFreeToBrowse => 'Просмотр бесплатно';

  @override
  String get ctaVerifiedOnly => 'Только проверенные активы';

  @override
  String get footerCopyright => '© 2026 BrickClub';

  @override
  String get commonViewAll => 'Показать все';

  @override
  String get commonCancel => 'Отмена';

  @override
  String get navInvest => 'Инвестировать';

  @override
  String get navWallet => 'Кошелёк';

  @override
  String get navPortfolio => 'Портфель';

  @override
  String get navProfile => 'Профиль';

  @override
  String get kycGateTitle => 'Сначала пройдите KYC';

  @override
  String kycGateBody(String status) {
    return 'Статус: $status. Покупки, выводы, изменения кошелька и крипторасчёты станут доступны после одобрения.';
  }

  @override
  String get kycGateViewStatus => 'Посмотреть статус KYC';

  @override
  String get kycGateComplete => 'Пройти KYC';

  @override
  String get homeFeaturedOpportunity => 'Рекомендуемая возможность';

  @override
  String get homeNoLiveTitle => 'Пока нет активных BrickShares';

  @override
  String get homeNoLiveBody =>
      'Опубликованные проверенные активы появятся здесь.';

  @override
  String get homeViewInvest => 'Перейти к инвестициям';

  @override
  String get homeYourHoldings => 'Ваши активы';

  @override
  String get homeRecentActivity => 'Недавняя активность';

  @override
  String get holdingsEmptyTitle => 'Пока нет активов';

  @override
  String get holdingsEmptyHome =>
      'Проверенные депозиты появятся здесь как BrickShares.';

  @override
  String get activityEmptyTitle => 'Пока нет активности';

  @override
  String get activityEmptyBody =>
      'Запросы на депозит и обновления расчётов появятся здесь.';

  @override
  String get dashboardErrorTitle => 'Не удалось загрузить данные аккаунта';

  @override
  String get dashboardErrorBody =>
      'Проверьте подключение к серверу и повторите попытку.';

  @override
  String get investSubtitle =>
      'Изучайте проверенные мультиактивные BrickShares';

  @override
  String get investSearchHint =>
      'Поиск по названию, местоположению или классу актива';

  @override
  String investAvailable(int count) {
    return 'Доступно $count';
  }

  @override
  String get investFilteredIncome => 'Отфильтрованные доходные\nBrickShares';

  @override
  String investOpportunitiesCount(int count) {
    return 'Возможностей: $count';
  }

  @override
  String get investLoadingOpportunities => 'Загрузка возможностей';

  @override
  String get investFiltersAction => 'Фильтры';

  @override
  String get investNoMatchTitle => 'Нет подходящих BrickShares';

  @override
  String get investNoMatchEmpty =>
      'Проверенные активы, опубликованные администратором, появятся здесь.';

  @override
  String investNoMatchSearch(String query) {
    return 'Нет BrickShares по запросу «$query». Попробуйте другой запрос или измените фильтры.';
  }

  @override
  String get investNoMatchFilters =>
      'Попробуйте другой класс актива, уровень риска или способ оплаты.';

  @override
  String get investResetFilters => 'Сбросить фильтры';

  @override
  String get walletCryptoActivity => 'Активность криптоордеров';

  @override
  String get walletFundingTitle => 'Готовность к криптофинансированию';

  @override
  String get walletFundingBody =>
      'Добавьте проверенный кошелёк перед отправкой средств. Сеть, комиссии, срок действия котировки и статус расчётов показываются перед подтверждением.';

  @override
  String get walletAddWallet => 'Добавить проверенный кошелёк';

  @override
  String get walletVerificationStarted => 'Проверка кошелька начата';

  @override
  String get walletSettlementTitle => 'Требуется подтверждение расчёта';

  @override
  String get walletSettlementBody =>
      'Покупки, выводы и изменения кошелька требуют окончательного подтверждения.';

  @override
  String get walletVerifiedBalance => 'Баланс проверенного кошелька';

  @override
  String get portfolioCurrentValue => 'Текущая стоимость портфеля';

  @override
  String get portfolioInvested => 'Вложено';

  @override
  String get portfolioProfitLoss => 'Прибыль / убыток';

  @override
  String get portfolioReturn => 'Доходность';

  @override
  String portfolioDividends(String amount) {
    return 'Получено дивидендов: $amount';
  }

  @override
  String get portfolioHoldings => 'Активы';

  @override
  String get portfolioHoldingsEmptyBody =>
      'Одобренные инвестиции появляются здесь автоматически.';

  @override
  String get portfolioAllocation => 'Распределение';

  @override
  String get portfolioAllocationEmptyTitle => 'Пока нет распределения';

  @override
  String get portfolioAllocationEmptyBody =>
      'Состав ваших активов появится после проверки депозитов.';

  @override
  String portfolioInvestedOwnership(String invested, String ownership) {
    return 'Вложено $invested · доля $ownership';
  }

  @override
  String get profileSettings => 'Настройки';

  @override
  String profileThemeSubtitle(String mode) {
    return 'Тема: $mode';
  }

  @override
  String get profileSecurityTitle => 'Безопасность и конфиденциальность';

  @override
  String get profileSecuritySubtitle => 'Проверенный кошелёк и биометрия';

  @override
  String get profileDocumentsTitle => 'Документы';

  @override
  String get profileDocumentsSubtitle => 'Выписки, раскрытие рисков';

  @override
  String profileRowOpened(String title) {
    return 'Открыто: $title';
  }

  @override
  String get profileSupport => 'Поддержка';

  @override
  String get profileSupportSubtitle => 'Напишите команде BrickClub';

  @override
  String get profileLogout => 'Выйти';

  @override
  String get profileLogoutConfirmTitle => 'Выйти?';

  @override
  String get profileLogoutConfirmBody =>
      'Чтобы получить доступ к аккаунту, потребуется войти снова.';

  @override
  String get profileDefaultName => 'Участник BrickClub';

  @override
  String get profileDefaultSubtitle => 'Данные вашего аккаунта и BrickShares';

  @override
  String get themeScreenTitle => 'Тема';

  @override
  String get themeAppearance => 'Оформление';

  @override
  String get themeAppearanceDescription =>
      'Выберите, как BrickClub выглядит на этом устройстве.';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get themeSystemDescription =>
      'Автоматически следовать настройкам устройства.';

  @override
  String get themeLightDescription => 'Светлый интерфейс с тёмным текстом.';

  @override
  String get themeDarkDescription => 'Классический тёмный интерфейс BrickClub.';

  @override
  String get commonSending => 'Отправка…';

  @override
  String get commonSubmitting => 'Отправка…';

  @override
  String get filtersAssetClass => 'Класс актива';

  @override
  String get filtersRiskLevel => 'Уровень риска';

  @override
  String get filtersPaymentMethod => 'Способ оплаты';

  @override
  String get filtersReset => 'Сбросить';

  @override
  String filtersShow(int count) {
    return 'Показать $count';
  }

  @override
  String get successTitle => 'Подтверждение отправлено';

  @override
  String get successBody =>
      'Ваше подтверждение оплаты ожидает проверки администратором. Мы уведомим вас после проверки.';

  @override
  String get successSettlementStatus => 'Статус расчёта';

  @override
  String get successViewPortfolio => 'Посмотреть портфель';

  @override
  String get detailVerifiedDocs => 'Проверенные документы';

  @override
  String detailAssetLine(String assetClass, String location) {
    return '$assetClass BrickShares | $location';
  }

  @override
  String get detailLiquidity => 'Ликвидность';

  @override
  String get detailFundingStatus => 'Статус финансирования';

  @override
  String detailFundedPercent(String percent) {
    return 'Профинансировано $percent%';
  }

  @override
  String get detailFundingNote =>
      'Поддерживаемые способы оплаты и срок действия котировки показываются перед подтверждением расчёта.';

  @override
  String get detailInvestButton => 'Инвестировать через криптофинансирование';

  @override
  String get kycStatusApproved => 'Финансовые операции разблокированы.';

  @override
  String get kycStatusSubmitted => 'Ваши документы на проверке.';

  @override
  String get kycStatusRejectedDefault => 'Проверьте заявку и отправьте снова.';

  @override
  String get kycStatusDefault =>
      'Требуется перед покупками и изменениями кошелька.';

  @override
  String get kycChipPhone => 'Телефон';

  @override
  String get kycChipIdentity => 'Личность';

  @override
  String get kycChipOk => 'OK';

  @override
  String get kycChipNeeded => 'Нужно';

  @override
  String get kycViewDetails => 'Посмотреть данные KYC';

  @override
  String get kycVerifyIdentity => 'Подтвердить личность';

  @override
  String get kycFullName => 'Полное официальное имя';

  @override
  String get kycFullNameHint => 'Имя точно как в вашем документе';

  @override
  String get kycDob => 'Дата рождения';

  @override
  String get kycSelectDate => 'Выбрать дату';

  @override
  String get kycGovId => 'Удостоверение личности или паспорт';

  @override
  String get kycUploadId => 'Загрузить документ, удостоверяющий личность';

  @override
  String get kycSelfie => 'Селфи / проверка лица';

  @override
  String get kycCaptureSelfie => 'Сделать селфи';

  @override
  String get kycAddressProof => 'Подтверждение фактического адреса';

  @override
  String get kycUploadAddress => 'Загрузить счёт за услуги или договор аренды';

  @override
  String get kycPhoneVerification => 'Подтверждение телефона';

  @override
  String get kycSendCode => 'Отправить код';

  @override
  String get kycVerificationCodeHint => 'Код подтверждения';

  @override
  String get kycEmailVerification => 'Подтверждение эл. почты';

  @override
  String get kycEmailVerified => 'Эл. почта подтверждена';

  @override
  String get kycEmailNotVerified => 'Эл. почта не подтверждена';

  @override
  String get kycSendEmail => 'Отправить письмо';

  @override
  String get kycSubmitForReview => 'Отправить на проверку';

  @override
  String get kycEmulatorNote =>
      'Коды для телефона появляются в эмуляторе Firebase Auth. Письма для разработки появляются в Mailpit.';

  @override
  String get kycEmailSent => 'Письмо для подтверждения отправлено';

  @override
  String get kycEnterPhoneFirst => 'Сначала введите номер телефона';

  @override
  String get kycCodeSent => 'Код отправлен. Проверьте эмулятор Firebase Auth.';

  @override
  String get kycSubmitted => 'KYC отправлен на автоматические проверки';

  @override
  String get kycMissingName => 'Введите ваше официальное имя';

  @override
  String get kycMissingDob => 'Выберите дату рождения';

  @override
  String get kycMissingId => 'Загрузите удостоверение личности или паспорт';

  @override
  String get kycMissingSelfie => 'Сделайте селфи';

  @override
  String get kycMissingAddress => 'Загрузите подтверждение адреса';

  @override
  String get kycMissingPhone => 'Введите номер телефона';

  @override
  String get kycInvalidPhone =>
      'Введите номер телефона в международном формате, например +12025550190.';

  @override
  String get kycMissingCode => 'Введите код подтверждения телефона';

  @override
  String get kycUpdateFailed =>
      'Не удалось обновить данные KYC. Повторите попытку.';

  @override
  String get paymentConfirmFunding => 'Подтвердить финансирование';

  @override
  String get paymentSetup => 'Настройка криптофинансирования';

  @override
  String get paymentStatusDraft => 'Черновик';

  @override
  String get paymentStatusActive => 'Активно';

  @override
  String get paymentRail => 'Платёжный канал';

  @override
  String get paymentAmount => 'Сумма инвестиции';

  @override
  String get paymentAmountHint => 'Сумма в USD';

  @override
  String paymentBelowMinimum(String minimum) {
    return 'Минимум для этой возможности — $minimum.';
  }

  @override
  String get paymentDemoAmount =>
      'Демонстрационную сумму можно изменить перед созданием запроса на депозит.';

  @override
  String get paymentQuotePaymentAsset => 'Платёжный актив';

  @override
  String get paymentQuoteAmount => 'Сумма';

  @override
  String get paymentQuoteNetwork => 'Сеть';

  @override
  String get paymentNetworkAfterRequest => 'Выбирается после запроса';

  @override
  String get paymentQuote => 'Котировка';

  @override
  String get paymentQuoteByBackend => 'Создаётся сервером';

  @override
  String get paymentNetworkFee => 'Комиссия сети';

  @override
  String get paymentFeeByBackend => 'Рассчитывается сервером';

  @override
  String get paymentSettlement => 'Расчёт';

  @override
  String get paymentPendingConfirmation => 'Ожидает подтверждения';

  @override
  String get paymentConfirmableTitle => 'Подтверждаемое финансовое действие';

  @override
  String get paymentConfirmableBody =>
      'Вы авторизуете покупку BrickShares с криптофинансированием. Расчёт может потребовать подтверждений в сети.';

  @override
  String get paymentCreateRequest => 'Создать запрос на депозит';

  @override
  String get paymentSubmitProof => 'Отправить подтверждение на проверку';

  @override
  String get paymentIncreaseAmount =>
      'Увеличьте сумму до минимума для этой возможности.';

  @override
  String get paymentDepositCreated => 'Запрос на депозит создан';

  @override
  String get paymentEnterHash => 'Введите хеш транзакции';

  @override
  String get paymentUploadProof => 'Загрузите подтверждение оплаты';

  @override
  String get paymentDepositInstructions => 'Инструкции по депозиту';

  @override
  String get paymentWalletAddress => 'Адрес кошелька';

  @override
  String get paymentTransactionHash => 'Хеш транзакции';

  @override
  String get paymentHashHint => 'Вставьте хеш транзакции в блокчейне';

  @override
  String get paymentStepQuote => 'Котировка';

  @override
  String get paymentStepSend => 'Отправка';

  @override
  String get paymentStepReview => 'Проверка';

  @override
  String get paymentCopy => 'Копировать';

  @override
  String get paymentWalletCopied => 'Адрес кошелька скопирован';

  @override
  String get supportNewRequest => 'Новый запрос в поддержку';

  @override
  String get supportNoRequestsTitle => 'Пока нет запросов в поддержку';

  @override
  String get supportNoRequestsBody =>
      'Начните разговор с командой BrickClub, когда нужна помощь с аккаунтом, KYC, кошельком или инвестициями.';

  @override
  String get supportSendRequest => 'Отправить запрос';

  @override
  String get supportReplyTitle => 'Ответить в поддержку';

  @override
  String get supportSendReply => 'Отправить ответ';

  @override
  String supportMessagesCount(int count) {
    return 'Сообщений: $count';
  }

  @override
  String get supportRequestClosed => 'Запрос закрыт';

  @override
  String get supportReply => 'Ответить';

  @override
  String get supportTalkDirectly => 'Свяжитесь с нами напрямую';

  @override
  String get supportTalkBody =>
      'Предпочитаете быстрый чат? Свяжитесь с командой поддержки BrickClub в WhatsApp или Telegram для более быстрой помощи.';

  @override
  String get supportNoMessagesYet => 'Пока нет сообщений';

  @override
  String get supportTeamName => 'Поддержка BrickClub';

  @override
  String get supportYou => 'Вы';

  @override
  String get supportSubject => 'Тема';

  @override
  String get supportSubjectHint => 'С чем вам нужна помощь?';

  @override
  String get supportMessage => 'Сообщение';

  @override
  String get supportMessageHint => 'Введите ваше сообщение';

  @override
  String get supportEnterSubject => 'Введите тему';

  @override
  String get supportEnterMessage => 'Введите сообщение';

  @override
  String get supportMessageSent => 'Сообщение отправлено';

  @override
  String supportCouldNotOpen(String url) {
    return 'Не удалось открыть $url';
  }
}
