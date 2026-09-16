import '../../domain/entities/divya_session.dart';

/// Mock auth backend. Any six-digit code is accepted.
class AuthMockDataSource {
  const AuthMockDataSource();

  Future<void> requestOtp(String phone) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
  }

  Future<DivyaSession> verifyOtp({required String phone, required String code}) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    if (code.trim().length != 6) {
      throw const FormatException('Enter the 6-digit code');
    }
    return DivyaSession(phone: phone, verified: true);
  }
}
