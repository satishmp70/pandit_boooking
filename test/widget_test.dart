import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:pandit_booking/app.dart';
import 'package:pandit_booking/core/widgets/dv_widgets.dart';
import 'package:pandit_booking/core/di/injection_container.dart' as di;

Future<void> _reachHome(WidgetTester tester) async {
  await tester.pumpWidget(const DivyaSevaApp());
  await tester.pumpAndSettle();

  await tester.tap(find.text('Get started'));
  await tester.pumpAndSettle();

  await tester.tap(find.text('Send OTP'));
  await tester.pumpAndSettle();

  await tester.tap(find.text('Verify and continue'));
  await tester.pumpAndSettle();
}

Future<void> _reachHomeWithEnteredData(WidgetTester tester) async {
  await tester.pumpWidget(const DivyaSevaApp());
  await tester.pumpAndSettle();
  await tester.tap(find.text('Get started'));
  await tester.pumpAndSettle();

  final phone = find.byType(TextField).first;
  await tester.enterText(phone, '98765 43210');
  await tester.tap(find.text('Send OTP'));
  await tester.pumpAndSettle();

  final otp = find.byType(TextField);
  for (var i = 0; i < 6; i++) {
    await tester.enterText(otp.at(i), '492700'[i]);
  }
  await tester.tap(find.text('Verify and continue'));
  await tester.pumpAndSettle();
}

Future<void> _tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.tap(finder);
}

void main() {
  testWidgets('splash to home through login and otp', (tester) async {
    di.init();
    await tester.pumpWidget(const DivyaSevaApp());
    await tester.pumpAndSettle();

    expect(find.text('DivyaSeva'), findsOneWidget);
    expect(find.text('Get started'), findsOneWidget);

    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();

    expect(find.text('Book a verified Pandit\nfor your home'), findsOneWidget);
    expect(find.text('Send OTP'), findsOneWidget);

    await tester.tap(find.text('Send OTP'));
    await tester.pumpAndSettle();

    expect(find.text('Enter the 6-digit code'), findsOneWidget);

    await tester.tap(find.text('Verify and continue'));
    await tester.pumpAndSettle();

    expect(find.text('NAMASTE'), findsOneWidget);
    expect(find.text('Sharad Kulkarni'), findsOneWidget);
  });

  testWidgets('home opens the concierge and the service detail', (
    tester,
  ) async {
    di.init();
    await _reachHome(tester);

    await tester.tap(find.text('Not sure which puja you need?'));
    await tester.pumpAndSettle();

    expect(find.text('Spiritual concierge'), findsOneWidget);

    await tester.tap(find.text('Continue with Standard'));
    await tester.pumpAndSettle();

    expect(find.text('Choose a variant'), findsOneWidget);
    expect(find.text('Choose date and location'), findsOneWidget);
  });

  testWidgets('service detail starts the booking wizard', (tester) async {
    di.init();
    await _reachHome(tester);

    await tester.tap(find.text('Not sure which puja you need?'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue with Standard'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Choose date and location'));
    await tester.pumpAndSettle();

    expect(find.text('Where is the puja?'), findsOneWidget);
    expect(find.text('Continue to date and muhurat'), findsOneWidget);
  });

  testWidgets('completes every booking phase with entered selections', (
    tester,
  ) async {
    di.init();
    await _reachHomeWithEnteredData(tester);

    await tester.tap(find.text('Griha Pravesh').first);
    await tester.pumpAndSettle();
    expect(find.text('Choose a variant'), findsOneWidget);

    await _tapVisible(tester, find.text('Extended (Vastu Shanti)'));
    await tester.tap(find.text('Choose date and location'));
    await tester.pumpAndSettle();
    expect(find.text('Where is the puja?'), findsOneWidget);

    await tester.tap(find.textContaining('Parents'));
    await tester.tap(find.text('Continue to date and muhurat'));
    await tester.pumpAndSettle();
    expect(find.text('When?'), findsOneWidget);

    await tester.tap(find.text('Fri 11'));
    await tester.tap(find.text('Abhijit Muhurat'));
    await _tapVisible(tester, find.text('09:30'));
    await tester.tap(find.text('Continue to preferences'));
    await tester.pumpAndSettle();
    expect(find.text('Your preferences'), findsOneWidget);

    await tester.tap(find.text('Marathi'));
    await tester.tap(find.text('Maharashtrian'));
    await tester.tap(find.text('+'));
    await tester.tap(find.text('My parents'));
    await tester.tap(find.text('Continue to samagri'));
    await tester.pumpAndSettle();
    expect(find.text('Samagri'), findsOneWidget);

    await tester.tap(find.textContaining('DivyaSeva Samagri Kit'));
    expect(find.text('Find my Pandit'), findsOneWidget);
    await tester.tap(find.text('Find my Pandit'));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.textContaining('Pandits available'), findsOneWidget);

    await tester.tap(find.text('Select').first);
    await tester.pumpAndSettle();
    expect(find.text('Review and pay'), findsOneWidget);

    await tester.tap(find.text('Proceed to payment'));
    await tester.pumpAndSettle();
    expect(find.text('Payment'), findsOneWidget);

    await tester.tap(find.text('Pay 20% now'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.byWidgetPredicate(
        (widget) => widget is DvButton && widget.label.startsWith('Pay '),
      ),
    );
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 250));
    expect(find.text('Your Pandit is booked'), findsOneWidget);
  });

  testWidgets('account language switch updates the selected language', (
    tester,
  ) async {
    di.init();
    await _reachHome(tester);

    await tester.tap(find.text('Account').last);
    await tester.pumpAndSettle();
    expect(find.text('Language'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);

    await tester.tap(find.text('Language'));
    await tester.pumpAndSettle();
    expect(find.text('Choose app language'), findsOneWidget);
    await tester.tap(find.text('Marathi').last);
    await tester.pumpAndSettle();
    expect(find.text('Marathi'), findsOneWidget);
  });

  testWidgets('preparation checklist and print actions respond', (
    tester,
  ) async {
    di.init();
    await _reachHome(tester);

    await _tapVisible(tester, find.textContaining('Preparation checklist'));
    await tester.pumpAndSettle();
    await _tapVisible(tester, find.text('Preparation checklist'));
    await tester.pumpAndSettle();
    expect(find.text('Get ready'), findsOneWidget);

    await tester.tap(find.text('Print'));
    await tester.pumpAndSettle();
    expect(find.text('Print checklist'), findsOneWidget);
    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();
    final milk = find.text('1 litre fresh milk');
    await tester.scrollUntilVisible(
      milk,
      100,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(milk);
    await tester.pumpAndSettle();
    expect(find.text('4 of 7 ready'), findsOneWidget);
    await tester.tap(find.text('Ask Pandit Suresh a question'));
    await tester.pumpAndSettle();
    expect(find.text('Help & support'), findsOneWidget);
  });
}
