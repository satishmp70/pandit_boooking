import '../entities/divya_session.dart';
import '../repositories/auth_repository.dart';

class RequestOtp {
  const RequestOtp(this._repository);
  final AuthRepository _repository;

  Future<void> call(String phone) => _repository.requestOtp(phone);
}

class VerifyOtp {
  const VerifyOtp(this._repository);
  final AuthRepository _repository;

  Future<DivyaSession> call({required String phone, required String code}) =>
      _repository.verifyOtp(phone: phone, code: code);
}
