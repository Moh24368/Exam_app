import 'package:exam/config/di/di.dart';
import 'package:exam/config/routes/app_route_paths.dart';
import 'package:exam/features/auth/presentation/forget_password/cubit/forgot_password_cubit.dart';
import 'package:exam/features/auth/presentation/forget_password/screens/forget_password_screen.dart';
import 'package:exam/features/auth/presentation/forget_password/screens/reset_password_screen.dart';
import 'package:exam/features/auth/presentation/forget_password/screens/verification_code_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: PageRoutePaths.forgetpassword,
  routes: [
    GoRoute(
      name: 'forgetpassword',
      path: PageRoutePaths.forgetpassword,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<ForgotPasswordCubit>(),
        child: const ForgetPasswordScreen(),
      ),
    ),
    GoRoute(
      name: 'verificationcode',
      path: PageRoutePaths.verificationcode,
      builder: (context, state) => BlocProvider.value(
        value: state.extra as ForgotPasswordCubit,
        child: const VerificationCodeScreen(),
      ),
    ),
    GoRoute(
      name: 'resetpassword',
      path: PageRoutePaths.resetpassword,
      builder: (context, state) => BlocProvider.value(
        value: state.extra as ForgotPasswordCubit,
        child: const ResetPasswordScreen(),
      ),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.uri}'),
    ),
  ),
);