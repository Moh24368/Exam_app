import 'package:exam/config/routes/app_route_paths.dart';
import 'package:exam/config/routes/page_routes_name.dart';
import 'package:exam/features/auth/presentation/signin/screens/signin_screen.dart';
import 'package:exam/features/home/presentation/screens/home_screen.dart';
import 'package:exam/features/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: PageRoutePaths.splash,
  routes: [
    GoRoute(
      name: PageRoutesName.splash,
      path: PageRoutePaths.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      name: PageRoutesName.login,
      path: PageRoutePaths.login,
      builder: (context, state) => const SigninScreen(),
    ),
    GoRoute(
      name: PageRoutesName.home,
      path: PageRoutePaths.home,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(child: Text('Page not found: ${state.uri}')),
  ),
);