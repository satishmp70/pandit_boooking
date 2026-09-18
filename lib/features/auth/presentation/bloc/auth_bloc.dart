import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/auth_usecases.dart';
import '../../data/session_store.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../auth_access.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required RequestOtp requestOtp,
    required VerifyOtp verifyOtp,
    required SessionStore sessionStore,
  }) : _requestOtp = requestOtp,
       _verifyOtp = verifyOtp,
       _sessionStore = sessionStore,
       super(const AuthState()) {
    on<AuthOtpRequested>(_onOtpRequested);
    on<AuthOtpSubmitted>(_onOtpSubmitted);
    on<AuthSessionRestored>(_onSessionRestored);
    on<AuthLoggedOut>(_onLoggedOut);
    add(const AuthSessionRestored());
  }

  final RequestOtp _requestOtp;
  final VerifyOtp _verifyOtp;
  final SessionStore _sessionStore;

  Future<void> _onOtpRequested(
    AuthOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.requestingOtp, phone: event.phone));
    try {
      await _requestOtp(event.phone);
      emit(state.copyWith(status: AuthStatus.otpRequested));
    } catch (error) {
      emit(state.copyWith(status: AuthStatus.failure, error: error.toString()));
    }
  }

  Future<void> _onOtpSubmitted(
    AuthOtpSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.verifying));
    try {
      final session = await _verifyOtp(phone: state.phone, code: event.code);
      await _sessionStore.write(session);
      AuthAccess.isAuthenticated = true;
      emit(state.copyWith(status: AuthStatus.authenticated, session: session));
    } catch (error) {
      emit(state.copyWith(status: AuthStatus.failure, error: error.toString()));
    }
  }

  Future<void> _onSessionRestored(
    AuthSessionRestored event,
    Emitter<AuthState> emit,
  ) async {
    final session = await _sessionStore.read();
    if (session != null) {
      AuthAccess.isAuthenticated = true;
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          session: session,
          phone: session.phone,
        ),
      );
    }
  }

  Future<void> _onLoggedOut(
    AuthLoggedOut event,
    Emitter<AuthState> emit,
  ) async {
    await _sessionStore.clear();
    AuthAccess.isAuthenticated = false;
    emit(const AuthState());
  }
}
