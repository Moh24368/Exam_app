import 'package:exam/config/base_state/base_state.dart';
import 'package:exam/features/auth/domain/entities/signin_entity.dart';

import 'package:equatable/equatable.dart';

class SigninState extends Equatable {
  final BaseState<SigninEntity> signinState;

  const SigninState({this.signinState = const BaseState<SigninEntity>()});

  SigninState copyWith({BaseState<SigninEntity>? signinState}) {
    return SigninState(signinState: signinState ?? this.signinState);
  }

  @override
  List<Object?> get props => [signinState];
}
