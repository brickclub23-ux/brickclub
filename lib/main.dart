import 'package:flutter/material.dart';

void main() => runApp(const BrickClubApp());

class BrickClubApp extends StatelessWidget {
  const BrickClubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Brick Club',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: BrickClubColors.background,
        colorScheme: const ColorScheme.dark(
          primary: BrickClubColors.gold,
          surface: BrickClubColors.surface,
        ),
        fontFamily: 'Inter',
        useMaterial3: true,
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: BrickClubColors.highlightSurface,
          contentTextStyle: TextStyle(color: BrickClubColors.textPrimary),
        ),
      ),
      home: const BrickClubShell(),
    );
  }
}

class BrickClubShell extends StatefulWidget {
  const BrickClubShell({super.key});

  @override
  State<BrickClubShell> createState() => _BrickClubShellState();
}

class _BrickClubShellState extends State<BrickClubShell> {
  int _index = 0;
  String? _marketAssetType;

  void _selectPage(int index, {String? assetType}) {
    setState(() {
      _index = index;
      _marketAssetType = assetType;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(onExplore: (asset) => _selectPage(1, assetType: asset)),
      MarketplaceScreen(initialAssetType: _marketAssetType),
      const PortfolioScreen(),
      const MoreScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: BrickClubNavigationBar(
        selectedIndex: _index,
        onSelected: _selectPage,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onExplore});

  final ValueChanged<String> onExplore;

  static const assetTypes = [
    AssetType(
      'Real Estate',
      'Professionally managed real assets',
      BrickClubColors.green,
      Icons.apartment_rounded,
    ),
    AssetType(
      'REITs',
      'Diversified property portfolios',
      BrickClubColors.gold,
      Icons.domain_rounded,
    ),
    AssetType(
      'ETFs',
      'Baskets of companies and sectors',
      BrickClubColors.purple,
      Icons.auto_graph_rounded,
    ),
    AssetType(
      'Index Funds',
      'Major market index exposure',
      BrickClubColors.orange,
      Icons.show_chart_rounded,
    ),
    AssetType(
      'Alternatives',
      'Long-term alternative assets',
      BrickClubColors.bronze,
      Icons.energy_savings_leaf_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PageList(
      children: [
        const PageTitle('Welcome to The Brick Club'),
        const Text(
          'Buy BrickShares in income-producing assets and investment portfolios.',
          style: BrickClubText.body,
        ),
        for (final asset in assetTypes)
          ActionCard(
            key: ValueKey('home-${asset.title}'),
            title: asset.title,
            subtitle: asset.subtitle,
            accent: asset.accent,
            leading: asset.icon,
            onTap: () => onExplore(asset.title),
          ),
        const TrustMessage(),
      ],
    );
  }
}

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key, this.initialAssetType});

  final String? initialAssetType;

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  late String _assetType;
  String _risk = 'All risk levels';
  String _yield = 'All yield types';
  String _payment = 'Crypto wallet at launch';
  String _query = '';

  @override
  void initState() {
    super.initState();
    _assetType = widget.initialAssetType ?? 'All asset types';
  }

