import 'package:exam/config/network/api_result.dart';

abstract interface  class ForgotPasswordRepository {
  Future<ApiResult<String>> forgotPassword(String email);
  Future<ApiResult<String>> verifyResetCode(String code);
  Future<ApiResult<String>> resetPassword({
    required String email,
    required String newPassword,
  });
}