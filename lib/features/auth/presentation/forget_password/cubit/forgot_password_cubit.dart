import 'package:exam/config/network/api_result.dart';
import 'package:exam/features/auth/domain/usecases/forgot_password_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'forgot_password_intent.dart';
import 'forgot_password_state.dart';

@injectable
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUseCase _forgotPassword;
  final VerifyResetCodeUseCase _verifyCode;
  final ResetPasswordUseCase _resetPassword;

  ForgotPasswordCubit(
    this._forgotPassword,
    this._verifyCode,
    this._resetPassword,
  ) : super(const ForgotPasswordState());

  void doIntent(ForgotPasswordIntent intent) {
    switch (intent) {
      case SendEmailIntent():
        _sendEmail(intent.email, nextStep: ForgotPasswordStep.verifyCode);
      case ResendCodeIntent():
        _sendEmail(state.email, nextStep: ForgotPasswordStep.verifyCode);
      case VerifyCodeIntent():
        _run(
          () => _verifyCode(intent.code),
          nextStep: ForgotPasswordStep.resetPassword,
        );
      case ResetPasswordIntent():
        _run(
          () => _resetPassword(
            email: state.email,
            newPassword: intent.newPassword,
          ),
          nextStep: ForgotPasswordStep.done,
        );
    }
  }

  void _sendEmail(String email, {required ForgotPasswordStep nextStep}) {
    emit(state.copyWith(email: email));
    _run(() => _forgotPassword(email), nextStep: nextStep);
  }

  Future<void> _run(
    Future<ApiResult<String>> Function() call, {
    required ForgotPasswordStep nextStep,
  }) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    final result = await call();
    switch (result) {
      case ApiSuccess():
        emit(state.copyWith(isLoading: false, step: nextStep));
      case ApiError(:final message):
        emit(state.copyWith(isLoading: false, errorMessage: message));
    }
  }
}