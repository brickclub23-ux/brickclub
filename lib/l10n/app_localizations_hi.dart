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

  @override
  String get installIosTitle => 'iPhone या iPad पर इंस्टॉल करें';

  @override
  String get installIosIntro =>
      'BrickClub को सीधे Safari से अपनी होम स्क्रीन पर जोड़ें — App Store की ज़रूरत नहीं।';

  @override
  String get installIosStep1 => 'Safari के टूलबार में शेयर बटन पर टैप करें।';

  @override
  String get installIosStep2 =>
      'नीचे स्क्रॉल करें और «होम स्क्रीन में जोड़ें» चुनें।';

  @override
  String get installIosStep3 =>
      '«जोड़ें» पर टैप करें — BrickClub आपकी होम स्क्रीन पर आ जाएगा।';

  @override
  String get installAndroidTitle => 'Android पर इंस्टॉल करें';

  @override
  String get installAndroidIntro =>
      'अपने ब्राउज़र से कुछ टैप में BrickClub को अपने डिवाइस में जोड़ें।';

  @override
  String get installAndroidStep1 =>
      'अपना ब्राउज़र मेनू खोलें (ऊपरी कोने में ⋮)।';

  @override
  String get installAndroidStep2 =>
      '«ऐप इंस्टॉल करें» या «होम स्क्रीन में जोड़ें» पर टैप करें।';

  @override
  String get installAndroidStep3 =>
      'पुष्टि करें — BrickClub आपके ऐप ड्रॉअर में दिखेगा।';

  @override
  String get installDesktopTitle => 'डेस्कटॉप पर इंस्टॉल करें';

  @override
  String get installDesktopIntro =>
      'BrickClub को Chrome या Edge से एक ऐप के रूप में इंस्टॉल करें।';

  @override
  String get installDesktopStep1 =>
      'एड्रेस बार में इंस्टॉल आइकन पर क्लिक करें, या ब्राउज़र मेनू खोलें।';

  @override
  String get installDesktopStep2 =>
      'BrickClub को अपनी विंडो में खोलने के लिए «इंस्टॉल» चुनें।';

  @override
  String get installGotIt => 'समझ गया';

  @override
  String get installAlready => 'BrickClub इस डिवाइस पर पहले से इंस्टॉल है।';

  @override
  String get installInstalling => 'BrickClub आपके डिवाइस पर इंस्टॉल हो रहा है…';

  @override
  String get installDismissed =>
      'इंस्टॉल रद्द किया गया। आप कभी भी इंस्टॉल कर सकते हैं।';

  @override
  String get navFeatures => 'विशेषताएँ';

  @override
  String get navHowItWorks => 'यह कैसे काम करता है';

  @override
  String get navTestimonials => 'प्रशंसापत्र';

  @override
  String get landingSignIn => 'साइन इन';

  @override
  String get landingSignUp => 'साइन अप';

  @override
  String get landingJoin => 'शामिल हों';

  @override
  String get landingCreateAccount => 'खाता बनाएँ';

  @override
  String get heroTitle => 'एक सपने से भी\nअधिक के मालिक बनें।';

  @override
  String get heroBody =>
      'एक सुरक्षित ऐप से सत्यापित, संपत्ति-समर्थित BrickShares के माध्यम से वास्तविक स्वामित्व बनाएँ — पारदर्शी प्रदर्शन और भरोसेमंद क्रिप्टो निपटान के साथ।';

  @override
  String get heroInstall => 'ऐप इंस्टॉल करें';

  @override
  String get heroExplore => 'BrickShares देखें';

  @override
  String get proofVerifiedAssets => 'सत्यापित संपत्तियाँ';

  @override
  String get proofTrustedSettlement => 'भरोसेमंद निपटान';

  @override
  String get proofClearPerformance => 'स्पष्ट प्रदर्शन';

  @override
  String get previewPortfolioValue => 'पोर्टफ़ोलियो मूल्य';

  @override
  String get previewMinimum => 'न्यूनतम';

  @override
  String get previewTargetReturn => 'लक्षित रिटर्न';

  @override
  String get heroCardTargetReturn => 'लक्षित वार्षिक रिटर्न';

  @override
  String get assetVerifiedBadge => 'सत्यापित संपत्ति';

  @override
  String get assetSampleDescription => 'आय देने वाली आवासीय संपत्ति';

  @override
  String get assetFunded => 'वित्तपोषित';

  @override
  String get trustDueDiligence => 'संपत्ति यथोचित जाँच';

  @override
  String get trustKycVerified => 'KYC सत्यापित सदस्य';

  @override
  String get trustUsdtSettlement => 'USDT निपटान';

  @override
  String get trustOwnershipRecords => 'स्पष्ट स्वामित्व रिकॉर्ड';

  @override
  String get statTargetReturn => 'औसत लक्षित रिटर्न';

  @override
  String get statMinimum => 'शुरू करने के लिए न्यूनतम';

  @override
  String get statSettlement => 'ऑन-चेन निपटान';

  @override
  String get statVisibility => 'पोर्टफ़ोलियो दृश्यता';

  @override
  String get howTitle => 'साइन अप से स्वामित्व तक।';

  @override
  String get howSubtitle =>
      'हर कदम पर भरोसा चाहने वाले निवेशकों के लिए डिज़ाइन किया गया स्पष्ट मार्ग।';

  @override
  String get howStep1Title => 'बनाएँ और सत्यापित करें';

  @override
  String get howStep1Body =>
      'अपना खाता खोलें, KYC पूरा करें, और एक सत्यापित वॉलेट जोड़ें।';

  @override
  String get howStep2Title => 'BrickShares चुनें';

  @override
  String get howStep2Body =>
      'सत्यापित संपत्तियाँ, लक्षित रिटर्न, जोखिम और स्वामित्व शर्तें देखें।';

  @override
  String get howStep3Title => 'वित्तपोषित करें और ट्रैक करें';

  @override
  String get howStep3Body =>
      'समर्थित क्रिप्टो से सुरक्षित रूप से निपटान करें और अपने पोर्टफ़ोलियो पर नज़र रखें।';

  @override
  String get featuresTitle => 'स्पष्टता के लिए बना,\nसट्टे के लिए नहीं।';

  @override
  String get featuresBody =>
      'हर अवसर महत्वपूर्ण जानकारी सामने लाता है: स्वामित्व संरचना, संपत्ति सत्यापन, लक्षित रिटर्न, जोखिम, वित्तपोषण नेटवर्क और निपटान स्थिति।';

  @override
  String get feature1 => 'सत्यापित संपत्ति दस्तावेज़';

  @override
  String get feature2 => 'पारदर्शी क्रिप्टो दरें और नेटवर्क शुल्क';

  @override
  String get feature3 => 'हर वित्तीय कार्य से पहले पुष्टि';

  @override
  String get testimonialsTitle => 'निवेशकों के भरोसे पर निर्मित।';

  @override
  String get testimonialsSubtitle =>
      'शुरुआती BrickClub सदस्य अनुभव के बारे में जो सबसे अधिक सराहते हैं।';

  @override
  String get testimonial1Quote =>
      'BrickClub महत्वपूर्ण विवरणों को समझना आसान बनाता है। मुझे पता है कि मेरे पास क्या है, यह कैसा प्रदर्शन कर रहा है, और वित्तपोषण से पहले क्या होता है।';

  @override
  String get testimonial1Role => 'उद्यमी, लंदन';

  @override
  String get testimonial2Quote =>
      'सत्यापन और पुष्टि की प्रक्रिया ने मुझे भरोसा दिया। यह एक गंभीर निवेश मंच जैसा लगता है, न कि कोई और क्रिप्टो शॉर्टकट।';

  @override
  String get testimonial2Role => 'उत्पाद प्रमुख, सिंगापुर';

  @override
  String get testimonial3Quote =>
      'मैं एक व्यावहारिक राशि से शुरू कर सकता हूँ और फिर भी उन संपत्तियों तक पहुँच पा सकता हूँ जिन्हें मैं आमतौर पर केवल बाहर से देखता।';

  @override
  String get testimonial3Role => 'सलाहकार, दुबई';

  @override
  String get ctaBadge => 'मिनटों में शुरू करें';

  @override
  String get ctaTitle => 'आपकी अगली संपत्ति यहीं से शुरू हो सकती है।';

  @override
  String get ctaBody =>
      'BrickClub इंस्टॉल करें, अपना खाता बनाएँ, और दीर्घकालिक स्वामित्व के लिए बनाई गई सत्यापित BrickShares देखें।';

  @override
  String get ctaHaveAccount => 'मेरे पास पहले से खाता है';

  @override
  String get ctaSecureKyc => 'सुरक्षित KYC';

  @override
  String get ctaFreeToBrowse => 'ब्राउज़ करना निःशुल्क';

  @override
  String get ctaVerifiedOnly => 'केवल सत्यापित संपत्तियाँ';

  @override
  String get footerCopyright => '© 2026 BrickClub';

  @override
  String get commonViewAll => 'सभी देखें';

  @override
  String get commonCancel => 'रद्द करें';

  @override
  String get navInvest => 'निवेश';

  @override
  String get navWallet => 'वॉलेट';

  @override
  String get navPortfolio => 'पोर्टफ़ोलियो';

  @override
  String get navProfile => 'प्रोफ़ाइल';

  @override
  String get kycGateTitle => 'पहले KYC पूरा करें';

  @override
  String kycGateBody(String status) {
    return 'स्थिति: $status। स्वीकृति के बाद खरीद, निकासी, वॉलेट परिवर्तन और क्रिप्टो निपटान अनलॉक हो जाते हैं।';
  }

  @override
  String get kycGateViewStatus => 'KYC स्थिति देखें';

  @override
  String get kycGateComplete => 'KYC पूरा करें';

  @override
  String get homeFeaturedOpportunity => 'विशेष अवसर';

  @override
  String get homeNoLiveTitle => 'अभी कोई सक्रिय BrickShares नहीं';

  @override
  String get homeNoLiveBody =>
      'प्रकाशित, सत्यापित संपत्तियाँ यहाँ दिखाई देंगी।';

  @override
  String get homeViewInvest => 'निवेश देखें';

  @override
  String get homeYourHoldings => 'आपकी होल्डिंग्स';

  @override
  String get homeRecentActivity => 'हाल की गतिविधि';

  @override
  String get holdingsEmptyTitle => 'अभी कोई होल्डिंग नहीं';

  @override
  String get holdingsEmptyHome =>
      'सत्यापित जमा यहाँ BrickShares के रूप में दिखाई देंगे।';

  @override
  String get activityEmptyTitle => 'अभी कोई गतिविधि नहीं';

  @override
  String get activityEmptyBody =>
      'जमा अनुरोध और निपटान अपडेट यहाँ दिखाई देंगे।';

  @override
  String get dashboardErrorTitle => 'खाता डेटा लोड नहीं हो सका';

  @override
  String get dashboardErrorBody =>
      'बैकएंड कनेक्शन जाँचें और फिर से प्रयास करें।';

  @override
  String get investSubtitle => 'सत्यापित बहु-संपत्ति BrickShares देखें';

  @override
  String get investSearchHint => 'नाम, स्थान, या संपत्ति वर्ग से खोजें';

  @override
  String investAvailable(int count) {
    return 'उपलब्ध $count';
  }

  @override
  String get investFilteredIncome => 'फ़िल्टर की गई आय\nBrickShares';

  @override
  String investOpportunitiesCount(int count) {
    return '$count अवसर';
  }

  @override
  String get investLoadingOpportunities => 'अवसर लोड हो रहे हैं';

  @override
  String get investFiltersAction => 'फ़िल्टर';

  @override
  String get investNoMatchTitle => 'कोई मेल खाने वाली BrickShares नहीं';

  @override
  String get investNoMatchEmpty =>
      'एडमिन द्वारा प्रकाशित सत्यापित संपत्तियाँ यहाँ दिखाई देंगी।';

  @override
  String investNoMatchSearch(String query) {
    return '«$query» से मेल खाने वाली कोई BrickShares नहीं। कोई और खोज आज़माएँ या फ़िल्टर समायोजित करें।';
  }

  @override
  String get investNoMatchFilters =>
      'कोई और संपत्ति वर्ग, जोखिम स्तर, या भुगतान विधि आज़माएँ।';

  @override
  String get investResetFilters => 'फ़िल्टर रीसेट करें';

  @override
  String get walletCryptoActivity => 'क्रिप्टो ऑर्डर गतिविधि';

  @override
  String get walletFundingTitle => 'क्रिप्टो फ़ंडिंग तत्परता';

  @override
  String get walletFundingBody =>
      'धन भेजने से पहले एक सत्यापित वॉलेट जोड़ें। पुष्टि से पहले नेटवर्क, शुल्क, कोट समाप्ति और निपटान स्थिति दिखाई जाती है।';

  @override
  String get walletAddWallet => 'सत्यापित वॉलेट जोड़ें';

  @override
  String get walletVerificationStarted => 'वॉलेट सत्यापन शुरू हुआ';

  @override
  String get walletSettlementTitle => 'निपटान की पुष्टि आवश्यक है';

  @override
  String get walletSettlementBody =>
      'खरीद, निकासी और वॉलेट परिवर्तन के लिए अंतिम पुष्टि आवश्यक है।';

  @override
  String get walletVerifiedBalance => 'सत्यापित वॉलेट शेष';

  @override
  String get portfolioCurrentValue => 'वर्तमान पोर्टफ़ोलियो मूल्य';

  @override
  String get portfolioInvested => 'निवेशित';

  @override
  String get portfolioProfitLoss => 'लाभ / हानि';

  @override
  String get portfolioReturn => 'रिटर्न';

  @override
  String portfolioDividends(String amount) {
    return 'प्राप्त लाभांश: $amount';
  }

  @override
  String get portfolioHoldings => 'होल्डिंग्स';

  @override
  String get portfolioHoldingsEmptyBody =>
      'स्वीकृत निवेश यहाँ स्वतः दिखाई देते हैं।';

  @override
  String get portfolioAllocation => 'आवंटन';

  @override
  String get portfolioAllocationEmptyTitle => 'अभी कोई आवंटन नहीं';

  @override
  String get portfolioAllocationEmptyBody =>
      'जमा सत्यापित होने के बाद आपका संपत्ति मिश्रण दिखाई देता है।';

  @override
  String portfolioInvestedOwnership(String invested, String ownership) {
    return 'निवेशित $invested · $ownership स्वामित्व';
  }

  @override
  String get profileSettings => 'सेटिंग्स';

  @override
  String profileThemeSubtitle(String mode) {
    return '$mode थीम';
  }

  @override
  String get profileSecurityTitle => 'सुरक्षा और गोपनीयता';

  @override
  String get profileSecuritySubtitle => 'सत्यापित वॉलेट और बायोमेट्रिक्स';

  @override
  String get profileDocumentsTitle => 'दस्तावेज़';

  @override
  String get profileDocumentsSubtitle => 'विवरण, जोखिम प्रकटीकरण';

  @override
  String profileRowOpened(String title) {
    return '$title खोला गया';
  }

  @override
  String get profileSupport => 'सहायता';

  @override
  String get profileSupportSubtitle => 'BrickClub टीम को संदेश भेजें';

  @override
  String get profileLogout => 'लॉग आउट';

  @override
  String get profileLogoutConfirmTitle => 'लॉग आउट करें?';

  @override
  String get profileLogoutConfirmBody =>
      'अपने खाते तक पहुँचने के लिए आपको फिर से साइन इन करना होगा।';

  @override
  String get profileDefaultName => 'BrickClub सदस्य';

  @override
  String get profileDefaultSubtitle => 'आपके खाते और BrickShares का विवरण';

  @override
  String get themeScreenTitle => 'थीम';

  @override
  String get themeAppearance => 'रूप';

  @override
  String get themeAppearanceDescription =>
      'चुनें कि इस डिवाइस पर BrickClub कैसा दिखे।';

  @override
  String get themeLight => 'हल्का';

  @override
  String get themeDark => 'गहरा';

  @override
  String get themeSystemDescription => 'इस डिवाइस का स्वतः अनुसरण करें।';

  @override
  String get themeLightDescription =>
      'गहरे टेक्स्ट के साथ उज्ज्वल इंटरफ़ेस उपयोग करें।';

  @override
  String get themeDarkDescription =>
      'क्लासिक गहरा BrickClub इंटरफ़ेस उपयोग करें।';
}
