import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/features/auth/domain/entities/signin_entity.dart';
import 'package:exam/features/auth/domain/entities/signup_params.dart';
import 'package:exam/features/auth/domain/entities/user_entity.dart';

abstract interface class AuthRepo {
  Future<BaseResponse<SigninEntity>> login(
    String email,
    String password, {
    required bool rememberMe,
  });

  Future<BaseResponse<UserEntity>> signup(SignupParams params);

  Future<BaseResponse<String>> forgotPassword(String email);

  Future<BaseResponse<String>> verifyResetCode(String code);

  Future<BaseResponse<String>> resetPassword({
    required String email,
    required String newPassword,
  });
}