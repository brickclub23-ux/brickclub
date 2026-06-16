import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../features/auth/domain/auth_credentials.dart';
import '../features/auth/domain/auth_repository.dart';

class BrickClubApp extends StatelessWidget {
  const BrickClubApp({super.key, required this.authRepository});

  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrickClub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.gold,
          surface: AppColors.panel,
        ),
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: AppGate(authRepository: authRepository),
    );
  }
}

class AppGate extends StatefulWidget {
  const AppGate({super.key, required this.authRepository});

  final AuthRepository authRepository;

  @override
  State<AppGate> createState() => _AppGateState();
}

class _AppGateState extends State<AppGate> {
  AppDestination destination = AppDestination.landing;

  @override
  Widget build(BuildContext context) {
    return switch (destination) {
      AppDestination.landing => LandingPage(
        onSignIn: () => setState(() => destination = AppDestination.signIn),
        onSignUp: () => setState(() => destination = AppDestination.signUp),
      ),
      AppDestination.signIn => SignInScreen(
        authRepository: widget.authRepository,
        onBack: () => setState(() => destination = AppDestination.landing),
        onMemberSignedIn: () =>
            setState(() => destination = AppDestination.member),
        onAdminSignedIn: () =>
            setState(() => destination = AppDestination.admin),
        onCreateAccount: () =>
            setState(() => destination = AppDestination.signUp),
      ),
      AppDestination.signUp => SignUpScreen(
        authRepository: widget.authRepository,
        onBack: () => setState(() => destination = AppDestination.landing),
        onCreated: () => setState(() => destination = AppDestination.member),
      ),
      AppDestination.member => const BrickClubShell(),
      AppDestination.admin => AdminDashboard(
        onSignOut: () => setState(() => destination = AppDestination.landing),
      ),
    };
  }
}

enum AppDestination { landing, signIn, signUp, member, admin }

class LandingPage extends StatelessWidget {
  const LandingPage({
    super.key,
    required this.onSignIn,
    required this.onSignUp,
  });

  final VoidCallback onSignIn;
  final VoidCallback onSignUp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _LandingHeader(onSignIn: onSignIn, onSignUp: onSignUp),
              _HeroSection(onInstall: () => _showInstallMessage(context)),
              const _TrustStrip(),
              const _HowItWorksSection(),
              const _FeatureSection(),
              const _TestimonialsSection(),
              _FinalCta(
                onInstall: () => _showInstallMessage(context),
                onSignIn: onSignIn,
                onSignUp: onSignUp,
              ),
              _LandingFooter(onSignIn: onSignIn, onSignUp: onSignUp),
            ],
          ),
        ),
      ),
    );
  }

  void _showInstallMessage(BuildContext context) {
    showMessage(context, 'App Store and Google Play links are coming soon');
  }
}

class _LandingHeader extends StatelessWidget {
  const _LandingHeader({required this.onSignIn, required this.onSignUp});

  final VoidCallback onSignIn;
  final VoidCallback onSignUp;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      padding: const EdgeInsets.symmetric(horizontal: 28),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 760;
              return Row(
                children: [
                  const _BrandLockup(),
                  const Spacer(),
                  if (!compact) ...[
                    for (final item in const [
                      ('Features', 'features'),
                      ('How it works', 'how-it-works'),
                      ('Testimonials', 'testimonials'),
                    ])
                      Padding(
                        padding: const EdgeInsets.only(right: 28),
                        child: Text(
                          item.$1,
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                  TextButton(
                    key: const ValueKey('landing-sign-in'),
                    onPressed: onSignIn,
                    child: const Text('Sign in'),
                  ),
                  const SizedBox(width: 10),
                  _WebButton(
                    label: compact ? 'Join' : 'Create account',
                    onPressed: onSignUp,
                    filled: true,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _BrandLockup extends StatelessWidget {
  const _BrandLockup();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _BrickMark(),
        SizedBox(width: 11),
        Text(
          'BrickClub',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 21,
            fontWeight: FontWeight.w800,
            letterSpacing: -.4,
          ),
        ),
      ],
    );
  }
}

class _BrickMark extends StatelessWidget {
  const _BrickMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: AppColors.gold,
        borderRadius: BorderRadius.circular(9),
      ),
      child: const Icon(
        Icons.apartment_rounded,
        color: AppColors.background,
        size: 19,
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.onInstall});

  final VoidCallback onInstall;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(.75, -.15),
          radius: 1.2,
          colors: [Color(0xFF171B1F), AppColors.background],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 70, 28, 74),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final stacked = constraints.maxWidth < 850;
                final copy = _HeroCopy(onInstall: onInstall);
                const visual = _HeroVisual();
                if (stacked) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      copy,
                      const SizedBox(height: 54),
                      const Center(child: visual),
                    ],
                  );
                }
                return Row(
                  children: [
                    Expanded(flex: 10, child: copy),
                    const SizedBox(width: 60),
                    const Expanded(flex: 9, child: visual),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({required this.onInstall});

  final VoidCallback onInstall;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Own more than\na dream.',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 68,
            height: .98,
            fontWeight: FontWeight.w800,
            letterSpacing: -3.1,
          ),
        ),
        const SizedBox(height: 28),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: const Text(
            'Build real ownership through verified property-backed '
            'BrickShares, with transparent performance and trusted crypto '
            'settlement from one secure app.',
            style: TextStyle(
              color: AppColors.secondary,
              fontSize: 18,
              height: 1.55,
            ),
          ),
        ),
        const SizedBox(height: 34),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            _WebButton(
              key: const ValueKey('install-app'),
              label: 'Install the app',
              icon: Icons.download_rounded,
              onPressed: onInstall,
              filled: true,
            ),
            _WebButton(
              label: 'Explore BrickShares',
              icon: Icons.arrow_forward_rounded,
              onPressed: () => showMessage(
                context,
                'Sign in to explore verified BrickShares',
              ),
            ),
          ],
        ),
        const SizedBox(height: 34),
        const Wrap(
          spacing: 28,
          runSpacing: 12,
          children: [
            _ProofPoint(Icons.verified_user_outlined, 'Verified assets'),
            _ProofPoint(Icons.wallet_outlined, 'Trusted settlement'),
            _ProofPoint(Icons.insights_outlined, 'Clear performance'),
          ],
        ),
      ],
    );
  }
}

class _ProofPoint extends StatelessWidget {
  const _ProofPoint(this.icon, this.label);

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.gold, size: 18),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.secondary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _HeroVisual extends StatelessWidget {
  const _HeroVisual();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 520,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            right: 0,
            top: 45,
            child: Container(
              width: 410,
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(34),
                image: const DecorationImage(
                  image: AssetImage('assets/images/kololo_heights_v2.png'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: AppColors.border),
              ),
            ),
          ),
          Positioned(
            left: 4,
            bottom: 0,
            child: Container(
              width: 272,
              height: 480,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(38),
                border: Border.all(color: AppColors.border, width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xA6000000),
                    blurRadius: 42,
                    offset: Offset(0, 24),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: const _PhonePreview(),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 30,
            child: Container(
              width: 220,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.panel,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Target annual return', style: AppText.small),
                  SizedBox(height: 6),
                  Text('12.4%', style: AppText.goldMetric),
                  SizedBox(height: 10),
                  ProgressLine(value: .74, height: 6),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhonePreview extends StatelessWidget {
  const _PhonePreview();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.background,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'BrickClub',
                    style: TextStyle(
                      color: AppColors.gold,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 26,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.panel,
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Text('AJ', style: AppText.tinyLight),
                ),
              ],
            ),
            const SizedBox(height: 18),
            const Text('Portfolio value', style: AppText.small),
            const SizedBox(height: 4),
            const Text(
              'UGX 18.6M',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 27,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/kololo_heights_v2.png',
                height: 116,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Kololo Heights\nIncome Fund',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 17,
                height: 1.12,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Minimum', style: AppText.tinyLight),
                Text('Target return', style: AppText.tinyLight),
              ],
            ),
            const SizedBox(height: 4),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('UGX 250K', style: AppText.goldBody),
                Text('12.4%', style: AppText.cardHeadingSmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TrustStrip extends StatelessWidget {
  const _TrustStrip();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
      color: AppColors.gold,
      child: const Wrap(
        alignment: WrapAlignment.center,
        spacing: 58,
        runSpacing: 18,
        children: [
          _DarkProof('PROPERTY DUE DILIGENCE'),
          _DarkProof('KYC VERIFIED MEMBERS'),
          _DarkProof('USDT SETTLEMENT'),
          _DarkProof('CLEAR OWNERSHIP RECORDS'),
        ],
      ),
    );
  }
}

