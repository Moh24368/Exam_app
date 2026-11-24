import 'package:exam/features/auth/data/datasources/auth_api_client.dart';
import 'package:exam/features/auth/data/datasources/remote/auth_remote_datasources.dart';
import 'package:exam/features/auth/data/models/request/forgot_password_request.dart';
import 'package:exam/features/auth/data/models/response/forgot_password_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource, env: [Environment.prod])
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiClient authApiClient;

  AuthRemoteDataSourceImpl(this.authApiClient);

  @override
  Future<ForgotPasswordResponse> forgotPassword(ForgotPasswordRequest request) {
    return authApiClient.forgotPassword(request);
  }

  @override
  Future<VerifyResetCodeResponse> verifyResetCode(
    VerifyResetCodeRequest request,
  ) {
    return authApiClient.verifyResetCode(request);
  }

  @override
  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request) {
    return authApiClient.resetPassword(request);
  }
}