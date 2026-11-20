import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:herafi_app/app/failure/herafi_failure.dart';
import 'package:herafi_app/app/model/herafi_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, HerafiModel>> getHerafiData();
  Future<Either<Failure, void>> updateProfileData({
    required Uint8List? selectedImage,
    required HerafiModel herafi,
  });
  Future<Either<Failure, void>> userLogout();
}
