import 'package:firebase_auth/firebase_auth.dart';
import 'package:herafi_app/app/failure/herafi_failure.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class OtpLoading extends AuthState {}

class VerifyOtpLoading extends AuthState {}

class CreateAccountLoading extends AuthState {}

/// OTP
class OtpSent extends AuthState {}

class OtpVerified extends AuthState {
  final UserCredential userCredential;

  OtpVerified({required this.userCredential});
}

/// CREATE ACCOUNT
class CreateAccountSuccess extends AuthState {}

class OtpResendCooldown extends AuthState {
  final int seconds;

  OtpResendCooldown(this.seconds);
}

/// ERROR
class AuthError extends AuthState {
  final Failure failure;

  AuthError({required this.failure});
}
