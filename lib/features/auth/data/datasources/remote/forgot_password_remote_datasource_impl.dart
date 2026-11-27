import 'package:exam/features/auth/data/datasources/auth_api_client.dart';
import 'package:exam/features/auth/data/datasources/remote/forgot_password_remote_datasource.dart';
import 'package:exam/features/auth/data/models/request/forgot_password_request.dart';
import 'package:exam/features/auth/data/models/response/forgot_password_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgotPasswordRemoteDataSource, env: [Environment.prod])
class ForgotPasswordRemoteDataSourceImpl
    implements ForgotPasswordRemoteDataSource {
  final AuthApiClient authApiClient;

  ForgotPasswordRemoteDataSourceImpl(this.authApiClient);

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