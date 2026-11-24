import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/config/base_state/base_state.dart';
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
        _sendEmail(intent.email);
      case ResendCodeIntent():
        _resendCode();
      case VerifyCodeIntent():
        _verifyResetCode(intent.code);
      case ResetPasswordIntent():
        _resetUserPassword(intent.newPassword);
    }
  }

  Future<void> _sendEmail(String email) async {
    emit(state.copyWith(
      email: email,
      sendEmailState: const BaseState(isLoading: true),
    ));
    final result = await _forgotPassword(email);
    emit(state.copyWith(sendEmailState: _toBaseState(result)));
  }

  Future<void> _resendCode() async {
    emit(state.copyWith(resendCodeState: const BaseState(isLoading: true)));
    final result = await _forgotPassword(state.email);
    emit(state.copyWith(resendCodeState: _toBaseState(result)));
  }

  Future<void> _verifyResetCode(String code) async {
    emit(state.copyWith(verifyCodeState: const BaseState(isLoading: true)));
    final result = await _verifyCode(code);
    emit(state.copyWith(verifyCodeState: _toBaseState(result)));
  }

  Future<void> _resetUserPassword(String newPassword) async {
    emit(state.copyWith(resetPasswordState: const BaseState(isLoading: true)));
    final result = await _resetPassword(
      email: state.email,
      newPassword: newPassword,
    );
    emit(state.copyWith(resetPasswordState: _toBaseState(result)));
  }

  BaseState<String> _toBaseState(BaseResponse<String> result) {
    return switch (result) {
      SuccessBaseResponse(:final data) => BaseState(data: data),
      ErrorBaseResponse(:final errMessage) => BaseState(errMsg: errMessage),
    };
  }
}