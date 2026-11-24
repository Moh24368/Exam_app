import 'package:exam/features/auth/data/models/response/forgot_password_response.dart';

abstract interface class ForgotPasswordRemoteDataSource {
  Future<ForgotPasswordResponse> forgotPassword(String email);
  Future<VerifyResetCodeResponse> verifyResetCode(String code);
  Future<ResetPasswordResponse> resetPassword(String email, String newPassword);
}