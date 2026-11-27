import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgotPasswordUseCase {
  final AuthRepo authRepo;

  ForgotPasswordUseCase(this.authRepo);

  Future<BaseResponse<String>> call(String email) {
    return authRepo.forgotPassword(email);
  }
}

@injectable
class VerifyResetCodeUseCase {
  final AuthRepo authRepo;

  VerifyResetCodeUseCase(this.authRepo);

  Future<BaseResponse<String>> call(String code) {
    return authRepo.verifyResetCode(code);
  }
}

@injectable
class ResetPasswordUseCase {
  final AuthRepo authRepo;

  ResetPasswordUseCase(this.authRepo);

  Future<BaseResponse<String>> call({
    required String email,
    required String newPassword,
  }) {
    return authRepo.resetPassword(email: email, newPassword: newPassword);
  }
}