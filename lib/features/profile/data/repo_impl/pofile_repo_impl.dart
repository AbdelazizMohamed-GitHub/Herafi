import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:herafi_app/app/failure/herafi_failure.dart';
import 'package:herafi_app/app/model/herafi_model.dart' show HerafiModel;
import 'package:herafi_app/core/services/user_service.dart';
import 'package:herafi_app/features/profile/domin/repo/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final UserService userService;
  ProfileRepoImpl({required this.userService});

  @override
  Future<Either<Failure, HerafiModel>> getHerafiData() async {
    try {
      final herafiModel = await userService.getHerafiData();
      if (herafiModel != null) {
        return Right(herafiModel);
      } else {
        return Left(Failure(message: 'User not found'));
      }
    } on FirebaseAuthException catch (e) {
      return Left(Failure.fromCode(e.code));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateProfileData({
    required Uint8List? selectedImage,
    required HerafiModel herafi,
  }) async {
    try {
      await userService.updateProfileData(
        herafi: herafi,
        selectedImage: selectedImage,
      );

      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(Failure.fromCode(e.code));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> userLogout() async {
    try {
      await userService.logout();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(Failure.fromCode(e.code));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
