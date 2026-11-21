import 'package:exam/features/auth/data/models/request/signin_request_model.dart';
import 'package:exam/features/auth/data/models/response/signin_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<SigninResponseModel> login(SigninRequestBody request);
}


