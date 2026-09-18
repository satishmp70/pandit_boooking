import '../../../../core/errors/app_exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/divya_session.dart';
import '../../domain/repositories/auth_repository.dart';

/// Boundary for the real auth provider. Endpoint names are intentionally not invented.
class RealAuthRepository implements AuthRepository {
  const RealAuthRepository(this._client);

  final ApiClient _client;

  ApiClient get client => _client;

  @override
  Future<void> requestOtp(String phone) async {
    throw const IntegrationNotConfiguredException('Auth API');
  }

  @override
  Future<DivyaSession> verifyOtp({
    required String phone,
    required String code,
  }) async {
    throw const IntegrationNotConfiguredException('Auth API');
  }

  @override
  Future<DivyaSession?> getCurrentSession() async => null;

  @override
  Future<void> logout() async {}
}
