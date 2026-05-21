import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/router/hearfi_routes.dart';
import 'package:herafi_app/features/auth/presention/screens/sign_in_screen.dart';
import 'package:herafi_app/features/auth/presention/screens/sign_up_screen.dart';
import 'package:herafi_app/features/home/presention/screen/home_screen.dart';
import 'package:herafi_app/features/welcome/presentation/screen/welcom_screen.dart';

final herafiRouter = GoRouter(
  initialLocation: HerafiRoutes.home,
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
  ],
);
