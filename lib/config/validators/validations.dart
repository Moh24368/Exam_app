import 'package:exam/core/constants/app_strings.dart';

class AppValidators {
  AppValidators._();

  static final RegExp _emailRegex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');

  static final RegExp _passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*\d).{6,}$');

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return null;
    if (!_emailRegex.hasMatch(email.trim())) return AppStrings.emailInvalid;
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) return null;
    if (!_passwordRegex.hasMatch(password)) return AppStrings.passwordInvalid;
    return null;
  }

  static String? validateConfirmPassword(String? confirm, String password) {
    if (confirm == null || confirm.isEmpty) return null;
    if (confirm != password) return AppStrings.passwordsNotMatch;
    return null;
  }
}