class _DarkProof extends StatelessWidget {
  const _DarkProof(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: AppColors.background,
        fontSize: 12,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.2,
      ),
    );
  }
}

class _HowItWorksSection extends StatelessWidget {
  const _HowItWorksSection();

  @override
  Widget build(BuildContext context) {
    return const _LandingSection(
      title: 'From signup to ownership.',
      subtitle:
          'A clear path designed for investors who want confidence at every step.',
      child: LayoutBuilder(builder: _buildSteps),
    );
  }

  static Widget _buildSteps(BuildContext context, BoxConstraints constraints) {
    const steps = [
      _Step(
        '01',
        'Create and verify',
        'Open your account, complete KYC, and connect a verified wallet.',
      ),
      _Step(
        '02',
        'Choose BrickShares',
        'Review verified assets, target returns, risks, and ownership terms.',
      ),
      _Step(
        '03',
        'Fund and track',
        'Settle securely with supported crypto and monitor your portfolio.',
      ),
    ];
    if (constraints.maxWidth < 760) {
      return Column(
        children: [
          for (final step in steps)
            Padding(padding: const EdgeInsets.only(bottom: 22), child: step),
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [for (final step in steps) Expanded(child: step)],
    );
  }
}

class _Step extends StatelessWidget {
  const _Step(this.number, this.title, this.body);

  final String number;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: const TextStyle(
              color: AppColors.gold,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 34),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            body,
            style: const TextStyle(
              color: AppColors.secondary,
              fontSize: 15,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureSection extends StatelessWidget {
  const _FeatureSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.surface,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 96),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final details = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Built for clarity,\nnot speculation.',
                      style: _LandingSection.headingStyle,
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Every opportunity brings the important information '
                      'forward: ownership structure, asset verification, '
                      'target returns, risks, funding network, and settlement '
                      'status.',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 17,
                        height: 1.55,
                      ),
                    ),
                    const SizedBox(height: 34),
                    for (final feature in const [
                      (
                        Icons.fact_check_outlined,
                        'Verified asset documentation',
                      ),
                      (
                        Icons.currency_bitcoin_rounded,
                        'Transparent crypto quotes and network fees',
                      ),
                      (
                        Icons.lock_outline_rounded,
                        'Confirmation before every financial action',
                      ),
                    ])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: _FeatureRow(feature.$1, feature.$2),
                      ),
                  ],
                );
                const visual = _AssetReviewPanel();
                if (constraints.maxWidth < 820) {
                  return Column(
                    children: [details, const SizedBox(height: 50), visual],
                  );
                }
                return Row(
                  children: [
                    Expanded(child: details),
                    const SizedBox(width: 74),
                    const Expanded(child: visual),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow(this.icon, this.label);
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.goldSoft,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.gold, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _AssetReviewPanel extends StatelessWidget {
  const _AssetReviewPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.panel,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              'assets/images/kololo_heights_v2.png',
              height: 230,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 22),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Kololo Heights', style: AppText.cardHeading),
              Text('VERIFIED', style: AppText.eyebrow),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Income-producing residential property',
            style: AppText.bodyLarge,
          ),
          const SizedBox(height: 22),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Metric('12.4%', 'Target return', gold: true),
              Metric('UGX 250K', 'Minimum'),
              Metric('62%', 'Funded'),
            ],
          ),
        ],
      ),
    );
  }
}

class _TestimonialsSection extends StatelessWidget {
  const _TestimonialsSection();

  @override
  Widget build(BuildContext context) {
    return const _LandingSection(
      title: 'Built on investor confidence.',
      subtitle: 'What early BrickClub members value most about the experience.',
      child: LayoutBuilder(builder: _buildTestimonials),
    );
  }

  static Widget _buildTestimonials(
    BuildContext context,
    BoxConstraints constraints,
  ) {
    const items = [
      _Testimonial(
        'BrickClub makes the important details easy to understand. I know '
            'what I own, how it is performing, and what happens before I fund.',
        'Sarah N.',
        'Entrepreneur, Kampala',
      ),
      _Testimonial(
        'The verification and confirmation flow gave me confidence. It feels '
            'like a serious investment platform, not another crypto shortcut.',
        'Daniel K.',
        'Product lead, Nairobi',
      ),
      _Testimonial(
        'I can start at a practical amount and still get access to assets I '
            'would normally only watch from the outside.',
        'Amina M.',
        'Consultant, Dar es Salaam',
      ),
    ];
    if (constraints.maxWidth < 820) {
      return Column(
        children: [
          for (final item in items)
            Padding(padding: const EdgeInsets.only(bottom: 18), child: item),
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [for (final item in items) Expanded(child: item)],
    );
  }
}

class _Testimonial extends StatelessWidget {
  const _Testimonial(this.quote, this.name, this.role);

  final String quote;
  final String name;
  final String role;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 18),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.format_quote_rounded, color: AppColors.gold),
          const SizedBox(height: 20),
          Text(
            quote,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              height: 1.55,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 28),
          Text(
            name,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(role, style: AppText.small),
        ],
      ),
    );
  }
}

class _LandingSection extends StatelessWidget {
  const _LandingSection({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  static const headingStyle = TextStyle(
    color: AppColors.primary,
    fontSize: 43,
    height: 1.08,
    fontWeight: FontWeight.w800,
    letterSpacing: -1.6,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.background,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 96),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: headingStyle),
                const SizedBox(height: 16),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 620),
                  child: Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.secondary,
                      fontSize: 17,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 54),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FinalCta extends StatelessWidget {
  const _FinalCta({
    required this.onInstall,
    required this.onSignIn,
    required this.onSignUp,
  });

  final VoidCallback onInstall;
  final VoidCallback onSignIn;
  final VoidCallback onSignUp;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.gold,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 82),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              const Text(
                'Your next asset can start here.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.background,
                  fontSize: 48,
                  height: 1.05,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -2,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Install BrickClub, create your account, and explore verified '
                'BrickShares built for long-term ownership.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.background,
                  fontSize: 17,
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 32),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  _WebButton(
                    label: 'Install the app',
                    icon: Icons.download_rounded,
                    onPressed: onInstall,
                    dark: true,
                  ),
                  _WebButton(
                    label: 'Sign up',
                    onPressed: onSignUp,
                    darkOutline: true,
                  ),
                  TextButton(
                    onPressed: onSignIn,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.background,
                    ),
                    child: const Text('Sign in'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LandingFooter extends StatelessWidget {
  const _LandingFooter({required this.onSignIn, required this.onSignUp});

  final VoidCallback onSignIn;
  final VoidCallback onSignUp;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 34),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Row(
            children: [
              const _BrandLockup(),
              const Spacer(),
              TextButton(onPressed: onSignIn, child: const Text('Sign in')),
              TextButton(onPressed: onSignUp, child: const Text('Sign up')),
              const SizedBox(width: 10),
              const Text('© 2026 BrickClub', style: AppText.small),
            ],
          ),
        ),
      ),
    );
  }
}

class _WebButton extends StatelessWidget {
  const _WebButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.filled = false,
    this.dark = false,
    this.darkOutline = false,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool filled;
  final bool dark;
  final bool darkOutline;

