import 'package:brickclub/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('bottom navigation opens every primary screen', (tester) async {
    await tester.pumpWidget(const BrickClubApp());

    expect(find.text('Welcome to The Brick Club'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('nav-market')));
    await tester.pumpAndSettle();
    expect(find.text('Marketplace'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('nav-portfolio')));
    await tester.pumpAndSettle();
    expect(find.text('Your BrickShares'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('nav-more')));
    await tester.pumpAndSettle();
    expect(find.text('More'), findsWidgets);

    await tester.tap(find.byKey(const ValueKey('nav-home')));
    await tester.pumpAndSettle();
    expect(find.text('Welcome to The Brick Club'), findsOneWidget);
  });

  testWidgets('home category opens a filtered marketplace', (tester) async {
    await tester.pumpWidget(const BrickClubApp());

    await tester.tap(find.byKey(const ValueKey('home-Real Estate')));
    await tester.pumpAndSettle();

    expect(find.text('Marketplace'), findsOneWidget);
    expect(find.text('Real Estate'), findsOneWidget);
  });

  testWidgets('marketplace filters and investment flow work', (tester) async {
    await tester.pumpWidget(const BrickClubApp());
    await tester.tap(find.byKey(const ValueKey('nav-market')));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Risk level'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Moderate'));
    await tester.pumpAndSettle();
    expect(find.text('Moderate'), findsOneWidget);

    await tester.drag(
      find.descendant(
        of: find.byType(MarketplaceScreen),
        matching: find.byType(ListView),
      ),
      const Offset(0, -700),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('featured-investment')));
    await tester.pumpAndSettle();
    expect(find.text('BrickShares in Kampala Business Tower'), findsOneWidget);

    await tester.drag(
      find.descendant(
        of: find.byType(InvestmentDetailScreen),
        matching: find.byType(ListView),
      ),
      const Offset(0, -900),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('invest-now')));
    await tester.pumpAndSettle();
    expect(find.text('Confirm investment'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('confirm-investment')));
    await tester.pumpAndSettle();
    expect(find.text('Investment confirmed successfully'), findsOneWidget);
  });
}
