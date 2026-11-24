import 'package:exam/config/base_response/base_response.dart';

abstract interface class AuthRepo {
  Future<BaseResponse<String>> forgotPassword(String email);
  Future<BaseResponse<String>> verifyResetCode(String code);
  Future<BaseResponse<String>> resetPassword({
    required String email,
    required String newPassword,
  });
}