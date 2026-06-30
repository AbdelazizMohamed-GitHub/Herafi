import 'package:firebase_auth/firebase_auth.dart';
import 'package:herafi_app/app/failure/herafi_failure.dart';
import 'package:herafi_app/app/model/herafi_model.dart';

abstract class AuthState {}

class OtpLoading extends AuthState {}

class VerifyOtpLoading extends AuthState {}

class CreateAccountLoading extends AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

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

/// USER DATA
class UserLoaded extends AuthState {
  final HerafiModel user;

  UserLoaded({required this.user});
}

/// ERROR
class AuthError extends AuthState {
  final String massageFailure;

  AuthError({required this.massageFailure});
}