  @override
  Widget build(BuildContext context) {
    final foreground = dark || darkOutline
        ? AppColors.background
        : filled
        ? AppColors.background
        : AppColors.primary;
    final background = dark
        ? AppColors.background
        : filled
        ? AppColors.gold
        : Colors.transparent;
    return SizedBox(
      height: 48,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: icon == null ? const SizedBox.shrink() : Icon(icon, size: 18),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          foregroundColor: foreground,
          backgroundColor: background,
          padding: const EdgeInsets.symmetric(horizontal: 22),
          side: BorderSide(
            color: darkOutline
                ? AppColors.background
                : filled || dark
                ? background
                : AppColors.border,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    super.key,
    required this.authRepository,
    required this.onBack,
    required this.onMemberSignedIn,
    required this.onAdminSignedIn,
    required this.onCreateAccount,
  });

  final AuthRepository authRepository;
  final VoidCallback onBack;
  final VoidCallback onMemberSignedIn;
  final VoidCallback onAdminSignedIn;
  final VoidCallback onCreateAccount;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool adminAccess = false;
  bool signingIn = false;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: 'joshua@brickclub.ug');
    passwordController = TextEditingController(text: 'password10');
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (MediaQuery.sizeOf(context).width >= 900)
            const Expanded(child: _SignInStory()),
          Expanded(
            child: Container(
              color: AppColors.background,
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(28),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 430),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              onPressed: widget.onBack,
                              icon: const Icon(Icons.arrow_back_rounded),
                            ),
                          ),
                          const SizedBox(height: 28),
                          const _BrandLockup(),
                          const SizedBox(height: 54),
                          Text(
                            adminAccess ? 'Admin sign in' : 'Welcome back',
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1.2,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            adminAccess
                                ? 'Access user, asset, and crypto payment operations.'
                                : 'Continue to your BrickShares portfolio.',
                            style: const TextStyle(
                              color: AppColors.secondary,
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 34),
                          const FieldLabel('Email'),
                          const SizedBox(height: 8),
                          AppTextField(
                            key: const ValueKey('email-field'),
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 18),
                          const FieldLabel('Password'),
                          const SizedBox(height: 8),
                          AppTextField(
                            key: const ValueKey('password-field'),
                            controller: passwordController,
                            obscureText: true,
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: _sendPasswordReset,
                              child: const Text('Forgot password?'),
                            ),
                          ),
                          const SizedBox(height: 10),
                          PrimaryButton(
                            key: const ValueKey('sign-in'),
                            label: adminAccess
                                ? 'Open admin dashboard'
                                : signingIn
                                ? 'Signing in...'
                                : 'Sign in securely',
                            onPressed: signingIn ? null : _signIn,
                          ),
                          const SizedBox(height: 24),
                          Center(
                            child: TextButton.icon(
                              key: const ValueKey('admin-access'),
                              onPressed: () {
                                setState(() {
                                  adminAccess = !adminAccess;
                                  emailController.text = adminAccess
                                      ? 'admin@brickclub.ug'
                                      : 'joshua@brickclub.ug';
                                });
                              },
                              icon: Icon(
                                adminAccess
                                    ? Icons.person_outline_rounded
                                    : Icons.admin_panel_settings_outlined,
                              ),
                              label: Text(
                                adminAccess
                                    ? 'Use member sign in'
                                    : 'Sign in as an admin',
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: TextButton(
                              key: const ValueKey('create-account-link'),
                              onPressed: widget.onCreateAccount,
                              child: const Text('Create a BrickClub account'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signIn() async {
    setState(() => signingIn = true);
    try {
      await widget.authRepository.signIn(
        SignInCredentials(
          email: emailController.text,
          password: passwordController.text,
        ),
      );

      if (!mounted) {
        return;
      }

      adminAccess ? widget.onAdminSignedIn() : widget.onMemberSignedIn();
    } catch (error) {
      if (mounted) {
        showMessage(context, _authErrorMessage(error));
      }
    } finally {
      if (mounted) {
        setState(() => signingIn = false);
      }
    }
  }

  Future<void> _sendPasswordReset() async {
    try {
      await widget.authRepository.sendPasswordResetEmail(emailController.text);
      if (mounted) {
        showMessage(context, 'Password reset instructions sent');
      }
    } catch (error) {
      if (mounted) {
        showMessage(context, _authErrorMessage(error));
      }
    }
  }
}

class _SignInStory extends StatelessWidget {
  const _SignInStory();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/kololo_heights_v2.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Color(0x7A0B0D0F), BlendMode.darken),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Ownership, made\nmore accessible.',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 54,
                height: 1.02,
                fontWeight: FontWeight.w800,
                letterSpacing: -2,
              ),
            ),
            SizedBox(height: 22),
            SizedBox(
              width: 500,
              child: Text(
                'Review verified opportunities, settle with confidence, '
                'and keep every asset in view.',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 18,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key, required this.onSignOut});

  final VoidCallback onSignOut;

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int selectedIndex = 0;

  static const sections = [
    ('Overview', Icons.grid_view_rounded),
    ('Users', Icons.people_alt_outlined),
    ('Assets', Icons.apartment_outlined),
    ('Crypto payments', Icons.currency_bitcoin_rounded),
    ('Reports', Icons.bar_chart_rounded),
    ('Settings', Icons.settings_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 980;
    return Scaffold(
      drawer: wide ? null : Drawer(child: _sidebarContent()),
      body: Row(
        children: [
          if (wide) SizedBox(width: 252, child: _sidebarContent()),
          Expanded(
            child: ColoredBox(
              color: AppColors.surface,
              child: Column(
                children: [
                  _AdminTopBar(
                    title: sections[selectedIndex].$1,
                    showMenu: !wide,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(wide ? 30 : 18),
                      child: _AdminSection(index: selectedIndex),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sidebarContent() {
    return ColoredBox(
      color: AppColors.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 26, 18, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: _BrandLockup(),
                ),
              ),
              const SizedBox(height: 46),
              for (var index = 0; index < sections.length; index++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: _AdminNavItem(
                    key: ValueKey('admin-${sections[index].$1.toLowerCase()}'),
                    label: sections[index].$1,
                    icon: sections[index].$2,
                    selected: selectedIndex == index,
                    onTap: () {
                      setState(() => selectedIndex = index);
                      if (Scaffold.maybeOf(context)?.isDrawerOpen ?? false) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              const Spacer(),
              const Divider(color: AppColors.border),
              const SizedBox(height: 12),
              const ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                leading: CircleAvatar(
                  backgroundColor: AppColors.panel,
                  child: Text('JA', style: AppText.goldBody),
                ),
                title: Text('Joshua Admin', style: AppText.fieldLabel),
                subtitle: Text('Super admin', style: AppText.tinyLight),
              ),
              _AdminNavItem(
                label: 'Sign out',
                icon: Icons.logout_rounded,
                selected: false,
                onTap: widget.onSignOut,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AdminNavItem extends StatelessWidget {
  const _AdminNavItem({
    super.key,
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.goldSoft : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: selected ? AppColors.gold : AppColors.muted,
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: selected ? AppColors.primary : AppColors.secondary,
                    fontSize: 14,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AdminTopBar extends StatelessWidget {
  const _AdminTopBar({required this.title, required this.showMenu});

  final String title;
  final bool showMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          if (showMenu) ...[
            Builder(
              builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.menu_rounded),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Text(
            title == 'Overview' ? 'Admin overview' : title,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 23,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
          if (MediaQuery.sizeOf(context).width >= 720)
            SizedBox(
              width: 250,
              height: 42,
              child: TextField(
                style: AppText.fieldLabel,
                decoration: InputDecoration(
                  hintText: 'Search operations',
                  hintStyle: AppText.small,
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppColors.muted,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: AppColors.panel,
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.gold),
                  ),
                ),
              ),
            ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () => showMessage(context, 'No new notifications'),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          const CircleAvatar(
            radius: 17,
            backgroundColor: AppColors.panel,
            child: Text('JA', style: AppText.headerInitials),
          ),
        ],
      ),
    );
  }
}

class _AdminSection extends StatelessWidget {
  const _AdminSection({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return switch (index) {
      0 => const _OverviewPanel(),
      1 => const _UsersPanel(),
      2 => const _AssetsPanel(),
      3 => const _PaymentsPanel(),
      4 => const _ReportsPanel(),
      _ => const _SettingsPanel(),
    };
  }
}

class _OverviewPanel extends StatelessWidget {
  const _OverviewPanel();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Monitor member activity, verified assets, and settlement flow.',
          style: TextStyle(color: AppColors.secondary, fontSize: 14),
        ),
        const SizedBox(height: 26),
        const Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            _AdminMetricCard(
              'Total users',
              '12,480',
              '+8.2%',
              Icons.people_alt_outlined,
            ),
            _AdminMetricCard(
              'Verified assets',
              '48',
              '+4 this month',
              Icons.apartment_outlined,
            ),
            _AdminMetricCard(
              'Payment volume',
              '\$842K',
              '+12.6%',
              Icons.currency_bitcoin_rounded,
            ),
            _AdminMetricCard(
              'Pending reviews',
              '17',
              'Needs action',
              Icons.pending_actions_outlined,
              warning: true,
            ),
          ],
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            const chart = _UserGrowthChart();
            const reviews = _PendingReviews();
            if (constraints.maxWidth < 850) {
              return const Column(
                children: [chart, SizedBox(height: 18), reviews],
              );
            }
            return const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: chart),
                SizedBox(width: 18),
                Expanded(flex: 2, child: reviews),
              ],
            );
          },
        ),
        const SizedBox(height: 20),
        const _AdminPanel(
          title: 'Recent crypto payments',
          action: 'View all',
          child: _PaymentTable(compact: true),
        ),
        const SizedBox(height: 20),
        const _AdminPanel(
          title: 'Recent users',
          action: 'Manage users',
          child: _UserTable(compact: true),
        ),
      ],
    );
  }
}

class _AdminMetricCard extends StatelessWidget {
  const _AdminMetricCard(
    this.label,
    this.value,
    this.change,
    this.icon, {
    this.warning = false,
  });

  final String label;
  final String value;
  final String change;
  final IconData icon;
  final bool warning;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 226,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.small,
                ),
              ),
              const SizedBox(width: 8),
              Icon(icon, size: 20, color: AppColors.gold),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            change,
            style: TextStyle(
              color: warning ? AppColors.warning : const Color(0xFF45C486),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _AdminPanel extends StatelessWidget {
  const _AdminPanel({required this.title, required this.child, this.action});

  final String title;
  final String? action;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.panel,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (action != null)
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(action!, style: AppText.eyebrow),
                ),
            ],
          ),
          const SizedBox(height: 22),
          child,
        ],
      ),
    );
  }
}

