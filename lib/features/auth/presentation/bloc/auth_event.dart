import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthOtpRequested extends AuthEvent {
  const AuthOtpRequested(this.phone);

  final String phone;

  @override
  List<Object?> get props => [phone];
}

class AuthOtpSubmitted extends AuthEvent {
  const AuthOtpSubmitted(this.code);

  final String code;

  @override
  List<Object?> get props => [code];
}

class AuthSessionRestored extends AuthEvent {
  const AuthSessionRestored();
}

class AuthLoggedOut extends AuthEvent {
  const AuthLoggedOut();
}
