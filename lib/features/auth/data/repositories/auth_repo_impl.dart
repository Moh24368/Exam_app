import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/config/base_response/safe_api_call.dart';
import 'package:exam/features/auth/data/datasources/remote/auth_remote_datasources.dart';
import 'package:exam/features/auth/data/models/request/forgot_password_request.dart';
import 'package:exam/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepoImpl(this.remoteDataSource);

  @override
  Future<BaseResponse<String>> forgotPassword(String email) {
    return safeApiCall(tag: 'ForgotPassword', () async {
      final response = await remoteDataSource.forgotPassword(
        ForgotPasswordRequest(email: email),
      );
      return response.info ?? '';
    });
  }

  @override
  Future<BaseResponse<String>> verifyResetCode(String code) {
    return safeApiCall(tag: 'VerifyResetCode', () async {
      final response = await remoteDataSource.verifyResetCode(
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
      final response = await remoteDataSource.resetPassword(
        ResetPasswordRequest(email: email, newPassword: newPassword),
      );
      return response.message ?? '';
    });
  }
}