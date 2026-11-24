import 'package:dio/dio.dart';
import 'package:exam/config/network/api_result.dart';
import 'package:exam/features/auth/data/datasources/remote/forgot_password_remote_data_source.dart';
import 'package:exam/features/auth/domain/repositories/forgot_password_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgotPasswordRepository)
class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final ForgotPasswordRemoteDataSource _remote;
  ForgotPasswordRepositoryImpl(this._remote);

  @override
  Future<ApiResult<String>> forgotPassword(String email) =>
      _safeCall(() async => (await _remote.forgotPassword(email)).info ?? '');

  @override
  Future<ApiResult<String>> verifyResetCode(String code) =>
      _safeCall(() async => (await _remote.verifyResetCode(code)).status ?? '');

  @override
  Future<ApiResult<String>> resetPassword({
    required String email,
    required String newPassword,
  }) =>
      _safeCall(
        () async => (await _remote.resetPassword(email, newPassword)).message ?? '',
      );

  Future<ApiResult<String>> _safeCall(Future<String> Function() call) async {
    try {
      return ApiSuccess(await call());
    } on DioException catch (e) {
      final data = e.response?.data;
      final message = data is Map && data['message'] != null
          ? data['message'].toString()
          : 'Something went wrong, please try again';
      return ApiError(message);
    }
  }
}