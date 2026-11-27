import 'package:dio/dio.dart';
import 'package:exam/config/network/api_constant.dart';
import 'package:exam/features/auth/data/models/request/forgot_password_request.dart';
import 'package:exam/features/auth/data/models/response/forgot_password_response.dart';
import 'package:exam/features/auth/data/models/request/signin_request_model.dart';
import 'package:exam/features/auth/data/models/request/signup_request_model.dart';
import 'package:exam/features/auth/data/models/response/signin_response_model.dart';
import 'package:exam/features/auth/data/models/response/signup_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class AuthApiClient {
  @factoryMethod
  factory AuthApiClient(Dio dio) = _AuthApiClient;

  @POST(ApiConstants.forgotPassword)
  Future<ForgotPasswordResponse> forgotPassword(
    @Body() ForgotPasswordRequest request,
  );

  @POST(ApiConstants.verifyResetCode)
  Future<VerifyResetCodeResponse> verifyResetCode(
    @Body() VerifyResetCodeRequest request,
  );

  @PUT(ApiConstants.resetPassword)
  Future<ResetPasswordResponse> resetPassword(
    @Body() ResetPasswordRequest request,
  );
  
  @POST(ApiConstants.login)
  Future<SigninResponseModel> login(
    @Body() SigninRequestBody signinRequestModel,
  );

  @POST(ApiConstants.signup)
  Future<SignupResponseModel> signup(
    @Body() SignupRequestBody signupRequestModel,
  );
}
