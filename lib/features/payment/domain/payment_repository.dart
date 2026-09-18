import '../../../core/config/app_config.dart';

class PaymentRequest {
  const PaymentRequest({
    required this.amount,
    required this.method,
    required this.reference,
  });

  final int amount;
  final String method;
  final String reference;
}

enum PaymentStatus { success, failed, cancelled, pending }

class PaymentResult {
  const PaymentResult({required this.status, this.paymentId, this.message});

  final PaymentStatus status;
  final String? paymentId;
  final String? message;
}

abstract interface class PaymentRepository {
  Future<PaymentResult> createPayment(PaymentRequest request);

  Future<PaymentResult> verifyPayment(String paymentId);
}

class MockPaymentRepository implements PaymentRepository {
  const MockPaymentRepository({this.scenario = MockScenario.success});

  final MockScenario scenario;

  @override
  Future<PaymentResult> createPayment(PaymentRequest request) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    switch (scenario) {
      case MockScenario.success:
        return const PaymentResult(
          status: PaymentStatus.success,
          paymentId: 'mock-pay-24817',
        );
      case MockScenario.networkError:
        throw Exception('network');
      case MockScenario.timeout:
        throw Exception('timeout');
      case MockScenario.unauthorized:
        return const PaymentResult(
          status: PaymentStatus.failed,
          message: 'Payment session expired.',
        );
      case MockScenario.serverError:
        return const PaymentResult(
          status: PaymentStatus.failed,
          message: 'Payment service unavailable.',
        );
      case MockScenario.invalid:
        return const PaymentResult(
          status: PaymentStatus.failed,
          message: 'Payment details are invalid.',
        );
    }
  }

  @override
  Future<PaymentResult> verifyPayment(String paymentId) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return const PaymentResult(
      status: PaymentStatus.success,
      paymentId: 'mock-pay-24817',
    );
  }
}