class _UserGrowthChart extends StatelessWidget {
  const _UserGrowthChart();

  @override
  Widget build(BuildContext context) {
    return const _AdminPanel(
      title: 'User growth',
      action: 'Last 6 months',
      child: SizedBox(
        height: 220,
        child: _BarChart(
          values: [64, 92, 118, 105, 148, 176],
          labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
        ),
      ),
    );
  }
}

class _BarChart extends StatelessWidget {
  const _BarChart({required this.values, required this.labels});

  final List<double> values;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final maxValue = values.reduce((a, b) => a > b ? a : b);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var index = 0; index < values.length; index++)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        heightFactor: values[index] / maxValue,
                        child: Container(
                          decoration: BoxDecoration(
                            color: index == values.length - 1
                                ? AppColors.gold
                                : AppColors.track,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(7),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(labels[index], style: AppText.tinyLight),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _PendingReviews extends StatelessWidget {
  const _PendingReviews();

  @override
  Widget build(BuildContext context) {
    return const _AdminPanel(
      title: 'Pending asset reviews',
      action: '17 pending',
      child: Column(
        children: [
          _ReviewRow('Bugolobi Logistics REIT', 'Documents updated', '2h'),
          _ReviewRow('Kigali Green Offices', 'Legal review', '5h'),
          _ReviewRow('Nakasero Income Fund', 'Valuation review', '1d'),
          _ReviewRow('Mombasa Storage Trust', 'Issuer verification', '1d'),
        ],
      ),
    );
  }
}

class _ReviewRow extends StatelessWidget {
  const _ReviewRow(this.title, this.status, this.time);
  final String title;
  final String status;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.goldSoft,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.apartment_outlined,
              color: AppColors.gold,
              size: 19,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppText.fieldLabel),
                const SizedBox(height: 3),
                Text(status, style: AppText.tinyLight),
              ],
            ),
          ),
          Text(time, style: AppText.tiny),
        ],
      ),
    );
  }
}

class _UsersPanel extends StatelessWidget {
  const _UsersPanel();

  @override
  Widget build(BuildContext context) {
    return const _SectionPage(
      description: 'Review verification, account status, and member activity.',
      controls: ['All users', 'KYC status', 'Account status'],
      child: _AdminPanel(title: 'Users', child: _UserTable()),
    );
  }
}

class _AssetsPanel extends StatelessWidget {
  const _AssetsPanel();

  @override
  Widget build(BuildContext context) {
    return const _SectionPage(
      description:
          'Manage listings, due diligence, funding progress, and publication.',
      controls: ['All assets', 'Review status', 'Asset type'],
      child: _AdminPanel(title: 'Asset inventory', child: _AssetTable()),
    );
  }
}

class _PaymentsPanel extends StatelessWidget {
  const _PaymentsPanel();

  @override
  Widget build(BuildContext context) {
    return const _SectionPage(
      description:
          'Monitor deposits, settlements, refunds, and network confirmations.',
      controls: ['All payments', 'Network', 'Status'],
      child: _AdminPanel(title: 'Crypto payments', child: _PaymentTable()),
    );
  }
}

class _ReportsPanel extends StatelessWidget {
  const _ReportsPanel();

  @override
  Widget build(BuildContext context) {
    return const _SectionPage(
      description:
          'Operational reporting for member growth, assets, and settlement.',
      controls: ['Last 30 days', 'All regions', 'Export CSV'],
      child: _AdminPanel(
        title: 'Operations report',
        child: SizedBox(
          height: 320,
          child: _BarChart(
            values: [72, 112, 88, 154, 132, 190, 168, 218],
            labels: ['W1', 'W2', 'W3', 'W4', 'W5', 'W6', 'W7', 'W8'],
          ),
        ),
      ),
    );
  }
}

class _SettingsPanel extends StatelessWidget {
  const _SettingsPanel();

  @override
  Widget build(BuildContext context) {
    return const _SectionPage(
      description:
          'Configure approval rules, payment networks, and administrator access.',
      controls: ['Security', 'Payment rails', 'Team access'],
      child: _AdminPanel(
        title: 'Platform settings',
        child: Column(
          children: [
            _SettingRow(
              'Require dual approval',
              'Asset publication and refunds',
            ),
            _SettingRow('USDT settlement', 'Ethereum and Tron enabled'),
            _SettingRow('Admin session timeout', '30 minutes'),
          ],
        ),
      ),
    );
  }
}

class _SectionPage extends StatelessWidget {
  const _SectionPage({
    required this.description,
    required this.controls,
    required this.child,
  });

  final String description;
  final List<String> controls;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(description, style: AppText.bodyLarge),
        const SizedBox(height: 24),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final control in controls) _FilterButton(label: control),
          ],
        ),
        const SizedBox(height: 20),
        child,
      ],
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => showMessage(context, '$label filter selected'),
      icon: const Icon(Icons.tune_rounded, size: 16),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.secondary,
        side: const BorderSide(color: AppColors.border),
        backgroundColor: AppColors.panel,
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  const _SettingRow(this.title, this.value);
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: AppText.fieldLabel),
      subtitle: Text(value, style: AppText.small),
      trailing: Switch(
        value: true,
        onChanged: (_) => showMessage(context, '$title updated'),
        activeThumbColor: AppColors.gold,
      ),
    );
  }
}

class _UserTable extends StatelessWidget {
  const _UserTable({this.compact = false});
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final rows = [
      ('Sarah Namuli', 'sarah@brickclub.ug', 'Verified', 'Active'),
      ('Daniel Kimani', 'daniel@brickclub.co.ke', 'Verified', 'Active'),
      ('Amina Mushi', 'amina@brickclub.co.tz', 'Review', 'Active'),
      ('Joel Mugisha', 'joel@brickclub.rw', 'Pending', 'Restricted'),
      ('Grace Akello', 'grace@brickclub.ug', 'Verified', 'Active'),
    ];
    return _ResponsiveDataTable(
      columns: const ['Member', 'Email', 'KYC', 'Account'],
      rows: [
        for (final row in rows.take(compact ? 4 : rows.length))
          [row.$1, row.$2, row.$3, row.$4],
      ],
      statusColumns: const {2, 3},
    );
  }
}

class _AssetTable extends StatelessWidget {
  const _AssetTable();

  @override
  Widget build(BuildContext context) {
    return const _ResponsiveDataTable(
      columns: ['Asset', 'Type', 'Funded', 'Review', 'Published'],
      rows: [
        ['Kololo Heights', 'Real estate', '62%', 'Verified', 'Live'],
        ['Bugolobi Logistics', 'REIT', '41%', 'Review', 'Draft'],
        ['Kigali Green Offices', 'Real estate', '18%', 'Pending', 'Draft'],
        ['Nakasero Income Fund', 'Fund', '77%', 'Review', 'Paused'],
        ['Mombasa Storage Trust', 'Alternatives', '32%', 'Pending', 'Draft'],
      ],
      statusColumns: {3, 4},
    );
  }
}

