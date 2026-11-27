import 'package:get_it/get_it.dart';
import 'package:herafi_app/core/services/auth_service.dart';
import 'package:herafi_app/core/services/herfa_service.dart';
import 'package:herafi_app/core/services/location_service.dart';
import 'package:herafi_app/core/services/recent_herafi_service.dart';
import 'package:herafi_app/core/services/user_service.dart';
import 'package:herafi_app/features/auth/data/auth_repo_impl.dart';
import 'package:herafi_app/features/auth/domin/auth_repo.dart';
import 'package:herafi_app/features/auth/presention/cubits/auth_cubit.dart';
import 'package:herafi_app/features/home/data/repo_impl/home_repo_impl.dart';
import 'package:herafi_app/features/home/data/repo_impl/search_repo_impl.dart';
import 'package:herafi_app/features/home/domin/repo/home_repo.dart';
import 'package:herafi_app/features/home/domin/repo/search_repo.dart';
import 'package:herafi_app/features/home/presention/cubits/home_cubit/home_cubit.dart';
import 'package:herafi_app/features/home/presention/cubits/search_cubit.dart/search_cubit.dart';
import 'package:herafi_app/features/profile/data/repo_impl/pofile_repo_impl.dart';
import 'package:herafi_app/features/profile/domin/repo/profile_repo.dart';
import 'package:herafi_app/features/profile/presention/cubit/profile_cubit.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<UserService>(() => UserService());
  getIt.registerLazySingleton<HerfaService>(() => HerfaService());
  getIt.registerLazySingleton<LocationService>(() => LocationService());
  getIt.registerLazySingleton<RecentHerafiService>(() => RecentHerafiService());

  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      authService: getIt<AuthService>(),
      userService: getIt<UserService>(),
    ),
  );
  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(herfaService: getIt<HerfaService>()),
  );
  getIt.registerLazySingleton<SearchRepo>(() => SearchRepoImpl());
  getIt.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImpl(userService: getIt<UserService>()),
  );

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(authRepo: getIt<AuthRepo>()),
  );
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(homeRepo: getIt<HomeRepo>()),
  );
  getIt.registerFactory<SearchCubit>(
    () => SearchCubit(searchRepo: getIt<SearchRepo>()),
  );
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(profileRepo: getIt<ProfileRepo>()),
  );
}
