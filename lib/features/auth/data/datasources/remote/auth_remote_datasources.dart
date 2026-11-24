import 'package:exam/features/auth/data/models/request/signin_request_model.dart';
import 'package:exam/features/auth/data/models/request/signup_request_model.dart';
import 'package:exam/features/auth/data/models/response/signin_response_model.dart';
import 'package:exam/features/auth/data/models/response/signup_response_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<SigninResponseModel> login(SigninRequestBody request);
  Future<SignupResponseModel> signup(SignupRequestBody request);
}
