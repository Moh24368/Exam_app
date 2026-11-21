sealed class SigninEvent {}

class SigninSubmittedEvent extends SigninEvent {
  final String email;
  final String password;
  final bool rememberMe;

  SigninSubmittedEvent({
    required this.email,
    required this.password,
    required this.rememberMe,
  });
}
