import 'package:dio/dio.dart';
import 'package:exam/config/network/api_constant.dart';
import 'package:exam/features/auth/data/models/request/signin_request_model.dart';
import 'package:exam/features/auth/data/models/response/signin_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_client.g.dart';
@lazySingleton
@RestApi()
abstract class AuthApiClient {
  @factoryMethod
  factory AuthApiClient(Dio dio) = _AuthApiClient;


  @POST(ApiConstants.login)
  Future<SigninResponseModel> login(@Body() SigninRequestBody signinRequestModel);
}
