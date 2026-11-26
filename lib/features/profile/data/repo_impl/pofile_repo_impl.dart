import 'dart:typed_data';
import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:herafi_app/app/failure/herafi_failure.dart';
import 'package:herafi_app/app/model/herafi_model.dart' show HerafiModel;
import 'package:herafi_app/core/services/user_service.dart';
import 'package:herafi_app/features/profile/domin/model/review_model.dart';
import 'package:herafi_app/features/profile/domin/repo/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final UserService userService;
  ProfileRepoImpl({required this.userService});

  Future<bool> _hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup(
        'example.com',
      ).timeout(const Duration(seconds: 5));
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    } on TimeoutException {
      return false;
    }
  }

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
  Future<Either<Failure, HerafiModel>> getHerafiById({
    required String herafiId,
  }) async {
    try {
      final herafi = await userService.getHerafiById(herafiId: herafiId);
      if (herafi != null) {
        return Right(herafi);
      }
      return Left(Failure(message: 'User not found'));
    } on FirebaseAuthException catch (e) {
      return Left(Failure.fromCode(e.code));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ReviewModel>>> getReviews({
    required String herafiId,
  }) async {
    try {
      final reviews = await userService.getReviews(herafiId: herafiId);
      return Right(reviews);
    } on FirebaseException catch (e) {
      return Left(Failure.fromCode(e.code));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> hasUserReviewed({
    required String herafiId,
  }) async {
    try {
      final hasReviewed = await userService.hasUserReviewed(herafiId: herafiId);
      return Right(hasReviewed);
    } on FirebaseException catch (e) {
      return Left(Failure.fromCode(e.code));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addReview({
    required String herafiId,
    required String userId,
    required String userName,
    required int rating,
    required String comment,
  }) async {
    

    if (herafiId.isEmpty || userId.isEmpty) {
      return const Left(
        Failure(message: 'Herafi and user IDs are required.'),
      );
    }

    try {
      await userService.addReview(
        herafiId: herafiId,
        userId: userId,
        userName: userName,
        rating: rating,
        comment: comment,
      );
      return const Right(null);
    } on FirebaseException catch (e) {
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
    if (!await _hasInternetConnection()) {
      return const Left(Failure(message: 'No Internet Connection.'));
    }

    try {
      await userService.updateProfileData(
        herafi: herafi,
        selectedImage: selectedImage,
      );

      return const Right(null);
    
    } on FirebaseException catch (e) {
      return Left(Failure.fromCode(e.code));
    } on SocketException {
      return const Left(Failure(message: 'No Internet Connection.'));
    } on TimeoutException {
      return const Left(Failure(message: 'No Internet Connection.'));
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
