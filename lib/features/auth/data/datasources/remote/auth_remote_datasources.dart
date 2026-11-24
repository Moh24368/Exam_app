import 'package:exam/features/auth/data/models/request/forgot_password_request.dart';
import 'package:exam/features/auth/data/models/response/forgot_password_response.dart';

abstract interface class AuthRemoteDataSource {
  Future<ForgotPasswordResponse> forgotPassword(ForgotPasswordRequest request);
  Future<VerifyResetCodeResponse> verifyResetCode(VerifyResetCodeRequest request);
  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request);
}