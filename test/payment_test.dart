import 'package:flutter_test/flutter_test.dart';

import 'package:pandit_booking/features/payment/domain/payment_repository.dart';
import 'package:pandit_booking/features/payment/presentation/payment_cubit.dart';

void main() {
  test('mock payment completes create and verify lifecycle', () async {
    final cubit = PaymentCubit(const MockPaymentRepository());
    final paid = await cubit.pay(amount: 100, method: 'upi', reference: 'test');
    expect(paid, isTrue);
    expect(cubit.state.status, PaymentFlowStatus.success);
    await cubit.close();
  });
}
