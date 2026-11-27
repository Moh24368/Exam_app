import 'package:exam/config/di/di.dart';
import 'package:exam/config/routes/page_routes_name.dart';
import 'package:exam/config/validators/validations.dart';
import 'package:exam/core/theme/ui_strings.dart';
import 'package:exam/features/auth/presentation/signin/cubit/signin_event.dart';
import 'package:exam/features/auth/presentation/signin/cubit/signin_state.dart';
import 'package:exam/features/auth/presentation/signin/cubit/signin_view_model.dart';
import 'package:exam/features/auth/presentation/widgets/dont_have_acc_row.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rememberMe = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _rememberMe.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SigninViewModel>(
      create: (context) => getIt<SigninViewModel>(),
      child: BlocListener<SigninViewModel, SigninState>(
        listener: (context, state) {
          final signinState = state.signinState;
          if (signinState.errMsg != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(signinState.errMsg!)));
          } else if (!signinState.isLoading && signinState.data != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(UiStrings.loginSuccess)),
            );
            context.goNamed(PageRoutesName.home);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              UiStrings.login,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, size: 20.0.w),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: AppValidators.email,
                      decoration: InputDecoration(
                        label: Text(UiStrings.email),
                        hint: Text(UiStrings.enterEmail),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: _passwordController,
                      validator: AppValidators.password,
                      obscureText: true,
                      decoration: InputDecoration(
                        label: Text(UiStrings.password),
                        hint: Text(UiStrings.enterPassword),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        SizedBox(
                          width: 24.w,
                          height: 24.w,
                          child: ValueListenableBuilder<bool>(
                            valueListenable: _rememberMe,
                            builder: (context, value, _) {
                              return Checkbox(
                                value: value,
                                visualDensity: VisualDensity.compact,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onChanged: (newValue) =>
                                    _rememberMe.value = newValue ?? false,
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 11.w),
                        Text(
                          UiStrings.rememberMe,
                          style: TextStyle(fontSize: 13.sp),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () => context.pushNamed(PageRoutesName.forgetpassword),
                          child: Text(
                            UiStrings.forgotPassword,
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 48.h),
                    BlocBuilder<SigninViewModel, SigninState>(
                      builder: (context, state) {
                        final isLoading = state.signinState.isLoading;

                        return ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }

                                  context.read<SigninViewModel>().doEvent(
                                    SigninSubmittedEvent(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text,
                                      rememberMe: _rememberMe.value,
                                    ),
                                  );
                                },
                          child: isLoading
                              ? SizedBox(
                                  width: 18.w,
                                  height: 18.w,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(UiStrings.login),
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    // don't have an account Row
                    DontHaveAccRow(
                      title: UiStrings.dontHaveAccount,
                      buttonText: UiStrings.signUp,
                      onPressed: () => context.pushNamed(PageRoutesName.signup),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
