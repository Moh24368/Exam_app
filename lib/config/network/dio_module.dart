import 'package:dio/dio.dart';
import 'package:exam/config/network/api_constant.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioModule {
  @singleton
  Dio get dio => Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      )..interceptors.add(
          LogInterceptor(requestBody: true, responseBody: true),
        );
}