import 'package:dio/dio.dart';
import 'package:exam/features/auth/data/datasources/remote/forgot_password_remote_data_source.dart';
import 'package:exam/features/auth/data/models/response/forgot_password_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgotPasswordRemoteDataSource, env: [Environment.dev])
class ForgotPasswordFakeDataSource implements ForgotPasswordRemoteDataSource {
  static const String _validCode = '123456';
  static const Duration _delay = Duration(seconds: 1);

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    await Future.delayed(_delay);
    if (!email.contains('@')) throw _error('There is no account with this email');
    return const ForgotPasswordResponse(
      message: 'success',
      info: 'OTP sent to your email',
    );
  }

  @override
  Future<VerifyResetCodeResponse> verifyResetCode(String code) async {
    await Future.delayed(_delay);
    if (code != _validCode) throw _error('Reset code is invalid or has expired');
    return const VerifyResetCodeResponse(status: 'Success');
  }

  @override
  Future<ResetPasswordResponse> resetPassword(
    String email,
    String newPassword,
  ) async {
    await Future.delayed(_delay);
    return const ResetPasswordResponse(
      message: 'success',
      token: 'fake-token',
    );
  }

  DioException _error(String message) => DioException(
        requestOptions: RequestOptions(),
        response: Response(
          requestOptions: RequestOptions(),
          statusCode: 400,
          data: {'message': message},
        ),
      );
}