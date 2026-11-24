import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/config/base_state/base_state.dart';
import 'package:exam/features/auth/domain/entities/signin_entity.dart';
import 'package:exam/features/auth/domain/usecases/signin_usecase.dart';
import 'package:exam/features/auth/presentation/signin/cubit/signin_event.dart';
import 'package:exam/features/auth/presentation/signin/cubit/signin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SigninViewModel extends Cubit<SigninState> {
  final SigninUsecase _signinUsecase;

  SigninViewModel(this._signinUsecase) : super(SigninState());

  void doEvent(SigninEvent event) {
    switch (event) {
      case SigninSubmittedEvent():
        _signin(
          email: event.email,
          password: event.password,
          rememberMe: event.rememberMe,
        );
    }
  }

  Future<void> _signin({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    emit(
      state.copyWith(
        signinState: const BaseState<SigninEntity>(isLoading: true),
      ),
    );

    final BaseResponse<SigninEntity> apiResult = await _signinUsecase(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );

    switch (apiResult) {
      case SuccessBaseResponse<SigninEntity>():
        emit(
          state.copyWith(
            signinState: BaseState<SigninEntity>(data: apiResult.data),
          ),
        );
      case ErrorBaseResponse<SigninEntity>():
        emit(
          state.copyWith(
            signinState: BaseState<SigninEntity>(errMsg: apiResult.errMessage),
          ),
        );
    }
  }
}