  @override
  void didUpdateWidget(covariant MarketplaceScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialAssetType != oldWidget.initialAssetType &&
        widget.initialAssetType != null) {
      _assetType = widget.initialAssetType!;
    }
  }

  Future<void> _choose({
    required String title,
    required List<String> options,
    required ValueChanged<String> onSelected,
  }) async {
    final selection = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: BrickClubColors.surface,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: BrickClubText.section),
              const SizedBox(height: 10),
              for (final option in options)
                ListTile(
                  title: Text(option),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: BrickClubColors.gold,
                  ),
                  onTap: () => Navigator.pop(context, option),
                ),
            ],
          ),
        ),
      ),
    );
    if (selection != null) setState(() => onSelected(selection));
  }

  void _openInvestment() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const InvestmentDetailScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final matches =
        _query.isEmpty ||
        'BrickShares in Luxury Hotel Portfolio'.toLowerCase().contains(
          _query.toLowerCase(),
        );

    return PageList(
      children: [
        const PageTitle('Marketplace'),
        TextField(
          key: const ValueKey('market-search'),
          onChanged: (value) => setState(() => _query = value),
          style: const TextStyle(color: BrickClubColors.textPrimary),
          decoration: InputDecoration(
            hintText: 'Search investments...',
            hintStyle: const TextStyle(color: BrickClubColors.navigationMuted),
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: BrickClubColors.gold,
            ),
            filled: true,
            fillColor: BrickClubColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: BrickClubColors.border),
            ),
          ),
        ),
        ActionCard(
          title: 'Asset type',
          subtitle: _assetType,
          onTap: () => _choose(
            title: 'Asset type',
            options: const [
              'All asset types',
              'Real Estate',
              'REITs',
              'ETFs',
              'Index Funds',
              'Alternatives',
            ],
            onSelected: (value) => _assetType = value,
          ),
        ),
        ActionCard(
          title: 'Risk level',
          subtitle: _risk,
          onTap: () => _choose(
            title: 'Risk level',
            options: const [
              'All risk levels',
              'Conservative',
              'Moderate',
              'Growth',
            ],
            onSelected: (value) => _risk = value,
          ),
        ),
        ActionCard(
          title: 'Yield type',
          subtitle: _yield,
          onTap: () => _choose(
            title: 'Yield type',
            options: const [
              'All yield types',
              'Income',
              'Growth',
              'Income + growth',
            ],
            onSelected: (value) => _yield = value,
          ),
        ),
        ActionCard(
          title: 'Payment method',
          subtitle: _payment,
          onTap: () => _choose(
            title: 'Payment method',
            options: const [
              'Crypto wallet at launch',
              'USDT',
              'USDC',
              'Bitcoin',
            ],
            onSelected: (value) => _payment = value,
          ),
        ),
        if (matches)
          FeaturedInvestment(onTap: _openInvestment)
        else
          const EmptyState(
            icon: Icons.search_off_rounded,
            title: 'No investments found',
            message: 'Try a different search or broaden your filters.',
          ),
      ],
    );
  }
}

class FeaturedInvestment extends StatelessWidget {
  const FeaturedInvestment({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: const ValueKey('featured-investment'),
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: BrickClubColors.surface,
          border: Border.all(color: BrickClubColors.highlightBorder),
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BrickPill(label: 'Real Estate BrickShares'),
            SizedBox(height: 16),
            Text(
              'BrickShares in Luxury Hotel Portfolio',
              style: BrickClubText.section,
            ),
            SizedBox(height: 8),
            Text(
              'Expected yield 7.2%  •  Min. UGX 100K  •  Risk moderate',
              style: BrickClubText.body,
            ),
            SizedBox(height: 16),
            BrickPill(label: 'Invest with crypto', filled: true),
          ],
        ),
      ),
    );
  }
}

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  static const allocations = [
    AssetType(
      'Real Estate',
      '40% allocation',
      BrickClubColors.green,
      Icons.apartment_rounded,
    ),
    AssetType(
      'REITs',
      '25% allocation',
      BrickClubColors.gold,
      Icons.domain_rounded,
    ),
    AssetType(
      'ETFs',
      '20% allocation',
      BrickClubColors.purple,
      Icons.auto_graph_rounded,
    ),
    AssetType(
      'Index Funds',
      '10% allocation',
      BrickClubColors.orange,
      Icons.show_chart_rounded,
    ),
    AssetType(
      'Alternatives',
      '5% allocation',
      BrickClubColors.bronze,
      Icons.energy_savings_leaf_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PageList(
      children: [
        const PageTitle('Your BrickShares'),
        const PortfolioSummary(),
        for (final allocation in allocations)
          ActionCard(
            title: allocation.title,
            subtitle: allocation.subtitle,
            accent: allocation.accent,
            leading: allocation.icon,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => HoldingsScreen(allocation: allocation),
              ),
            ),
          ),
      ],
    );
  }
}

