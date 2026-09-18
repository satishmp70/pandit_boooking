import '../../../core/errors/app_exceptions.dart';
import '../../../core/network/api_client.dart';
import '../domain/payment_repository.dart';

/// Real payment boundary. Provider contract and server verification are required before enabling it.
class RealPaymentRepository implements PaymentRepository {
  const RealPaymentRepository(this._client);

  final ApiClient _client;

  ApiClient get client => _client;

  @override
  Future<PaymentResult> createPayment(PaymentRequest request) async {
    throw const IntegrationNotConfiguredException('Payment API');
  }

  @override
  Future<PaymentResult> verifyPayment(String paymentId) async {
    throw const IntegrationNotConfiguredException('Payment API');
  }
}
