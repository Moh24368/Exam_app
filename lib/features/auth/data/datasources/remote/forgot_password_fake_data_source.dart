import 'package:dio/dio.dart';
import 'package:exam/features/auth/data/datasources/remote/forgot_password_remote_datasource.dart';
import 'package:exam/features/auth/data/models/request/forgot_password_request.dart';
import 'package:exam/features/auth/data/models/response/forgot_password_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgotPasswordRemoteDataSource, env: [Environment.dev])
class ForgotPasswordFakeDataSource implements ForgotPasswordRemoteDataSource {
  static const String _validCode = '123456';
  static const Duration _delay = Duration(seconds: 1);

  @override
  Future<ForgotPasswordResponse> forgotPassword(
    ForgotPasswordRequest request,
  ) async {
    await Future.delayed(_delay);
    return const ForgotPasswordResponse(
      message: 'success',
      info: 'OTP sent to your email',
    );
  }

  @override
  Future<VerifyResetCodeResponse> verifyResetCode(
    VerifyResetCodeRequest request,
  ) async {
    await Future.delayed(_delay);
    if (request.resetCode != _validCode) throw _badRequest();
    return const VerifyResetCodeResponse(status: 'Success');
  }

  @override
  Future<ResetPasswordResponse> resetPassword(
    ResetPasswordRequest request,
  ) async {
    await Future.delayed(_delay);
    return const ResetPasswordResponse(message: 'success', token: 'fake-token');
  }

  DioException _badRequest() => DioException(
        requestOptions: RequestOptions(),
        type: DioExceptionType.badResponse,
        response: Response(requestOptions: RequestOptions(), statusCode: 400),
      );
}