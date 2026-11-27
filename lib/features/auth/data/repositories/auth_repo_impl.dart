import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/config/base_response/safe_api_call.dart';
import 'package:exam/config/storage/auth_session.dart';
import 'package:exam/features/auth/data/datasources/remote/auth_remote_datasources.dart';
import 'package:exam/features/auth/data/datasources/remote/forgot_password_remote_datasource.dart';
import 'package:exam/features/auth/data/models/request/forgot_password_request.dart';
import 'package:exam/features/auth/data/models/request/signin_request_model.dart';
import 'package:exam/features/auth/data/models/request/signup_request_model.dart';
import 'package:exam/features/auth/data/models/request/user_data_model.dart';
import 'package:exam/features/auth/domain/entities/signin_entity.dart';
import 'package:exam/features/auth/domain/entities/signup_params.dart';
import 'package:exam/features/auth/domain/entities/user_entity.dart';
import 'package:exam/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource remoteDataSource;
  final AuthSession authSession;
  final ForgotPasswordRemoteDataSource forgotPasswordRemoteDataSource;

  AuthRepoImpl(
    this.remoteDataSource,
    this.authSession,
    this.forgotPasswordRemoteDataSource,
  );

  @override
  Future<BaseResponse<SigninEntity>> login(
    String email,
    String password, {
    required bool rememberMe,
  }) {
    return safeApiCall(tag: 'Signin', () async {
      final response = await remoteDataSource.login(
        SigninRequestBody(email: email, password: password),
      );

      await authSession.saveToken(response.token, rememberMe: rememberMe);

      return SigninEntity(
        token: response.token,
        user: response.user.toEntity(),
      );
    });
  }

  @override
  Future<BaseResponse<UserEntity>> signup(SignupParams params) {
    return safeApiCall(tag: 'Signup', () async {
      final response = await remoteDataSource.signup(
        SignupRequestBody(
          username: params.username,
          firstName: params.firstName,
          lastName: params.lastName,
          email: params.email,
          password: params.password,
          rePassword: params.rePassword,
          phone: params.phone,
        ),
      );
      return response.user.toEntity();
    });
  }

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
