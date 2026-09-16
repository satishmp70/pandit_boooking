import 'package:flutter_test/flutter_test.dart';

import 'package:pandit_booking/app.dart';
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

  testWidgets('home opens the concierge and the service detail', (tester) async {
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
}
