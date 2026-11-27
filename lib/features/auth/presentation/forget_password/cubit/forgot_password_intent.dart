sealed class ForgotPasswordIntent {}

class SendEmailIntent extends ForgotPasswordIntent {
  final String email;
  SendEmailIntent(this.email);
}

class VerifyCodeIntent extends ForgotPasswordIntent {
  final String code;
  VerifyCodeIntent(this.code);
}

class ResendCodeIntent extends ForgotPasswordIntent {}

class ResetPasswordIntent extends ForgotPasswordIntent {
  final String newPassword;
  ResetPasswordIntent(this.newPassword);
}