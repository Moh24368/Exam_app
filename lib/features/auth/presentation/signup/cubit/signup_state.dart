import 'package:equatable/equatable.dart';
import 'package:exam/config/base_state/base_state.dart';
import 'package:exam/features/auth/domain/entities/user_entity.dart';

class SignupState extends Equatable {
  final BaseState<UserEntity> signupState;

  const SignupState({
    this.signupState = const BaseState<UserEntity>(),
  });

  SignupState copyWith({BaseState<UserEntity>? signupState}) =>
      SignupState(signupState: signupState ?? this.signupState);

  @override
  List<Object?> get props => [signupState];
}