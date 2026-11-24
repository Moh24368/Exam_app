import 'package:exam/config/di/di.dart';
import 'package:exam/config/validators/validations.dart';
import 'package:exam/core/theme/ui_strings.dart';
import 'package:exam/features/auth/presentation/signup/cubit/signup_state.dart';
import 'package:exam/features/auth/presentation/signup/cubit/signup_event.dart';
import 'package:exam/features/auth/presentation/signup/cubit/signup_view_model.dart';
import 'package:exam/features/auth/presentation/widgets/dont_have_acc_row.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupViewModel>(
      create: (context) => getIt<SignupViewModel>(),
      child: BlocListener<SignupViewModel, SignupState>(
        listener: (context, state) {
          final signupState = state.signupState;
          if (signupState.errMsg != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(signupState.errMsg!)));
          } else if (!signupState.isLoading && signupState.data != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(UiStrings.accCraetedSuccessfuly)),
            );
            context.pop();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(UiStrings.signUp),
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: Icon(Icons.arrow_back_ios_new),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: _userNameController,
                      keyboardType: TextInputType.name,
                      validator: AppValidators.username,
                      decoration: InputDecoration(
                        label: Text(UiStrings.userName),
                        hint: Text(UiStrings.enterYourUserName),
                      ),
                    ),
                    SizedBox(height: 24.0.h),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _firstNameController,
                            keyboardType: TextInputType.name,
                            validator: AppValidators.firstName,
                            decoration: InputDecoration(
                              label: Text(UiStrings.firstName),
                              hint: Text(UiStrings.enterFirstName),
                            ),
                          ),
                        ),
                        SizedBox(width: 17.w),
                        Expanded(
                          child: TextFormField(
                            controller: _lastNameController,
                            keyboardType: TextInputType.name,
                            validator: AppValidators.lastName,
                            decoration: InputDecoration(
                              label: Text(UiStrings.lastName),
                              hint: Text(UiStrings.enterLastName),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: AppValidators.email,
                      decoration: InputDecoration(
                        label: Text(UiStrings.email),
                        hint: Text(UiStrings.enterEmail),
                      ),
                    ),
                    SizedBox(height: 24.0.h),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            validator: AppValidators.password,
                            decoration: InputDecoration(
                              label: Text(UiStrings.password),
                              hint: Text(UiStrings.enterPassword),
                            ),
                          ),
                        ),
                        SizedBox(width: 17.w),
                        Expanded(
                          child: TextFormField(
                            controller: _confirmPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            validator: (v) => AppValidators.confirmPassword(
                              v,
                              _passwordController.text,
                            ),
                            decoration: InputDecoration(
                              label: Text(UiStrings.confirmPassword),
                              hint: Text(UiStrings.confirmPassword),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.0.h),
                    TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      validator: AppValidators.phone,
                      decoration: InputDecoration(
                        label: Text(UiStrings.phoneNumber),
                        hint: Text(UiStrings.enterPhoneNumber),
                      ),
                    ),
                    SizedBox(height: 48.0.h),
                    BlocBuilder<SignupViewModel, SignupState>(
                      builder: (context, state) {
                        final isLoading = state.signupState.isLoading;
                        return ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  context.read<SignupViewModel>().doEvent(
                                    SignupSubmittedEvent(
                                      username: _userNameController.text.trim(),
                                      firstName: _firstNameController.text
                                          .trim(),
                                      lastName: _lastNameController.text.trim(),
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text,
                                      rePassword:
                                          _confirmPasswordController.text,
                                      phone: _phoneNumberController.text.trim(),
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
                              : Text(UiStrings.signUp),
                        );
                      },
                    ),
                    SizedBox(height: 48.0.h),
                    // Already have an account
                    DontHaveAccRow(
                      title: UiStrings.alreadyHaveAcc,
                      buttonText: UiStrings.login,
                      onPressed: () => context.pop(),
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