class PortfolioSummary extends StatelessWidget {
  const PortfolioSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BrickClubDecoration.panel(radius: 18),
      child: const Column(
        children: [
          SizedBox(
            width: 132,
            height: 132,
            child: CustomPaint(painter: AllocationPainter()),
          ),
          SizedBox(height: 12),
          Text(
            'UGX 32,500,000',
            style: TextStyle(
              color: BrickClubColors.gold,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6),
          Text('Total portfolio value', style: BrickClubText.body),
        ],
      ),
    );
  }
}

class AllocationPainter extends CustomPainter {
  const AllocationPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    const colors = [
      BrickClubColors.green,
      BrickClubColors.gold,
      BrickClubColors.purple,
      BrickClubColors.orange,
      BrickClubColors.bronze,
    ];
    const values = [0.40, 0.25, 0.20, 0.10, 0.05];
    var start = -1.5708;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.butt;
    for (var index = 0; index < values.length; index++) {
      paint.color = colors[index];
      final sweep = values[index] * 6.28318;
      canvas.drawArc(rect.deflate(12), start, sweep, false, paint);
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HoldingsScreen extends StatelessWidget {
  const HoldingsScreen({super.key, required this.allocation});

  final AssetType allocation;

  @override
  Widget build(BuildContext context) {
    return DetailScaffold(
      title: allocation.title,
      children: [
        Icon(allocation.icon, color: allocation.accent, size: 52),
        Text(allocation.subtitle, style: BrickClubText.section),
        const Text(
          'Your BrickShares are professionally managed and diversified across '
          'eligible opportunities in this category.',
          style: BrickClubText.body,
        ),
        const ActionCard(title: 'Current value', subtitle: 'UGX 13,000,000'),
        const ActionCard(
          title: 'Projected annual income',
          subtitle: 'UGX 975,000',
        ),
        FilledButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const InvestmentDetailScreen()),
          ),
          style: BrickClubDecoration.primaryButton,
          child: const Text('Explore similar BrickShares'),
        ),
      ],
    );
  }
}

class InvestmentDetailScreen extends StatelessWidget {
  const InvestmentDetailScreen({super.key});

