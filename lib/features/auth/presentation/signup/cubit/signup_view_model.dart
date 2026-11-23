import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/config/base_state/base_state.dart';
import 'package:exam/features/auth/domain/usecases/signup_usecase.dart';
import 'package:exam/features/auth/presentation/signup/cubit/signup_state.dart';
import 'package:exam/features/auth/presentation/signup/cubit/signup_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignupViewModel extends Cubit<SignupState> {
  final SignupUseCase _signupUseCase;

  SignupViewModel(this._signupUseCase) : super(const SignupState());

  void doEvent(SignupEvent event) {
    switch (event) {
      case SignupSubmittedEvent():
        _signup(event);
    }
  }

  Future<void> _signup(SignupSubmittedEvent event) async {
    emit(state.copyWith(signupState: const BaseState(isLoading: true)));

    final result = await _signupUseCase(
      username: event.username,
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
      password: event.password,
      rePassword: event.rePassword,
      phone: event.phone,
    );

    switch (result) {
      case SuccessBaseResponse(:final data):
        emit(state.copyWith(signupState: BaseState(data: data)));
      case ErrorBaseResponse(:final errMessage):
        emit(state.copyWith(signupState: BaseState(errMsg: errMessage)));
    }
  }
}