class _PaymentTable extends StatelessWidget {
  const _PaymentTable({this.compact = false});
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final rows = [
      ['0x71B...8E4', 'Kololo Heights', 'Tron', '12,500 USDT', 'Confirmed'],
      ['0xA92...1CF', 'Bugolobi REIT', 'Ethereum', '8,200 USDT', 'Pending'],
      ['0x44D...90A', 'Kololo Heights', 'Tron', '4,750 USDT', 'Confirmed'],
      ['0xC08...6B2', 'Kigali Offices', 'Ethereum', '3,100 USDT', 'Review'],
      ['0x1F3...AA9', 'Nakasero Fund', 'Tron', '9,600 USDT', 'Failed'],
    ];
    return _ResponsiveDataTable(
      columns: const ['Wallet', 'Asset', 'Network', 'Amount', 'Status'],
      rows: rows.take(compact ? 4 : rows.length).toList(),
      statusColumns: const {4},
    );
  }
}

class _ResponsiveDataTable extends StatelessWidget {
  const _ResponsiveDataTable({
    required this.columns,
    required this.rows,
    this.statusColumns = const {},
  });

  final List<String> columns;
  final List<List<String>> rows;
  final Set<int> statusColumns;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 680) {
          return Column(
            children: [
              for (final row in rows)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      for (var index = 0; index < columns.length; index++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 92,
                                child: Text(
                                  columns[index],
                                  style: AppText.tiny,
                                ),
                              ),
                              Expanded(
                                child: statusColumns.contains(index)
                                    ? Align(
                                        alignment: Alignment.centerLeft,
                                        child: _StatusChip(row[index]),
                                      )
                                    : Text(
                                        row[index],
                                        style: AppText.fieldLabel,
                                      ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          );
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingTextStyle: const TextStyle(
              color: AppColors.muted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
            dataTextStyle: AppText.fieldLabel,
            headingRowHeight: 42,
            dataRowMinHeight: 52,
            dataRowMaxHeight: 56,
            horizontalMargin: 8,
            columnSpacing: 34,
            dividerThickness: .5,
            border: const TableBorder(
              horizontalInside: BorderSide(color: AppColors.border),
            ),
            columns: [
              for (final column in columns) DataColumn(label: Text(column)),
            ],
            rows: [
              for (final row in rows)
                DataRow(
                  cells: [
                    for (var index = 0; index < row.length; index++)
                      DataCell(
                        statusColumns.contains(index)
                            ? _StatusChip(row[index])
                            : Text(row[index]),
                      ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    final positive = {
      'Verified',
      'Active',
      'Live',
      'Confirmed',
    }.contains(label);
    final warning = {'Review', 'Pending', 'Draft'}.contains(label);
    final color = positive
        ? const Color(0xFF45C486)
        : warning
        ? AppColors.warning
        : const Color(0xFFE36D6D);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
    required this.authRepository,
    required this.onBack,
    required this.onCreated,
  });

  final AuthRepository authRepository;
  final VoidCallback onBack;
  final VoidCallback onCreated;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool accepted = false;
  bool creatingAccount = false;
  final firstNameController = TextEditingController(text: 'Joshua');
  final lastNameController = TextEditingController(text: 'Awule');
  final emailController = TextEditingController(text: 'joshua@brickclub.ug');
  final passwordController = TextEditingController(text: 'password10');
  final confirmPasswordController = TextEditingController(text: 'password10');

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PhoneFrame(
      child: Scaffold(
        body: Container(
          color: AppColors.background,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MockStatusBar(),
                  IconButton(
                    onPressed: widget.onBack,
                    icon: const Icon(Icons.chevron_left, size: 34),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                  ),
                  const Text('BrickClub', style: AppText.authBrand),
                  const SizedBox(height: 4),
                  const Text(
                    'Create your BrickShares account. Wallet verification '
                    'and KYC come next.',
                    style: AppText.bodyLarge,
                  ),
                  const SizedBox(height: 26),
                  Panel(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Create account', style: AppText.h2),
                        const Text(
                          'Use your legal names exactly as they appear on your ID.',
                          style: AppText.body,
                        ),
                        const SizedBox(height: 18),
                        FieldLabel('First name'),
                        const SizedBox(height: 6),
                        AppTextField(
                          controller: firstNameController,
                          compact: true,
                        ),
                        const SizedBox(height: 8),
                        FieldLabel('Last name'),
                        const SizedBox(height: 6),
                        AppTextField(
                          controller: lastNameController,
                          compact: true,
                        ),
                        const SizedBox(height: 8),
                        FieldLabel('Email'),
                        const SizedBox(height: 6),
                        AppTextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          compact: true,
                        ),
                        const SizedBox(height: 8),
                        FieldLabel('Password'),
                        const SizedBox(height: 6),
                        AppTextField(
                          controller: passwordController,
                          obscureText: true,
                          compact: true,
                        ),
                        const SizedBox(height: 8),
                        FieldLabel('Confirm password'),
                        const SizedBox(height: 6),
                        AppTextField(
                          controller: confirmPasswordController,
                          obscureText: true,
                          compact: true,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: accepted,
                              onChanged: (value) =>
                                  setState(() => accepted = value ?? false),
                              side: const BorderSide(color: AppColors.border),
                              activeColor: AppColors.gold,
                            ),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  'I agree to terms, risk disclosures, and '
                                  'settlement confirmation notices.',
                                  style: AppText.small,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  PrimaryButton(
                    label: creatingAccount
                        ? 'Creating account...'
                        : 'Create account',
                    onPressed: accepted && !creatingAccount
                        ? _createAccount
                        : null,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Financial actions require KYC and verified wallet setup '
                    'after account creation.',
                    textAlign: TextAlign.center,
                    style: AppText.disclosure,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _createAccount() async {
    setState(() => creatingAccount = true);
    try {
      await widget.authRepository.createAccount(
        SignUpCredentials(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
        ),
      );

      if (mounted) {
        widget.onCreated();
      }
    } catch (error) {
      if (mounted) {
        showMessage(context, _authErrorMessage(error));
      }
    } finally {
      if (mounted) {
        setState(() => creatingAccount = false);
      }
    }
  }
}

class BrickClubShell extends StatefulWidget {
  const BrickClubShell({super.key});

  @override
  State<BrickClubShell> createState() => _BrickClubShellState();
}

class _BrickClubShellState extends State<BrickClubShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(onInvest: () => setState(() => index = 1)),
      const InvestScreen(),
      const WalletScreen(),
      const PortfolioScreen(),
      const ProfileScreen(),
    ];
    return PhoneFrame(
      child: Scaffold(
        body: IndexedStack(index: index, children: pages),
        bottomNavigationBar: AppBottomNav(
          index: index,
          onChanged: (value) => setState(() => index = value),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onInvest});

  final VoidCallback onInvest;

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'BrickClub',
      children: [
        const _PortfolioOverview(),
        SectionHeading(
          title: 'Featured opportunity',
          action: 'View all',
          onAction: onInvest,
        ),
        InvestmentCard(
          compact: true,
          returnText: '12.4%',
          onTap: () => openDetail(context),
        ),
        const SectionHeading(title: 'Your holdings', action: 'View all'),
        const Panel(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Column(
            children: [
              _HoldingRow(
                title: 'Kololo Heights Income Fund',
                subtitle: '32.45 BrickShares',
                value: 'UGX 6.8M',
                change: '+12.1%',
              ),
              Divider(height: 1, color: AppColors.border),
              _HoldingRow(
                title: 'Naalya Residences Fund',
                subtitle: '18.72 BrickShares',
                value: 'UGX 4.2M',
                change: '+7.3%',
              ),
            ],
          ),
        ),
        const SectionHeading(title: 'Recent activity', action: 'View all'),
        const Panel(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Column(
            children: [
              _ActivityRow(
                icon: Icons.south_west_rounded,
                title: 'Dividend received',
                subtitle: 'Kololo Heights Income Fund',
                value: 'UGX 152,400',
              ),
              Divider(height: 1, color: AppColors.border),
              _ActivityRow(
                icon: Icons.verified_user_outlined,
                title: 'Wallet settlement verified',
                subtitle: 'Secure • Transparent • Trusted',
                value: 'Complete',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PortfolioOverview extends StatelessWidget {
  const _PortfolioOverview();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Portfolio value', style: AppText.bodyLarge),
        const SizedBox(height: 4),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(child: Text('UGX 18.6M', style: AppText.hero)),
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text('+8.4% this year', style: AppText.goldBody),
            ),
          ],
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 96,
          width: double.infinity,
          child: CustomPaint(painter: _PortfolioChartPainter()),
        ),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Jan', style: AppText.tiny),
            Text('Feb', style: AppText.tiny),
            Text('Mar', style: AppText.tiny),
            Text('Apr', style: AppText.tiny),
            Text('May', style: AppText.tiny),
            Text('Jun', style: AppText.tiny),
          ],
        ),
      ],
    );
  }
}

class _PortfolioChartPainter extends CustomPainter {
  const _PortfolioChartPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.border
      ..strokeWidth = 1;
    for (var i = 1; i < 4; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    const values = [
      .64,
      .59,
      .61,
      .55,
      .63,
      .58,
      .66,
      .62,
      .71,
      .68,
      .76,
      .72,
      .79,
      .74,
      .82,
      .77,
      .84,
      .80,
      .88,
      .83,
      .91,
      .86,
      .94,
      .90,
      .98,
      .93,
      1.0,
    ];
    final path = Path();
    for (var i = 0; i < values.length; i++) {
      final x = size.width * i / (values.length - 1);
      final y = size.height - (values[i] * size.height * .78);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = AppColors.gold
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HoldingRow extends StatelessWidget {
  const _HoldingRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.change,
  });

  final String title;
  final String subtitle;
  final String value;
  final String change;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          const _AssetIcon(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppText.fieldLabel),
                const SizedBox(height: 3),
                Text(subtitle, style: AppText.tiny),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value, style: AppText.fieldLabel),
              const SizedBox(height: 3),
              Text(
                change,
                style: const TextStyle(
                  color: AppColors.success,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              color: AppColors.track,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.gold, size: 19),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppText.fieldLabel),
                const SizedBox(height: 3),
                Text(subtitle, style: AppText.tiny),
              ],
            ),
          ),
          Text(value, style: AppText.goldBody),
        ],
      ),
    );
  }
}

