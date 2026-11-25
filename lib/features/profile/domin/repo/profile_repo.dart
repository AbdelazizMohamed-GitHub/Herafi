import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:herafi_app/app/failure/herafi_failure.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/features/profile/domin/model/review_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, HerafiModel>> getHerafiData();

  Future<Either<Failure, HerafiModel>> getHerafiById({
    required String herafiId,
  });

  Future<Either<Failure, List<ReviewModel>>> getReviews({
    required String herafiId,
  });

  Future<Either<Failure, bool>> hasUserReviewed({required String herafiId});

  Future<Either<Failure, void>> addReview({
    required String herafiId,
    required String userId,
    required String userName,
    required int rating,
    required String comment,
  });

  Future<Either<Failure, void>> updateProfileData({
    required Uint8List? selectedImage,
    required HerafiModel herafi,
  });
  Future<Either<Failure, void>> userLogout();
}