  void _showInfo(BuildContext context, String title, String value) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: BrickClubColors.surface,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: BrickClubText.section),
              const SizedBox(height: 10),
              Text(
                value,
                style: const TextStyle(
                  color: BrickClubColors.gold,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Final terms are shown again before you confirm an investment.',
                style: BrickClubText.body,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _invest(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: BrickClubColors.surface,
        title: const Text('Confirm investment'),
        content: const Text(
          'Invest UGX 100,000 from your connected crypto wallet in Kampala '
          'Business Tower?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            key: const ValueKey('confirm-investment'),
            onPressed: () => Navigator.pop(context, true),
            style: BrickClubDecoration.primaryButton,
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Investment confirmed successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DetailScaffold(
      title: 'Investment',
      trailing: TextButton(
        onPressed: () => ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Share link copied'))),
        child: const Text('Share', style: BrickClubText.body),
      ),
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [BrickClubColors.highlightSurface, Color(0xFF392914)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: BrickClubColors.strongBorder),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Center(
            child: Icon(
              Icons.apartment_rounded,
              size: 72,
              color: BrickClubColors.gold,
            ),
          ),
        ),
        const Text(
          'BrickShares in Kampala Business Tower',
          style: TextStyle(
            color: BrickClubColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            height: 1.15,
          ),
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: BrickPill(label: 'Real Estate'),
        ),
        ActionCard(
          title: 'Expected Yield',
          subtitle: '7.5%',
          onTap: () => _showInfo(context, 'Expected Yield', '7.5%'),
        ),
        ActionCard(
          title: 'Minimum Investment',
          subtitle: 'UGX 100,000',
          onTap: () => _showInfo(context, 'Minimum Investment', 'UGX 100,000'),
        ),
        ActionCard(
          title: 'Risk Level',
          subtitle: 'Moderate',
          onTap: () => _showInfo(context, 'Risk Level', 'Moderate'),
        ),
        ActionCard(
          title: 'Investment Period',
          subtitle: '36 months',
          onTap: () => _showInfo(context, 'Investment Period', '36 months'),
        ),
        ActionCard(
          title: 'Payment',
          subtitle: 'Crypto wallet',
          accent: BrickClubColors.gold,
          onTap: () => _showInfo(context, 'Payment', 'Crypto wallet'),
        ),
        FilledButton(
          key: const ValueKey('invest-now'),
          onPressed: () => _invest(context),
          style: BrickClubDecoration.primaryButton,
          child: const Text('Invest Now'),
        ),
      ],
    );
  }
}

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageList(
      children: [
        const PageTitle('More'),
        const Text(
          'Manage your Brick Club account, wallet, and support preferences.',
          style: BrickClubText.body,
        ),
        ActionCard(
          title: 'Profile',
          subtitle: 'Identity and investor details',
          leading: Icons.person_outline_rounded,
          onTap: () => _open(
            context,
            'Profile',
            'Your investor profile is verified and ready.',
          ),
        ),
        ActionCard(
          title: 'Crypto wallet',
          subtitle: 'Connected and verified',
          leading: Icons.account_balance_wallet_outlined,
          accent: BrickClubColors.green,
          onTap: () => _open(
            context,
            'Crypto wallet',
            'Your wallet is connected. Quotes are locked before confirmation.',
          ),
        ),
        ActionCard(
          title: 'Activity',
          subtitle: 'Investments and distributions',
          leading: Icons.receipt_long_outlined,
          onTap: () => _open(
            context,
            'Activity',
            'No new activity. Your latest distributions will appear here.',
          ),
        ),
        ActionCard(
          title: 'Security',
          subtitle: 'Passcode and account protection',
          leading: Icons.shield_outlined,
          onTap: () => _open(
            context,
            'Security',
            'Two-step verification is enabled for this account.',
          ),
        ),
        ActionCard(
          title: 'Help & support',
          subtitle: 'FAQs and contact options',
          leading: Icons.help_outline_rounded,
          onTap: () => _open(
            context,
            'Help & support',
            'Browse common questions or contact the Brick Club support team.',
          ),
        ),
      ],
    );
  }

  void _open(BuildContext context, String title, String message) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailScaffold(
          title: title,
          children: [
            EmptyState(
              icon: Icons.check_circle_outline_rounded,
              title: title,
              message: message,
            ),
          ],
        ),
      ),
    );
  }
}

class BrickClubNavigationBar extends StatelessWidget {
  const BrickClubNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static const items = [
    (Icons.home_rounded, 'Home'),
    (Icons.storefront_outlined, 'Market'),
    (Icons.pie_chart_outline_rounded, 'Portfolio'),
    (Icons.more_horiz_rounded, 'More'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: BrickClubColors.navigation,
        border: Border(top: BorderSide(color: BrickClubColors.strongBorder)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 72,
          child: Row(
            children: [
              for (var index = 0; index < items.length; index++)
                Expanded(
                  child: InkWell(
                    key: ValueKey('nav-${items[index].$2.toLowerCase()}'),
                    onTap: () => onSelected(index),
                    child: _NavigationItem(
                      icon: items[index].$1,
                      label: items[index].$2,
                      selected: selectedIndex == index,
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

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.icon,
    required this.label,
    required this.selected,
  });

  final IconData icon;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? BrickClubColors.gold
        : BrickClubColors.navigationMuted;
    return Semantics(
      selected: selected,
      label: label,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class PageList extends StatelessWidget {
  const PageList({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(18, 24, 18, 24),
        itemCount: children.length,
        separatorBuilder: (_, _) => const SizedBox(height: 14),
        itemBuilder: (_, index) => children[index],
      ),
    );
  }
}

class DetailScaffold extends StatelessWidget {
  const DetailScaffold({
    super.key,
    required this.title,
    required this.children,
    this.trailing,
  });

  final String title;
  final List<Widget> children;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BrickClubColors.background,
        foregroundColor: BrickClubColors.gold,
        title: Text(
          title,
          style: const TextStyle(color: BrickClubColors.textPrimary),
        ),
        actions: trailing == null ? null : [trailing!],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 32),
        itemCount: children.length,
        separatorBuilder: (_, _) => const SizedBox(height: 14),
        itemBuilder: (_, index) => children[index],
      ),
    );
  }
}

class ActionCard extends StatelessWidget {
  const ActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.accent = BrickClubColors.gold,
    this.leading,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final Color accent;
  final IconData? leading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: BrickClubColors.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          constraints: const BoxConstraints(minHeight: 100),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: BrickClubColors.border),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              if (leading != null) ...[
                Icon(leading, color: accent, size: 28),
                const SizedBox(width: 14),
              ],
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: BrickClubText.cardTitle),
                    const SizedBox(height: 3),
                    Text(subtitle, style: BrickClubText.cardBody),
                  ],
                ),
              ),
              if (onTap != null)
                Icon(Icons.chevron_right_rounded, color: accent, size: 27),
            ],
          ),
        ),
      ),
    );
  }
}

