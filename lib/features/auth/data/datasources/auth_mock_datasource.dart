import '../../domain/entities/divya_session.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/errors/app_exceptions.dart';

/// Deterministic mock auth backend. The valid development OTP is 492700.
class AuthMockDataSource {
  const AuthMockDataSource({this.scenario = MockScenario.success});

  final MockScenario scenario;

  Future<void> requestOtp(String phone) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    _throwForScenario();
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 10) {
      throw const ValidationException('Enter a valid 10-digit mobile number.');
    }
  }

  Future<DivyaSession> verifyOtp({
    required String phone,
    required String code,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    _throwForScenario();
    if (code.trim().length != 6) {
      throw const ValidationException('Enter the 6-digit code.');
    }
    if (code.trim() != '492700') {
      throw const UnauthorizedException('That verification code is incorrect.');
    }
    return DivyaSession(phone: phone, verified: true);
  }

  void _throwForScenario() {
    switch (scenario) {
      case MockScenario.success:
        return;
      case MockScenario.networkError:
        throw const NetworkException();
      case MockScenario.unauthorized:
        throw const UnauthorizedException();
      case MockScenario.serverError:
        throw const ServerException();
      case MockScenario.timeout:
        throw const TimeoutException();
      case MockScenario.invalid:
        throw const ValidationException('The supplied data is invalid.');
    }
  }
}
