import 'package:exam/config/routes/app_route_paths.dart';
import 'package:exam/config/routes/page_routes_name.dart';
import 'package:exam/features/auth/presentation/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../main.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: PageRoutesName.login,

  routes: [
    GoRoute(
      name: PageRoutesName.login,
      path: PageRoutePaths.login,
      builder: (context, state) => const SigninScreen(),
    ),
  ],

  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text(
        'Page not found: ${state.uri}',
      ),
    ),
  ),
);