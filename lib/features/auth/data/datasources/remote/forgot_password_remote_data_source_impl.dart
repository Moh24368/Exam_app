import 'package:exam/features/auth/data/api/auth_api_service.dart';
import 'package:exam/features/auth/data/datasources/remote/forgot_password_remote_data_source.dart';
import 'package:exam/features/auth/data/models/request/forgot_password_request.dart';
import 'package:exam/features/auth/data/models/response/forgot_password_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgotPasswordRemoteDataSource, env: [Environment.prod])
class ForgotPasswordRemoteDataSourceImpl
    implements ForgotPasswordRemoteDataSource {
  final AuthApiService _api;
  ForgotPasswordRemoteDataSourceImpl(this._api);

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) =>
      _api.forgotPassword(ForgotPasswordRequest(email: email));

  @override
  Future<VerifyResetCodeResponse> verifyResetCode(String code) =>
      _api.verifyResetCode(VerifyResetCodeRequest(resetCode: code));

  @override
  Future<ResetPasswordResponse> resetPassword(
    String email,
    String newPassword,
  ) =>
      _api.resetPassword(
        ResetPasswordRequest(email: email, newPassword: newPassword),
      );
}