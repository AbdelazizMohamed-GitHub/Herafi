import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:herafi_app/app/failure/herafi_failure.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/core/services/auth_service.dart';
import 'package:herafi_app/core/services/user_service.dart';
import 'package:herafi_app/features/auth/domin/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthService authService;
  final UserService userService;

  AuthRepoImpl({required this.authService, required this.userService});

  @override
  Future<Either<Failure, void>> sendOtp({required String phoneNumber}) async {
    try {
      await authService.sendOtp(phone: phoneNumber);

      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> verifyOtp({
    required String otp,
  }) async {
    try {
      final result = await authService.verifyOtp(otp: otp);

      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, HerafiModel?>> getCurrentUser() async {
    try {
      final user = await userService.getUserData();

      return Right(user);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createAccount({
    required HerafiModel herafi,
  }) async {
    try {
      await userService.createUserProfile(herafi: herafi);

      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await authService.logout();

      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
