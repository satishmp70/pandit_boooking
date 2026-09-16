import '../../domain/entities/divya_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_mock_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._datasource);

  final AuthMockDataSource _datasource;

  @override
  Future<void> requestOtp(String phone) => _datasource.requestOtp(phone);

  @override
  Future<DivyaSession> verifyOtp({required String phone, required String code}) =>
      _datasource.verifyOtp(phone: phone, code: code);
}
