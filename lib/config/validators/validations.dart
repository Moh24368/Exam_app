import 'package:exam/core/theme/ui_strings.dart';

abstract final class AppValidators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

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
}
