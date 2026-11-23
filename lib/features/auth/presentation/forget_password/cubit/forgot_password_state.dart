enum ForgotPasswordStep { email, verifyCode, resetPassword, done }

class ForgotPasswordState {
  final bool isLoading;
  final String? errorMessage;
  final String email;
  final ForgotPasswordStep step;

  const ForgotPasswordState({
    this.isLoading = false,
    this.errorMessage,
    this.email = '',
    this.step = ForgotPasswordStep.email,
  });

  ForgotPasswordState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
    String? email,
    ForgotPasswordStep? step,
  }) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      email: email ?? this.email,
      step: step ?? this.step,
    );
  }
}