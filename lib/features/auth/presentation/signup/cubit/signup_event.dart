sealed class SignupEvent {
  const SignupEvent();
}

class SignupSubmittedEvent extends SignupEvent {
  final String username, firstName, lastName, email;
  final String password, rePassword, phone;

  const SignupSubmittedEvent({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
  });
}