class _AssetIcon extends StatelessWidget {
  const _AssetIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.apartment_rounded,
        color: AppColors.gold,
        size: 18,
      ),
    );
  }
}

class InvestScreen extends StatelessWidget {
  const InvestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Invest',
      subtitle: 'Explore verified multi-asset BrickShares',
      children: [
        const Wrap(
          spacing: 10,
          children: [
            ChoicePill(label: 'Available 12', selected: true),
            ChoicePill(label: 'Funded 38'),
            ChoicePill(label: 'Saved'),
          ],
        ),
        Panel(
          radius: 20,
          child: const Row(
            children: [
              Text('8.2%', style: AppText.goldMetric),
              SizedBox(width: 22),
              Expanded(
                child: Text(
                  'Target income\nBrickShares',
                  style: AppText.cardHeadingSmall,
                ),
              ),
            ],
          ),
        ),
        SectionHeading(
          title: '12 opportunities',
          action: 'Filters',
          actionButton: true,
          onAction: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FiltersScreen()),
          ),
        ),
        InvestmentCard(onTap: () => openDetail(context)),
        InvestmentCard(
          category: 'REIT',
          title: 'Bugolobi\nLogistics REIT',
          location: 'Income portfolio',
          minimum: 'UGX 500K',
          returnText: '9.6%',
          onTap: () => openDetail(context),
        ),
      ],
    );
  }
}

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Wallet',
      children: [
        Container(
          height: 170,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.panel, AppColors.surface],
            ),
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(28),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Verified wallet balance', style: AppText.bodyLarge),
              SizedBox(height: 10),
              Text('UGX 4.2M', style: AppText.walletValue),
              SizedBox(height: 8),
              Text(
                'Crypto rails: USDT on Ethereum / Tron',
                style: AppText.eyebrow,
              ),
            ],
          ),
        ),
        const SizedBox(height: 118),
        Panel(
          child: Column(
            children: [
              const Text(
                'Crypto funding readiness',
                style: AppText.cardHeading,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Add a verified wallet before sending funds. Network, fees, '
                'quote expiry, and settlement status are shown before confirmation.',
                textAlign: TextAlign.center,
                style: AppText.body,
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                label: 'Add verified wallet',
                height: 46,
                onPressed: () =>
                    showMessage(context, 'Wallet verification started'),
              ),
            ],
          ),
        ),
        Panel(
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Settlement confirmation required',
                style: AppText.cardHeadingSmall,
              ),
              SizedBox(height: 10),
              Text(
                'Purchases, withdrawals, and wallet changes require final confirmation.',
                style: AppText.body,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Portfolio',
      children: [
        Panel(
          radius: 22,
          padding: const EdgeInsets.all(18),
          child: const SizedBox(
            height: 112,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Total BrickShares allocation', style: AppText.body),
                SizedBox(height: 10),
                Text('UGX 18.6M', style: AppText.portfolioValue),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text('Allocation', style: AppText.h2),
        const AllocationRow('Real Estate', .45, AppColors.gold),
        const AllocationRow('ETF', .22, Color(0xFF38BDF8)),
        const AllocationRow('REIT', .18, Color(0xFF22C55E)),
        const AllocationRow('Alternatives', .15, Color(0xFFF59E0B)),
        const SizedBox(height: 14),
        const Text('Recent activity', style: AppText.h2),
      ],
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Profile',
      simpleHeader: true,
      children: [
        Container(
          padding: const EdgeInsets.all(28),
          color: AppColors.panel,
          child: const Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.track,
                child: Text('AJ', style: AppText.goldMetricSmall),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Awule Joshua', style: AppText.h2),
                    Text(
                      'Your account and BrickShares details',
                      style: AppText.body,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Panel(
          child: const Row(
            children: [
              Icon(
                Icons.verified_user_outlined,
                color: AppColors.gold,
                size: 34,
              ),
              SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Verify account\nto start investing',
                      style: AppText.cardHeadingSmall,
                    ),
                    SizedBox(height: 8),
                    Text('KYC required before purchases', style: AppText.body),
                  ],
                ),
              ),
            ],
          ),
        ),
        for (final item in const [
          ('Settings', 'Theme, currency, alerts'),
          ('Security & privacy', 'Verified wallet and biometrics'),
          ('Documents', 'Statements, risk disclosures'),
          ('Help center', 'Investor support'),
        ])
          ProfileRow(
            title: item.$1,
            subtitle: item.$2,
            onTap: () => showMessage(context, '${item.$1} opened'),
          ),
      ],
    );
  }
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  String asset = 'Real Estate';
  String risk = 'Medium';
  String payment = 'USDT';

  @override
  Widget build(BuildContext context) {
    return PhoneFrame(
      child: Scaffold(
        appBar: detailAppBar(context, 'Filters'),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(22, 30, 22, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Asset class', style: AppText.h2),
              const SizedBox(height: 16),
              FilterChoices(
                values: const ['Real Estate', 'REIT', 'ETF', 'Index'],
                selected: asset,
                onChanged: (value) => setState(() => asset = value),
              ),
              const SizedBox(height: 62),
              const Text('Risk level', style: AppText.h2),
              const SizedBox(height: 16),
              FilterChoices(
                values: const ['Low', 'Medium', 'High'],
                selected: risk,
                onChanged: (value) => setState(() => risk = value),
              ),
              const Spacer(),
              const Text('Payment method', style: AppText.h2),
              const SizedBox(height: 16),
              FilterChoices(
                values: const ['USDT', 'USDC', 'BTC', 'UGX Wallet'],
                selected: payment,
                onChanged: (value) => setState(() => payment = value),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 197,
                  child: PrimaryButton(
                    key: const ValueKey('show-brickshares'),
                    label: 'Show 5 BrickShares',
                    height: 46,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PhoneFrame(
      child: Scaffold(
        appBar: detailAppBar(context, 'BrickShares'),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      'assets/images/kololo_heights_v2.png',
                      height: 206,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Positioned(
                    top: 16,
                    left: 14,
                    child: ChoicePill(label: 'Verified docs', selected: true),
                  ),
                ],
              ),
              const SizedBox(height: 26),
              const Text(
                'Kololo Heights Income Fund',
                style: AppText.detailTitle,
              ),
              const Text(
                'Real Estate BrickShares | Kampala Central',
                style: AppText.body,
              ),
              const SizedBox(height: 20),
              const Panel(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Metric('8.2%', 'Target return', gold: true),
                        ),
                        Expanded(child: Metric('UGX 850K', 'Minimum')),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: Metric('36 mo', 'Liquidity')),
                        Expanded(child: Metric('Medium', 'Risk level')),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Panel(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Funding status',
                            style: AppText.cardHeadingSmall,
                          ),
                        ),
                        Text('62% funded', style: AppText.goldBody),
                      ],
                    ),
                    SizedBox(height: 14),
                    ProgressLine(value: .62),
                    SizedBox(height: 12),
                    Text(
                      'USDT and USDC accepted. Quote expires before '
                      'settlement confirmation.',
                      style: AppText.small,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                key: const ValueKey('invest-with-crypto'),
                label: 'Invest with crypto funding',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PaymentScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PhoneFrame(
      child: Scaffold(
        appBar: detailAppBar(context, 'Confirm funding'),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            children: [
              const Panel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Buying BrickShares', style: AppText.eyebrow),
                    SizedBox(height: 12),
                    Text(
                      'Kololo Heights Income\nFund',
                      style: AppText.cardHeading,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const Panel(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Crypto quote',
                            style: AppText.cardHeading,
                          ),
                        ),
                        Text('Expires in 09:42', style: AppText.warning),
                      ],
                    ),
                    SizedBox(height: 18),
                    QuoteRow('Network', 'USDT - TRC20'),
                    QuoteRow('Quote', '445.18 USDT'),
                    QuoteRow('Network fee', '1.00 USDT'),
                    QuoteRow(
                      'Settlement',
                      'Pending confirmation',
                      warning: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const Panel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Confirmable financial action',
                      style: AppText.cardHeadingSmall,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'You are authorizing a crypto-funded BrickShares '
                      'purchase. Settlement may take network confirmations.',
                      style: AppText.body,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              PrimaryButton(
                key: const ValueKey('confirm-purchase'),
                label: 'Confirm purchase',
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const SuccessScreen()),
                ),
              ),
              const SizedBox(height: 14),
              SecondaryButton(
                label: 'Cancel',
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PhoneFrame(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 80, 20, 24),
            child: Column(
              children: [
                Container(
                  width: 128,
                  height: 128,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.track,
                    border: Border.all(color: AppColors.gold),
                    shape: BoxShape.circle,
                  ),
                  child: const Text('OK', style: AppText.goldMetricSmall),
                ),
                const SizedBox(height: 44),
                const Text('Purchase submitted', style: AppText.h1),
                const SizedBox(height: 12),
                Text(
                  'Your crypto payment is awaiting network confirmations. '
                  'We will update settlement status automatically.',
                  textAlign: TextAlign.center,
                  style: AppText.bodyLarge,
                ),
                const SizedBox(height: 38),
                const Panel(
                  child: SizedBox(
                    height: 84,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Settlement status',
                            style: AppText.bodyLarge,
                          ),
                        ),
                        Text('Confirming', style: AppText.warning),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 62),
                PrimaryButton(
                  key: const ValueKey('view-portfolio'),
                  label: 'View portfolio',
                  onPressed: () =>
                      Navigator.popUntil(context, (route) => route.isFirst),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppPage extends StatelessWidget {
  const AppPage({
    super.key,
    required this.title,
    required this.children,
    this.subtitle,
    this.simpleHeader = false,
  });

  final String title;
  final String? subtitle;
  final bool simpleHeader;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MockStatusBar(),
                  const SizedBox(height: 8),
                  if (simpleHeader)
                    Center(child: Text(title, style: AppText.topTitle))
                  else
                    AppHeader(title: title),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(subtitle!, style: AppText.body),
                  ],
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
            sliver: SliverList.separated(
              itemCount: children.length,
              itemBuilder: (_, index) => children[index],
              separatorBuilder: (_, _) => const SizedBox(height: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class AppHeader extends StatelessWidget {
  const AppHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.gold),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.apartment_rounded,
              color: AppColors.gold,
              size: 19,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(title, style: AppText.topTitle)),
          HeaderCircle(
            child: const Icon(
              Icons.notifications_none_rounded,
              color: AppColors.secondary,
              size: 18,
            ),
            onTap: () => showMessage(context, 'No new notifications'),
          ),
          const SizedBox(width: 9),
          HeaderCircle(
            child: const Text('AJ', style: AppText.headerInitials),
            onTap: () => showMessage(context, 'Profile is in More'),
          ),
        ],
      ),
    );
  }
}

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.index, required this.onChanged});

  final int index;
  final ValueChanged<int> onChanged;

  static const items = [
    (Icons.home_outlined, Icons.home_rounded, 'Home'),
    (Icons.trending_up_rounded, Icons.trending_up_rounded, 'Invest'),
    (
      Icons.account_balance_wallet_outlined,
      Icons.account_balance_wallet_rounded,
      'Wallet',
    ),
    (Icons.pie_chart_outline_rounded, Icons.pie_chart_rounded, 'Portfolio'),
    (Icons.menu_rounded, Icons.menu_rounded, 'More'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 72,
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: _BottomNavItem(
                    key: ValueKey('nav-${items[i].$3.toLowerCase()}'),
                    icon: items[i].$1,
                    selectedIcon: items[i].$2,
                    label: items[i].$3,
                    selected: i == index,
                    onTap: () => onChanged(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    super.key,
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              width: 42,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? AppColors.goldSoft : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                selected ? selectedIcon : icon,
                color: selected ? AppColors.gold : AppColors.muted,
                size: 21,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 180),
              style: TextStyle(
                color: selected ? AppColors.gold : AppColors.muted,
                fontSize: 10,
                height: 1,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
              child: Text(label, maxLines: 1),
            ),
          ],
        ),
      ),
    );
  }
}

