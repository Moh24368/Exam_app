import 'package:equatable/equatable.dart';
import 'package:exam/config/base_state/base_state.dart';

class ForgotPasswordState extends Equatable {
  final String email;
  final BaseState<String> sendEmailState;
  final BaseState<String> resendCodeState;
  final BaseState<String> verifyCodeState;
  final BaseState<String> resetPasswordState;

  const ForgotPasswordState({
    this.email = '',
    this.sendEmailState = const BaseState(),
    this.resendCodeState = const BaseState(),
    this.verifyCodeState = const BaseState(),
    this.resetPasswordState = const BaseState(),
  });

  ForgotPasswordState copyWith({
    String? email,
    BaseState<String>? sendEmailState,
    BaseState<String>? resendCodeState,
    BaseState<String>? verifyCodeState,
    BaseState<String>? resetPasswordState,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      sendEmailState: sendEmailState ?? this.sendEmailState,
      resendCodeState: resendCodeState ?? this.resendCodeState,
      verifyCodeState: verifyCodeState ?? this.verifyCodeState,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
    );
  }

  @override
  List<Object?> get props => [
        email,
        sendEmailState,
        resendCodeState,
        verifyCodeState,
        resetPasswordState,
      ];
}