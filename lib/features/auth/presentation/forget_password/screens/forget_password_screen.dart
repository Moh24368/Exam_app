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

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onSendEmailChanged(BuildContext context, ForgotPasswordState state) {
    final sendEmail = state.sendEmailState;
    if (sendEmail.isLoading) return;

    if (sendEmail.errMsg != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(sendEmail.errMsg!)));
    } else if (sendEmail.data != null) {
      context.push(
        PageRoutePaths.verificationcode,
        extra: context.read<ForgotPasswordCubit>(),
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
                  UiStrings.forgotPasswordTitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.titleStyle,
                ),
                const SizedBox(height: AppSizes.spaceMd),
                const Text(
                  UiStrings.forgotPasswordSubtitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.subtitleStyle,
                ),
                const SizedBox(height: AppSizes.spaceLg),
                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _emailController,
                  builder: (context, value, _) {
                    final String email = value.text.trim();
                    final String? emailError = email.isEmpty
                        ? null
                        : AppValidators.email(email);
                    final bool isValid = email.isNotEmpty && emailError == null;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: UiStrings.emailLabel,
                            hintText: UiStrings.emailHint,
                            errorText: emailError,
                          ),
                        ),
                        const SizedBox(height: AppSizes.spaceXxl),
                        BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                          listenWhen: (prev, curr) =>
                              prev.sendEmailState != curr.sendEmailState,
                          buildWhen: (prev, curr) =>
                              prev.sendEmailState.isLoading !=
                              curr.sendEmailState.isLoading,
                          listener: _onSendEmailChanged,
                          builder: (context, state) {
                            final bool isLoading =
                                state.sendEmailState.isLoading;
                            return ElevatedButton(
                              onPressed: isValid && !isLoading
                                  ? () => context
                                        .read<ForgotPasswordCubit>()
                                        .doIntent(SendEmailIntent(email))
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
