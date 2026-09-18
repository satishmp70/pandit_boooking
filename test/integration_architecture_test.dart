import 'package:flutter_test/flutter_test.dart';

import 'package:pandit_booking/core/config/app_config.dart';
import 'package:pandit_booking/core/di/injection_container.dart' as di;
import 'package:pandit_booking/core/errors/app_exceptions.dart';
import 'package:pandit_booking/features/auth/data/datasources/auth_mock_datasource.dart';
import 'package:pandit_booking/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:pandit_booking/features/auth/domain/repositories/auth_repository.dart';
import 'package:pandit_booking/features/payment/domain/payment_repository.dart';
import 'package:pandit_booking/features/divyaseva/data/booking_draft_store.dart';
import 'package:pandit_booking/features/divyaseva/domain/entities/divyaseva_entities.dart';

void main() {
  test(
    'mock auth rejects invalid OTP and accepts the documented test OTP',
    () async {
      const auth = AuthMockDataSource();
      await expectLater(
        auth.verifyOtp(phone: '+91 98765 43210', code: '123456'),
        throwsA(isA<UnauthorizedException>()),
      );
      final session = await auth.verifyOtp(
        phone: '+91 98765 43210',
        code: '492700',
      );
      expect(session.verified, isTrue);
    },
  );

  test('DI selects mock providers in development configuration', () {
    di.init(config: const AppConfig.test());
    expect(di.sl<AuthRepository>(), isA<MockAuthRepository>());
    expect(di.sl<PaymentRepository>(), isA<MockPaymentRepository>());
  });

  test(
    'real provider selection fails explicitly without an API contract',
    () async {
      di.init(
        config: const AppConfig.test(
          authProvider: ProviderMode.real,
          bookingProvider: ProviderMode.real,
          paymentProvider: ProviderMode.real,
        ),
      );
      final auth = di.sl<AuthRepository>();
      await expectLater(
        auth.requestOtp('+91 98765 43210'),
        throwsA(isA<IntegrationNotConfiguredException>()),
      );
    },
  );

  test('mock payment failure is deterministic and does not confirm', () async {
    const payment = MockPaymentRepository(scenario: MockScenario.serverError);
    final result = await payment.createPayment(
      const PaymentRequest(amount: 100, method: 'upi', reference: 'test'),
    );
    expect(result.status, PaymentStatus.failed);
  });

  test('booking draft store restores selections after restart', () async {
    final store = MemoryBookingDraftStore();
    await store.write(const BookingDraft(date: 'Sun 13', people: '15 – 20'));
    final restored = await store.read();
    expect(restored?.date, 'Sun 13');
    expect(restored?.people, '15 – 20');
  });
}
