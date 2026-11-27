import 'package:exam/config/routes/app_route_paths.dart';
import 'package:exam/core/theme/app_colors.dart';
import 'package:exam/core/theme/app_sizes.dart';
import 'package:exam/core/theme/app_text_style.dart';
import 'package:exam/core/theme/app_pin_theme.dart';
import 'package:exam/core/theme/ui_strings.dart';
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

  void _onVerifyCodeChanged(BuildContext context, ForgotPasswordState state) {
    final verify = state.verifyCodeState;
    if (!verify.isLoading && verify.errMsg == null && verify.data != null) {
      context.push(
        PageRoutePaths.resetpassword,
        extra: context.read<ForgotPasswordCubit>(),
      );
    }
  }

  void _onResendCodeChanged(BuildContext context, ForgotPasswordState state) {
    final resend = state.resendCodeState;
    if (!resend.isLoading && resend.errMsg != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resend.errMsg!)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(title: UiStrings.passwordAppBarTitle),
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
                  UiStrings.verificationCodeTitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.titleStyle,
                ),
                const SizedBox(height: AppSizes.spaceMd),
                const Text(
                  UiStrings.verificationCodeSubtitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.subtitleStyle,
                ),
                const SizedBox(height: AppSizes.spaceLg),
                BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                  listenWhen: (prev, curr) =>
                      prev.verifyCodeState != curr.verifyCodeState,
                  buildWhen: (prev, curr) =>
                      prev.verifyCodeState != curr.verifyCodeState,
                  listener: _onVerifyCodeChanged,
                  builder: (context, state) {
                    final bool hasError = state.verifyCodeState.errMsg != null;
                    final bool isLoading = state.verifyCodeState.isLoading;
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
                            enabled: !isLoading,
                            separatorBuilder: (index) =>
                                const SizedBox(width: AppSizes.otpGap),
                            defaultPinTheme: AppPinTheme.defaultTheme(boxWidth),
                            focusedPinTheme: AppPinTheme.focusedTheme(boxWidth),
                            errorPinTheme: AppPinTheme.errorTheme(boxWidth),
                            forceErrorState: hasError,
                            errorText: hasError ? UiStrings.invalidCode : null,
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
                      UiStrings.didNotReceiveCode,
                      style: AppTextStyle.bodyStyle,
                    ),
                    const SizedBox(width: AppSizes.spaceXs),
                    BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                      listenWhen: (prev, curr) =>
                          prev.resendCodeState != curr.resendCodeState,
                      buildWhen: (prev, curr) =>
                          prev.resendCodeState.isLoading !=
                          curr.resendCodeState.isLoading,
                      listener: _onResendCodeChanged,
                      builder: (context, state) {
                        final bool isResending =
                            state.resendCodeState.isLoading;
                        return TextButton(
                          onPressed: isResending
                              ? null
                              : () => context
                                  .read<ForgotPasswordCubit>()
                                  .doIntent(ResendCodeIntent()),
                          child: isResending
                              ? const SizedBox.square(
                                  dimension: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(UiStrings.resend),
                        );
                      },
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