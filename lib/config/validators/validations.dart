class AppValidators {
  AppValidators._();

  static final RegExp _emailRegex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');

  static final RegExp _passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*\d).{6,}$');

  static bool isValidEmail(String email) => _emailRegex.hasMatch(email.trim());

  static bool isValidPassword(String password) =>
      _passwordRegex.hasMatch(password);
}