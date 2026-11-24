import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/config/base_response/safe_api_call.dart';
import 'package:exam/config/storage/auth_session.dart';
import 'package:exam/features/auth/data/datasources/remote/auth_remote_datasources.dart';
import 'package:exam/features/auth/data/models/request/signin_request_model.dart';
import 'package:exam/features/auth/data/models/request/user_data_model.dart';
import 'package:exam/features/auth/domain/entities/signin_entity.dart';
import 'package:exam/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource remoteDataSource;
  final AuthSession authSession;

  AuthRepoImpl(this.remoteDataSource, this.authSession);

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
}
