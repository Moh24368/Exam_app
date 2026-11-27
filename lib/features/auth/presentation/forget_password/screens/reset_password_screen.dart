import 'package:exam/config/routes/app_route_paths.dart';
import 'package:exam/config/validators/validations.dart';
import 'package:exam/core/theme/app_colors.dart';
import 'package:exam/core/theme/app_sizes.dart';
import 'package:exam/core/theme/app_text_style.dart';
import 'package:exam/core/theme/ui_strings.dart';
import 'package:exam/features/auth/presentation/forget_password/cubit/forgot_password_cubit.dart';
import 'package:exam/features/auth/presentation/forget_password/cubit/forgot_password_intent.dart';
import 'package:exam/features/auth/presentation/forget_password/cubit/forgot_password_state.dart';
import 'package:exam/features/auth/presentation/widgets/back_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _onResetPasswordChanged(
    BuildContext context,
    ForgotPasswordState state,
  ) {
    final reset = state.resetPasswordState;
    if (reset.isLoading) return;

    if (reset.errMsg != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(reset.errMsg!)));
    } else if (reset.data != null) {
      context.go(PageRoutePaths.login);
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
            child: ListenableBuilder(
              listenable: Listenable.merge([
                _passwordController,
                _confirmController,
              ]),
              builder: (context, _) {
                final String password = _passwordController.text;
                final String confirm = _confirmController.text;
                final String? passwordError = password.isEmpty
                    ? null
                    : AppValidators.password(password);
                final String? confirmError = confirm.isEmpty
                    ? null
                    : AppValidators.confirmPassword(confirm, password);
                final bool canSubmit =
                    password.isNotEmpty &&
                    confirm.isNotEmpty &&
                    passwordError == null &&
                    confirmError == null;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: AppSizes.spaceXl),
                    const Text(
                      UiStrings.resetPasswordTitle,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.titleStyle,
                    ),
                    const SizedBox(height: AppSizes.spaceMd),
                    const Text(
                      UiStrings.resetPasswordSubtitle,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.subtitleStyle,
                    ),
                    const SizedBox(height: AppSizes.spaceLg),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: UiStrings.newPasswordLabel,
                        hintText: UiStrings.newPasswordHint,
                        errorText: passwordError,
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceMd),
                    TextField(
                      controller: _confirmController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: UiStrings.confirmPasswordLabel,
                        hintText: UiStrings.confirmPasswordHint,
                        errorText: confirmError,
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceXxl),
                    BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                      listenWhen: (prev, curr) =>
                          prev.resetPasswordState != curr.resetPasswordState,
                      buildWhen: (prev, curr) =>
                          prev.resetPasswordState.isLoading !=
                          curr.resetPasswordState.isLoading,
                      listener: _onResetPasswordChanged,
                      builder: (context, state) {
                        final bool isLoading =
                            state.resetPasswordState.isLoading;
                        return ElevatedButton(
                          onPressed: canSubmit && !isLoading
                              ? () => context
                                    .read<ForgotPasswordCubit>()
                                    .doIntent(ResetPasswordIntent(password))
                              : null,
                          child: isLoading
                              ? const SizedBox.square(
                                  dimension: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.white,
                                  ),
                                )
                              : const Text(UiStrings.continueLabel),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
