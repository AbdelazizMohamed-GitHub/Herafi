import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/router/routes.dart';
import 'package:herafi_app/features/welcome/presentation/screen/welcom_screen.dart';

final herafiRouter = GoRouter(
  initialLocation: HerafiRoutes.welcome,
  routes: [
    GoRoute(
      path: HerafiRoutes.welcome,
      builder: (context, state) => const WelcomeScreen(),
    ),
  ],
);
