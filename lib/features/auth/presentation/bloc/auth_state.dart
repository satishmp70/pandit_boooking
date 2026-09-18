import 'package:equatable/equatable.dart';

import '../../domain/entities/divya_session.dart';

enum AuthStatus {
  idle,
  requestingOtp,
  otpRequested,
  verifying,
  authenticated,
  failure,
}

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.idle,
    this.phone = '+91 98204 41207',
    this.session,
    this.error,
  });

  final AuthStatus status;
  final String phone;
  final DivyaSession? session;
  final String? error;

  bool get isBusy =>
      status == AuthStatus.requestingOtp || status == AuthStatus.verifying;

  AuthState copyWith({
    AuthStatus? status,
    String? phone,
    DivyaSession? session,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      phone: phone ?? this.phone,
      session: session ?? this.session,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, phone, session, error];
}
