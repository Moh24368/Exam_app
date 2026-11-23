import 'package:exam/config/network/api_result.dart';
import 'package:exam/features/auth/domain/repositories/forgot_password_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgotPasswordUseCase {
  final ForgotPasswordRepository _repository;
  ForgotPasswordUseCase(this._repository);

  Future<ApiResult<String>> call(String email) =>
      _repository.forgotPassword(email);
}

@injectable
class VerifyResetCodeUseCase {
  final ForgotPasswordRepository _repository;
  VerifyResetCodeUseCase(this._repository);

  Future<ApiResult<String>> call(String code) =>
      _repository.verifyResetCode(code);
}

@injectable
class ResetPasswordUseCase {
  final ForgotPasswordRepository _repository;
  ResetPasswordUseCase(this._repository);

  Future<ApiResult<String>> call({
    required String email,
    required String newPassword,
  }) =>
      _repository.resetPassword(email: email, newPassword: newPassword);
}