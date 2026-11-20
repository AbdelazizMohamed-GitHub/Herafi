import 'package:dartz/dartz.dart';
import 'package:herafi_app/app/failure/herafi_failure.dart';
import 'package:herafi_app/app/model/herafi_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<HerafiModel>>> getHomeData({
    required String category,
  });
}