class PageTitle extends StatelessWidget {
  const PageTitle(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) => Text(text, style: BrickClubText.title);
}

class TrustMessage extends StatelessWidget {
  const TrustMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BrickClubDecoration.highlight,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Start with crypto funding',
            style: TextStyle(
              color: BrickClubColors.gold,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Verified wallet, quote lock, and confirmation before each investment.',
            style: BrickClubText.body,
          ),
        ],
      ),
    );
  }
}

class BrickPill extends StatelessWidget {
  const BrickPill({super.key, required this.label, this.filled = false});

  final String label;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: filled ? BrickClubColors.gold : BrickClubColors.highlightSurface,
        border: filled ? null : Border.all(color: BrickClubColors.strongBorder),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: filled ? BrickClubColors.background : BrickClubColors.gold,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BrickClubDecoration.panel(radius: 18),
      child: Column(
        children: [
          Icon(icon, color: BrickClubColors.gold, size: 46),
          const SizedBox(height: 16),
          Text(
            title,
            style: BrickClubText.section,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(message, style: BrickClubText.body, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class AssetType {
  const AssetType(this.title, this.subtitle, this.accent, this.icon);
  final String title;
  final String subtitle;
  final Color accent;
  final IconData icon;
}

abstract final class BrickClubText {
  static const title = TextStyle(
    color: BrickClubColors.textPrimary,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.1,
  );
  static const section = TextStyle(
    color: BrickClubColors.textPrimary,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );
  static const body = TextStyle(
    color: BrickClubColors.textSecondary,
    fontSize: 12,
    height: 1.35,
  );
  static const cardTitle = TextStyle(
    color: BrickClubColors.textPrimary,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.32,
  );
  static const cardBody = TextStyle(
    color: BrickClubColors.textSecondary,
    fontSize: 11,
    height: 1.32,
  );
}

abstract final class BrickClubDecoration {
  static BoxDecoration panel({double radius = 14}) => BoxDecoration(
    color: BrickClubColors.surface,
    border: Border.all(color: BrickClubColors.border),
    borderRadius: BorderRadius.circular(radius),
  );

  static final highlight = BoxDecoration(
    color: BrickClubColors.highlightSurface,
    border: Border.all(color: BrickClubColors.highlightBorder),
    borderRadius: BorderRadius.circular(16),
  );

  static final primaryButton = FilledButton.styleFrom(
    backgroundColor: BrickClubColors.gold,
    foregroundColor: BrickClubColors.background,
    minimumSize: const Size.fromHeight(56),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
  );
}

abstract final class BrickClubColors {
  static const background = Color(0xFF080501);
  static const surface = Color(0xFF130E05);
  static const highlightSurface = Color(0xFF201B12);
  static const navigation = Color(0xFF130E05);
  static const textPrimary = Color(0xFFF8FAFC);
  static const textSecondary = Color(0xFFD6C7A3);
  static const navigationMuted = Color(0xFF8C8068);
  static const gold = Color(0xFFEBC262);
  static const green = Color(0xFF22C55E);
  static const purple = Color(0xFFA78BFA);
  static const orange = Color(0xFFF59E0B);
  static const bronze = Color(0xFFB68639);
  static const border = Color(0x8C6A4C22);
  static const strongBorder = Color(0xB36A4C22);
  static const highlightBorder = Color(0x73EBC262);
}
