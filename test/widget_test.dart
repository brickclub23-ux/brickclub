import 'package:brickclub/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> signIn(WidgetTester tester) async {
    await tester.pumpWidget(const BrickClubApp());
    expect(find.text('Own more than\na dream.'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('landing-sign-in')));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('sign-in')));
    await tester.pumpAndSettle();
  }

  testWidgets('landing page exposes install and account CTAs', (tester) async {
    tester.view.physicalSize = const Size(1440, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BrickClubApp());

    expect(find.text('Own more than\na dream.'), findsOneWidget);
    expect(find.byKey(const ValueKey('install-app')), findsOneWidget);
    expect(find.text('Create account'), findsOneWidget);
    expect(find.text('Built on investor confidence.'), findsOneWidget);
  });

  testWidgets('admin sign in opens the operations dashboard', (tester) async {
    tester.view.physicalSize = const Size(1440, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BrickClubApp());
    await tester.tap(find.byKey(const ValueKey('landing-sign-in')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('admin-access')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('sign-in')));
    await tester.pumpAndSettle();

    expect(find.text('Admin overview'), findsOneWidget);
    expect(find.text('Total users'), findsOneWidget);
    expect(find.text('Recent crypto payments'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('admin-crypto payments')));
    await tester.pumpAndSettle();
    expect(find.text('Crypto payments'), findsWidgets);
    expect(find.text('0x71B...8E4'), findsOneWidget);
  });

  testWidgets('matches the BrickClub authenticated navigation', (tester) async {
    await signIn(tester);

    expect(find.text('UGX 18.6M'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('nav-invest')));
    await tester.pumpAndSettle();
    expect(find.text('12 opportunities'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('nav-wallet')));
    await tester.pumpAndSettle();
    expect(find.text('UGX 4.2M'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('nav-portfolio')));
    await tester.pumpAndSettle();
    expect(find.text('Allocation'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('nav-more')));
    await tester.pumpAndSettle();
    expect(find.text('Awule Joshua'), findsOneWidget);
  });

  testWidgets('investment purchase flow reaches settlement success', (
    tester,
  ) async {
    await signIn(tester);
    await tester.tap(find.byKey(const ValueKey('nav-invest')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('investment-card')).first);
    await tester.pumpAndSettle();
    expect(find.text('Kololo Heights Income Fund'), findsOneWidget);

    await tester.drag(
      find.descendant(
        of: find.byType(DetailScreen),
        matching: find.byType(SingleChildScrollView),
      ),
      const Offset(0, -350),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('invest-with-crypto')));
    await tester.pumpAndSettle();
    expect(find.text('Confirm funding'), findsOneWidget);

    await tester.drag(
      find.descendant(
        of: find.byType(PaymentScreen),
        matching: find.byType(SingleChildScrollView),
      ),
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('confirm-purchase')));
    await tester.pumpAndSettle();
    expect(find.text('Purchase submitted'), findsOneWidget);
  });
}
