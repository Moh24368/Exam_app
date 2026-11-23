import 'package:exam/config/routes/app_route_paths.dart';
import 'package:exam/core/constants/app_strings.dart';
import 'package:exam/core/theme/app_colors.dart';
import 'package:exam/core/theme/app_sizes.dart';
import 'package:exam/core/theme/app_text_style.dart';
import 'package:exam/core/theme/app_theme.dart';
import 'package:exam/features/auth/presentation/forget_password/cubit/forgot_password_cubit.dart';
import 'package:exam/features/auth/presentation/forget_password/cubit/forgot_password_intent.dart';
import 'package:exam/features/auth/presentation/forget_password/cubit/forgot_password_state.dart';
import 'package:exam/features/auth/presentation/widgets/back_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pinput/pinput.dart';

class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen({super.key});

  static const int _codeLength = 6;

  void _onStateChanged(BuildContext context, ForgotPasswordState state) {
    if (!(ModalRoute.of(context)?.isCurrent ?? false)) return;

    if (state.errorMessage == null &&
        state.step == ForgotPasswordStep.resetPassword) {
      context.push(
        PageRoutePaths.resetpassword,
        extra: context.read<ForgotPasswordCubit>(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(title: AppStrings.passwordAppBarTitle),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.screenPadding,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSizes.spaceXl),
                const Text(
                  AppStrings.verificationCodeTitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.titleStyle,
                ),
                const SizedBox(height: AppSizes.spaceMd),
                const Text(
                  AppStrings.verificationCodeSubtitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.subtitleStyle,
                ),
                const SizedBox(height: AppSizes.spaceLg),
                BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                  listenWhen: (prev, curr) => prev.isLoading && !curr.isLoading,
                  listener: _onStateChanged,
                  builder: (context, state) {
                    final bool hasError =
                        state.step == ForgotPasswordStep.verifyCode &&
                            state.errorMessage != null;
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final double boxWidth = (constraints.maxWidth -
                                AppSizes.otpGap * (_codeLength - 1)) /
                            _codeLength;
                        return Material(
                          type: MaterialType.transparency,
                          child: Pinput(
                            length: _codeLength,
                            autofocus: true,
                            enabled: !state.isLoading,
                            separatorBuilder: (index) =>
                                const SizedBox(width: AppSizes.otpGap),
                            defaultPinTheme: AppPinTheme.defaultTheme(boxWidth),
                            focusedPinTheme: AppPinTheme.focusedTheme(boxWidth),
                            errorPinTheme: AppPinTheme.errorTheme(boxWidth),
                            forceErrorState: hasError,
                            errorText: hasError ? AppStrings.invalidCode : null,
                            errorBuilder: (errorText, pin) => Padding(
                              padding: const EdgeInsets.only(
                                top: AppSizes.spaceXs,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    size: AppSizes.iconXs,
                                    color: AppColors.error,
                                  ),
                                  const SizedBox(width: AppSizes.spaceXs),
                                  Text(
                                    errorText ?? '',
                                    style: AppTextStyle.errorText,
                                  ),
                                ],
                              ),
                            ),
                            onCompleted: (code) => context
                                .read<ForgotPasswordCubit>()
                                .doIntent(VerifyCodeIntent(code)),
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: AppSizes.spaceLg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      AppStrings.didNotReceiveCode,
                      style: AppTextStyle.bodyStyle,
                    ),
                    const SizedBox(width: AppSizes.spaceXs),
                    TextButton(
                      onPressed: () => context
                          .read<ForgotPasswordCubit>()
                          .doIntent(ResendCodeIntent()),
                      child: const Text(AppStrings.resend),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}