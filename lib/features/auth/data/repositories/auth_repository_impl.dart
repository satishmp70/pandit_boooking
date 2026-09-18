import '../../domain/entities/divya_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_mock_datasource.dart';

class MockAuthRepository implements AuthRepository {
  const MockAuthRepository(this._datasource);

  final AuthMockDataSource _datasource;

  @override
  Future<void> requestOtp(String phone) => _datasource.requestOtp(phone);

  @override
  Future<DivyaSession> verifyOtp({
    required String phone,
    required String code,
  }) => _datasource.verifyOtp(phone: phone, code: code);

  @override
  Future<DivyaSession?> getCurrentSession() async => null;

  @override
  Future<void> logout() async {}
}

/// Kept as a small migration alias for existing callers while DI uses the explicit mock name.
class AuthRepositoryImpl extends MockAuthRepository {
  const AuthRepositoryImpl(super.datasource);
}