class InvestmentCard extends StatelessWidget {
  const InvestmentCard({
    super.key,
    required this.onTap,
    this.compact = false,
    this.category = 'Real Estate',
    this.title = 'Kololo Heights\nIncome Fund',
    this.location = 'Kampala Central',
    this.minimum = 'UGX 250K',
    this.returnText = '11.8%',
  });

  final VoidCallback onTap;
  final bool compact;
  final String category;
  final String title;
  final String location;
  final String minimum;
  final String returnText;

  @override
  Widget build(BuildContext context) {
    final height = compact ? 176.0 : 188.0;
    return Material(
      color: AppColors.panel,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        key: const ValueKey('investment-card'),
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: height,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              SizedBox(
                width: compact ? 134 : 128,
                height: height,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(
                        'assets/images/kololo_heights_v2.png',
                        width: compact ? 134 : 128,
                        height: height,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: ChoicePill(label: category, selected: true),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 12, 18, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title, style: AppText.investmentTitle),
                      const SizedBox(height: 4),
                      Text(location, style: AppText.small),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              minimum,
                              style: AppText.goldBody,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(returnText, style: AppText.cardHeadingSmall),
                        ],
                      ),
                      if (!compact) ...[
                        const SizedBox(height: 16),
                        const ProgressLine(value: .62, height: 6),
                        const SizedBox(height: 7),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Crypto funding', style: AppText.tiny),
                            Text('62%', style: AppText.tinyLight),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Panel extends StatelessWidget {
  const Panel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.radius = 18,
  });

  final Widget child;
  final EdgeInsets padding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.panel,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.title,
    this.action,
    this.onAction,
    this.actionButton = false,
  });

  final String title;
  final String? action;
  final VoidCallback? onAction;
  final bool actionButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(title, style: AppText.h2)),
        if (action != null)
          actionButton
              ? SecondaryButton(
                  label: action!,
                  onPressed: onAction,
                  compact: true,
                )
              : TextButton(
                  onPressed: onAction,
                  child: Text(action!, style: AppText.body),
                ),
      ],
    );
  }
}

class ChoicePill extends StatelessWidget {
  const ChoicePill({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(17),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? AppColors.gold : AppColors.panel,
          border: Border.all(
            color: selected ? AppColors.gold : AppColors.border,
          ),
          borderRadius: BorderRadius.circular(17),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? AppColors.background : AppColors.secondary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class FilterChoices extends StatelessWidget {
  const FilterChoices({
    super.key,
    required this.values,
    required this.selected,
    required this.onChanged,
  });

  final List<String> values;
  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final value in values)
          ChoicePill(
            label: value,
            selected: selected == value,
            onTap: () => onChanged(value),
          ),
      ],
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.height = 50,
  });

  final String label;
  final VoidCallback? onPressed;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.gold,
          disabledBackgroundColor: AppColors.muted,
          foregroundColor: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        child: Text(label),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.compact = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: compact ? 95 : double.infinity,
      height: compact ? 38 : 46,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.border),
          backgroundColor: AppColors.panel,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.initialValue,
    this.controller,
    this.obscureText = false,
    this.compact = false,
    this.keyboardType,
  });

  final String? initialValue;
  final TextEditingController? controller;
  final bool obscureText;
  final bool compact;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: compact ? 44 : 50,
      child: TextFormField(
        controller: controller,
        initialValue: controller == null ? initialValue : null,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 14, color: AppColors.primary),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          filled: true,
          fillColor: AppColors.background,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(compact ? 12 : 14),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(compact ? 12 : 14),
            borderSide: const BorderSide(color: AppColors.border),
          ),
        ),
      ),
    );
  }
}

