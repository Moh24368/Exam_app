import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/config/storage/shared_preferences.dart';
import 'package:exam/features/auth/data/datasources/remote/auth_remote_datasources.dart';
import 'package:exam/features/auth/data/models/request/signin_request_model.dart';
import 'package:exam/features/auth/data/models/request/user_data_model.dart';
import 'package:exam/features/auth/domain/entities/signin_entity.dart';
import 'package:exam/features/auth/domain/repositories/auth_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepoImpl(this.remoteDataSource);

  @override
  Future<BaseResponse<SigninEntity>> login(
    String email,
    String password, {
    required bool rememberMe,
  }) async {
    try {
      final response = await remoteDataSource.login(
        SigninRequestBody(email: email, password: password),
      );

      await SharedPreferencesHelper.saveToken(
        response.token,
        rememberMe: rememberMe,
      );

      return SuccessBaseResponse(
        data: SigninEntity(
          token: response.token,
          user: response.user.toEntity(),
        ),
      );
    } catch (error, stackTrace) {
      debugPrint('Sinin Error: $error\n $stackTrace');
      return ErrorBaseResponse(errorObj: error);
    }
  }
}