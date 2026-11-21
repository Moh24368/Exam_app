import 'package:exam/config/base_state/base_state.dart';
import 'package:exam/features/auth/domain/entities/signin_entity.dart';

class SigninState {
    BaseState<SigninEntity>? signinState;

  SigninState({
    this.signinState,
  }){
    signinState ??= BaseState<SigninEntity>(
      isLoading: false,
      errMsg: null,
      data: null,
    );
  }

  SigninState copyWith({
    BaseState<SigninEntity>? signinState,
  }) {
    return SigninState(
      signinState: signinState ?? this.signinState,
    );
  }
}