class FieldLabel extends StatelessWidget {
  const FieldLabel(this.label, {super.key});
  final String label;

  @override
  Widget build(BuildContext context) => Text(label, style: AppText.fieldLabel);
}

class ProfileRow extends StatelessWidget {
  const ProfileRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.panel,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: AppText.cardHeadingSmall),
            Text(subtitle, style: AppText.tinyLight),
          ],
        ),
      ),
    );
  }
}

class AllocationRow extends StatelessWidget {
  const AllocationRow(this.label, this.value, this.color, {super.key});

  final String label;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 128, child: Text(label, style: AppText.fieldLabel)),
          Expanded(
            child: ProgressLine(value: value, color: color, height: 7),
          ),
        ],
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    super.key,
    required this.value,
    this.color = AppColors.gold,
    this.height = 8,
  });

  final double value;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: LinearProgressIndicator(
        value: value,
        minHeight: height,
        color: color,
        backgroundColor: AppColors.track,
      ),
    );
  }
}

class Metric extends StatelessWidget {
  const Metric(this.value, this.label, {super.key, this.gold = false});

  final String value;
  final String label;
  final bool gold;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            color: gold ? AppColors.gold : AppColors.primary,
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: AppText.small),
      ],
    );
  }
}

class QuoteRow extends StatelessWidget {
  const QuoteRow(this.label, this.value, {super.key, this.warning = false});

  final String label;
  final String value;
  final bool warning;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(child: Text(label, style: AppText.body)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: warning ? AppText.warning : AppText.fieldLabel,
            ),
          ),
        ],
      ),
    );
  }
}

class MockStatusBar extends StatelessWidget {
  const MockStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 18,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('9:41', style: AppText.status),
          Row(
            children: [
              StatusBlock(width: 18),
              SizedBox(width: 6),
              StatusBlock(width: 15),
              SizedBox(width: 7),
              StatusBlock(width: 22, height: 12),
            ],
          ),
        ],
      ),
    );
  }
}

class StatusBlock extends StatelessWidget {
  const StatusBlock({super.key, required this.width, this.height = 8});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) => Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: AppColors.secondary,
      borderRadius: BorderRadius.circular(3),
    ),
  );
}

class HeaderPill extends StatelessWidget {
  const HeaderPill(this.label, {super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 31,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.panel,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(label, style: AppText.headerInitials),
    );
  }
}

class HeaderCircle extends StatelessWidget {
  const HeaderCircle({super.key, required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.panel,
          border: Border.all(color: AppColors.border),
          shape: BoxShape.circle,
        ),
        child: child,
      ),
    );
  }
}

class PhoneFrame extends StatelessWidget {
  const PhoneFrame({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 393),
          child: Material(color: AppColors.background, child: child),
        ),
      ),
    );
  }
}

PreferredSizeWidget detailAppBar(BuildContext context, String title) {
  return AppBar(
    toolbarHeight: 76,
    backgroundColor: AppColors.background,
    foregroundColor: AppColors.primary,
    centerTitle: true,
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.chevron_left, size: 32),
    ),
    title: Text(title, style: AppText.detailAppBar),
    bottom: const PreferredSize(
      preferredSize: Size.fromHeight(1),
      child: Divider(height: 1, color: AppColors.border),
    ),
  );
}

void openDetail(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const DetailScreen()),
  );
}

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.panel),
    );
}

String _authErrorMessage(Object error) {
  if (error is FirebaseAuthException) {
    return switch (error.code) {
      'invalid-email' => 'Enter a valid email address.',
      'user-not-found' => 'No account exists for that email.',
      'wrong-password' ||
      'invalid-credential' => 'Email or password is incorrect.',
      'email-already-in-use' => 'An account already exists for that email.',
      'weak-password' => 'Use a stronger password.',
      'network-request-failed' =>
        'Firebase is unreachable. Check that the emulator is running.',
      _ => error.message ?? 'Authentication failed. Please try again.',
    };
  }

  return error.toString().replaceFirst('Exception: ', '');
}

abstract final class AppColors {
  static const background = Color(0xFF0B0D0F);
  static const surface = Color(0xFF101316);
  static const panel = Color(0xFF15191D);
  static const track = Color(0xFF20252A);
  static const border = Color(0xFF2A3036);
  static const gold = Color(0xFFD8A94F);
  static const goldSoft = Color(0x1FD8A94F);
  static const primary = Color(0xFFF4F5F6);
  static const secondary = Color(0xFFB2B7BD);
  static const muted = Color(0xFF747B83);
  static const success = Color(0xFF51B96B);
  static const warning = Color(0xFFF59E0B);
}

abstract final class AppText {
  static const status = TextStyle(
    color: AppColors.secondary,
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );
  static const authBrand = TextStyle(
    color: AppColors.primary,
    fontSize: 30,
    fontWeight: FontWeight.w700,
  );
  static const h1 = TextStyle(
    color: AppColors.primary,
    fontSize: 28,
    fontWeight: FontWeight.w700,
  );
  static const h2 = TextStyle(
    color: AppColors.primary,
    fontSize: 22,
    height: 1.2,
    fontWeight: FontWeight.w700,
  );
  static const topTitle = TextStyle(
    color: AppColors.primary,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: -.4,
  );
  static const detailAppBar = TextStyle(
    color: AppColors.primary,
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );
  static const bodyLarge = TextStyle(
    color: AppColors.secondary,
    fontSize: 14,
    height: 1.3,
    fontWeight: FontWeight.w500,
  );
  static const body = TextStyle(
    color: AppColors.secondary,
    fontSize: 12,
    height: 1.3,
    fontWeight: FontWeight.w500,
  );
  static const small = TextStyle(
    color: AppColors.secondary,
    fontSize: 11,
    height: 1.25,
    fontWeight: FontWeight.w500,
  );
  static const tiny = TextStyle(color: AppColors.muted, fontSize: 10);
  static const tinyLight = TextStyle(color: AppColors.secondary, fontSize: 10);
  static const disclosure = TextStyle(
    color: AppColors.muted,
    fontSize: 12,
    height: 1.25,
  );
  static const fieldLabel = TextStyle(
    color: AppColors.secondary,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
  static const eyebrow = TextStyle(
    color: AppColors.gold,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
  static const goldBody = TextStyle(
    color: AppColors.gold,
    fontSize: 13,
    fontWeight: FontWeight.w700,
  );
  static const warning = TextStyle(
    color: AppColors.warning,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
  static const hero = TextStyle(
    color: AppColors.primary,
    fontSize: 42,
    height: 1.05,
    fontWeight: FontWeight.w800,
    letterSpacing: -1.5,
  );
  static const walletValue = TextStyle(
    color: AppColors.primary,
    fontSize: 35,
    fontWeight: FontWeight.w700,
  );
  static const portfolioValue = TextStyle(
    color: AppColors.primary,
    fontSize: 34,
    fontWeight: FontWeight.w700,
  );
  static const detailTitle = TextStyle(
    color: AppColors.primary,
    fontSize: 27,
    height: 1.25,
    fontWeight: FontWeight.w700,
  );
  static const cardHeading = TextStyle(
    color: AppColors.primary,
    fontSize: 20,
    height: 1.15,
    fontWeight: FontWeight.w700,
  );
  static const cardHeadingSmall = TextStyle(
    color: AppColors.primary,
    fontSize: 16,
    height: 1.2,
    fontWeight: FontWeight.w700,
  );
  static const investmentTitle = TextStyle(
    color: AppColors.primary,
    fontSize: 17,
    height: 1.15,
    fontWeight: FontWeight.w700,
  );
  static const goldMetric = TextStyle(
    color: AppColors.gold,
    fontSize: 34,
    fontWeight: FontWeight.w700,
  );
  static const goldMetricSmall = TextStyle(
    color: AppColors.gold,
    fontSize: 19,
    fontWeight: FontWeight.w700,
  );
  static const brandMark = TextStyle(
    color: AppColors.gold,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
  static const headerIcon = TextStyle(
    color: AppColors.primary,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );
  static const headerInitials = TextStyle(
    color: AppColors.gold,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
}
