import 'package:exam/features/auth/data/datasources/auth_api_client.dart';
import 'package:exam/features/auth/data/datasources/remote/auth_remote_datasources.dart';
import 'package:exam/features/auth/data/models/request/signin_request_model.dart';
import 'package:exam/features/auth/data/models/request/signup_request_model.dart';
import 'package:exam/features/auth/data/models/response/signin_response_model.dart';
import 'package:exam/features/auth/data/models/response/signup_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiClient authApiClient;

  AuthRemoteDataSourceImpl(this.authApiClient);

  @override
  Future<SigninResponseModel> login(SigninRequestBody request) {
    return authApiClient.login(request);
  }

  @override
  Future<SignupResponseModel> signup(SignupRequestBody request) {
    return authApiClient.signup(request);
  }
}
