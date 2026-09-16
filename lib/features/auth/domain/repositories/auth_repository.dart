import '../entities/divya_session.dart';

abstract class AuthRepository {
  Future<void> requestOtp(String phone);

  Future<DivyaSession> verifyOtp({required String phone, required String code});
}
