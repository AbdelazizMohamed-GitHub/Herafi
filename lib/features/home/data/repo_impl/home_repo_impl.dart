import 'package:dartz/dartz.dart';
import 'package:herafi_app/app/failure/herafi_failure.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/core/services/herfa_service.dart';
import 'package:herafi_app/features/home/domin/repo/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final HerfaService herfaService;
  HomeRepoImpl({required this.herfaService});

  @override
  Future<Either<Failure, List<HerafiModel>>> getHomeData({
    required String category,
  }) async {
    try {
      final herafiList = await herfaService.getCategoryList(category: category);
      return Right(herafiList);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
