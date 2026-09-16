import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/auth_usecases.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required RequestOtp requestOtp, required VerifyOtp verifyOtp})
    : _requestOtp = requestOtp,
      _verifyOtp = verifyOtp,
      super(const AuthState()) {
    on<AuthOtpRequested>(_onOtpRequested);
    on<AuthOtpSubmitted>(_onOtpSubmitted);
  }

  final RequestOtp _requestOtp;
  final VerifyOtp _verifyOtp;

  Future<void> _onOtpRequested(AuthOtpRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.requestingOtp, phone: event.phone));
    try {
      await _requestOtp(event.phone);
      emit(state.copyWith(status: AuthStatus.otpRequested));
    } catch (error) {
      emit(state.copyWith(status: AuthStatus.failure, error: error.toString()));
    }
  }

  Future<void> _onOtpSubmitted(AuthOtpSubmitted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.verifying));
    try {
      final session = await _verifyOtp(phone: state.phone, code: event.code);
      emit(state.copyWith(status: AuthStatus.authenticated, session: session));
    } catch (error) {
      emit(state.copyWith(status: AuthStatus.failure, error: error.toString()));
    }
  }
}
