import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:herafi_app/app/failure/herafi_failure.dart';
import 'package:herafi_app/app/model/herafi_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, void>> sendOtp({required String phoneNumber});

  Future<Either<Failure, UserCredential>> verifyOtp({required String otp});

  Future<Either<Failure, HerafiModel?>> getCurrentUser();

  Future<Either<Failure, void>> createAccount({required HerafiModel herafi});

  Future<Either<Failure, void>> logout();
}
