import 'package:exam/config/routes/app_route_paths.dart';
import 'package:exam/config/validators/validations.dart';
import 'package:exam/core/constants/app_strings.dart';
import 'package:exam/core/theme/app_colors.dart';
import 'package:exam/core/theme/app_sizes.dart';
import 'package:exam/core/theme/app_text_style.dart';
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

  void _onStateChanged(BuildContext context, ForgotPasswordState state) {
    if (!(ModalRoute.of(context)?.isCurrent ?? false)) return;

    if (state.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.errorMessage!)),
      );
    } else if (state.step == ForgotPasswordStep.done) {
      context.go(PageRoutePaths.forgetpassword);
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
            child: ListenableBuilder(
              listenable: Listenable.merge([
                _passwordController,
                _confirmController,
              ]),
              builder: (context, _) {
                final String password = _passwordController.text;
                final String confirm = _confirmController.text;
                final bool isPasswordValid =
                    AppValidators.isValidPassword(password);
                final bool canSubmit =
                    isPasswordValid && confirm == password;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: AppSizes.spaceXl),
                    const Text(
                      AppStrings.resetPasswordTitle,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.titleStyle,
                    ),
                    const SizedBox(height: AppSizes.spaceMd),
                    const Text(
                      AppStrings.resetPasswordSubtitle,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.subtitleStyle,
                    ),
                    const SizedBox(height: AppSizes.spaceLg),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: AppStrings.newPasswordLabel,
                        hintText: AppStrings.newPasswordHint,
                        errorText: password.isEmpty || isPasswordValid
                            ? null
                            : AppStrings.passwordInvalid,
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceMd),
                    TextField(
                      controller: _confirmController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: AppStrings.confirmPasswordLabel,
                        hintText: AppStrings.confirmPasswordHint,
                        errorText: confirm.isEmpty || confirm == password
                            ? null
                            : AppStrings.passwordsNotMatch,
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceXxl),
                    BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                      listenWhen: (prev, curr) =>
                          prev.isLoading && !curr.isLoading,
                      listener: _onStateChanged,
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: canSubmit && !state.isLoading
                              ? () => context
                                  .read<ForgotPasswordCubit>()
                                  .doIntent(ResetPasswordIntent(password))
                              : null,
                          child: state.isLoading
                              ? const SizedBox.square(
                                  dimension: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.white,
                                  ),
                                )
                              : const Text(AppStrings.continueLabel),
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