import 'package:exam/core/theme/ui_strings.dart';

abstract final class AppValidators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

  static final RegExp _phoneRegExp = RegExp(r'^01[0125][0-9]{8}$');

  static String? _required(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  static String? username(String? value) =>
      _required(value, UiStrings.pleaseEnterUsername);

  static String? firstName(String? value) =>
      _required(value, UiStrings.pleaseEnterFirstName);

  static String? lastName(String? value) =>
      _required(value, UiStrings.pleaseEnterLastName);

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return UiStrings.emailValErr;
    }
    if (!_emailRegExp.hasMatch(value.trim())) {
      return UiStrings.emailValErr;
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return UiStrings.pleaseEnterPassword;
    }
    if (!_passwordRegExp.hasMatch(value)) {
      return UiStrings.passwordValErr;
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return UiStrings.pleaseConfirmPassword;
    }
    if (value != password) {
      return UiStrings.passwordsDontMatch;
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return UiStrings.pleaseEnterPhone;
    }
    if (!_phoneRegExp.hasMatch(value.trim())) {
      return UiStrings.phoneValErr;
    }
    return null;
  }
}
