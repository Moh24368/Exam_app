import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/config/base_response/safe_api_call.dart';
import 'package:exam/features/auth/data/datasources/remote/forgot_password_remote_datasource.dart';
import 'package:exam/features/auth/data/models/request/forgot_password_request.dart';
import 'package:exam/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final ForgotPasswordRemoteDataSource forgotPasswordRemoteDataSource;

  AuthRepoImpl(this.forgotPasswordRemoteDataSource);

  @override
  Future<BaseResponse<String>> forgotPassword(String email) {
    return safeApiCall(tag: 'ForgotPassword', () async {
      final response = await forgotPasswordRemoteDataSource.forgotPassword(
        ForgotPasswordRequest(email: email),
      );
      return response.info ?? '';
    });
  }

  @override
  Future<BaseResponse<String>> verifyResetCode(String code) {
    return safeApiCall(tag: 'VerifyResetCode', () async {
      final response = await forgotPasswordRemoteDataSource.verifyResetCode(
        VerifyResetCodeRequest(resetCode: code),
      );
      return response.status ?? '';
    });
  }

  @override
  Future<BaseResponse<String>> resetPassword({
    required String email,
    required String newPassword,
  }) {
    return safeApiCall(tag: 'ResetPassword', () async {
      final response = await forgotPasswordRemoteDataSource.resetPassword(
        ResetPasswordRequest(email: email, newPassword: newPassword),
      );
      return response.message ?? '';
    });
  }
}