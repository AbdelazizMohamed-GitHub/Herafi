import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/di/service_locator.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/app/router/hearfi_routes.dart';
import 'package:herafi_app/features/auth/presention/screens/sign_in_screen.dart';
import 'package:herafi_app/features/auth/presention/screens/sign_up_screen.dart';
import 'package:herafi_app/features/home/presention/screen/search_result_screen.dart';
import 'package:herafi_app/features/home/presention/screen/search_screen.dart';
import 'package:herafi_app/features/profile/presention/cubit/profile_cubit.dart';
import 'package:herafi_app/features/profile/presention/screen/edit_profile_screen.dart';
import 'package:herafi_app/features/profile/presention/screen/profile_screen.dart';
import 'package:herafi_app/features/home/presention/screen/home_screen.dart';
import 'package:herafi_app/features/welcome/presentation/screen/welcom_screen.dart';

final herafiRouter = GoRouter(
  initialLocation: FirebaseAuth.instance.currentUser != null
      ? HerafiRoutes.home
      : HerafiRoutes.welcome,
  routes: [
    GoRoute(
      path: HerafiRoutes.welcome,
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: HerafiRoutes.signIn,

      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: HerafiRoutes.signUp,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: HerafiRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: HerafiRoutes.search,
      builder: (context, state) {
        final herafiList = state.extra as List<HerafiModel>?;
        return SearchScreen(herafiList: herafiList ?? []);
      },
    ),
    GoRoute(
      path: HerafiRoutes.searchResult,
      builder: (context, state) {
        final herafiList = state.extra as List<HerafiModel>?;

        return SearchResultScreen(herafiResultList: herafiList ?? []);
      },
    ),
    ShellRoute(
      builder: (context, state, child) {
        return BlocProvider(
          create: (context) => getIt<ProfileCubit>(),
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: HerafiRoutes.profile,
          builder: (context, state) {
            final herafi = state.extra as HerafiModel?;
            return ProfileScreen(herafi: herafi);
          },
        ),
        GoRoute(
          path: HerafiRoutes.editProfile,
          builder: (context, state) =>
              EditProfileScreen(herafi: state.extra as HerafiModel),
        ),
      ],
    ),
  ],
);
