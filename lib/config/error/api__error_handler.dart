
import 'package:dio/dio.dart';
import 'package:exam/config/error/api_error_constant.dart';


import 'api_error_model.dart';

enum DataSource {
  noContent,
  badRequest,
  unprocessableEntity,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectionTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultError,
}

abstract class ResponseCode {
  // HTTP status codes
  static const int success = 200;
  static const int noContent = 204;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int unprocessableEntity = 422;
  static const int internalServerError = 500;

  // Local status codes
  static const int connectionTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int defaultError = -7;
}

abstract class ResponseMessage {
  // API error messages
  static const String noContent = ApiErrors.noContent;
  static const String badRequest = ApiErrors.badRequestError;
  static const String unauthorized = ApiErrors.unauthorizedError;
  static const String forbidden = ApiErrors.forbiddenError;
  static const String notFound = ApiErrors.notFoundError;
  static const String unprocessableEntity = ApiErrors.defaultError;
  static const String internalServerError =
      ApiErrors.internalServerError;

  // Local error messages
  static const String connectionTimeout = ApiErrors.timeoutError;
  static const String cancel = ApiErrors.defaultError;
  static const String receiveTimeout = ApiErrors.timeoutError;
  static const String sendTimeout = ApiErrors.timeoutError;
  static const String cacheError = ApiErrors.cacheError;
  static const String noInternetConnection = ApiErrors.noInternetError;
  static const String defaultError = ApiErrors.defaultError;
}

extension DataSourceExtension on DataSource {
  ApiErrorModel getFailure() {
    return switch (this) {
      DataSource.noContent => ApiErrorModel(
          code: ResponseCode.noContent,
          message: ResponseMessage.noContent,
        ),
      DataSource.badRequest => ApiErrorModel(
          code: ResponseCode.badRequest,
          message: ResponseMessage.badRequest,
        ),
      DataSource.unprocessableEntity => ApiErrorModel(
          code: ResponseCode.unprocessableEntity,
          message: ResponseMessage.unprocessableEntity,
        ),
      DataSource.unauthorized => ApiErrorModel(
          code: ResponseCode.unauthorized,
          message: ResponseMessage.unauthorized,
        ),
      DataSource.forbidden => ApiErrorModel(
          code: ResponseCode.forbidden,
          message: ResponseMessage.forbidden,
        ),
      DataSource.notFound => ApiErrorModel(
          code: ResponseCode.notFound,
          message: ResponseMessage.notFound,
        ),
      DataSource.internalServerError => ApiErrorModel(
          code: ResponseCode.internalServerError,
          message: ResponseMessage.internalServerError,
        ),
      DataSource.connectionTimeout => ApiErrorModel(
          code: ResponseCode.connectionTimeout,
          message: ResponseMessage.connectionTimeout,
        ),
      DataSource.cancel => ApiErrorModel(
          code: ResponseCode.cancel,
          message: ResponseMessage.cancel,
        ),
      DataSource.receiveTimeout => ApiErrorModel(
          code: ResponseCode.receiveTimeout,
          message: ResponseMessage.receiveTimeout,
        ),
      DataSource.sendTimeout => ApiErrorModel(
          code: ResponseCode.sendTimeout,
          message: ResponseMessage.sendTimeout,
        ),
      DataSource.cacheError => ApiErrorModel(
          code: ResponseCode.cacheError,
          message: ResponseMessage.cacheError,
        ),
      DataSource.noInternetConnection => ApiErrorModel(
          code: ResponseCode.noInternetConnection,
          message: ResponseMessage.noInternetConnection,
        ),
      DataSource.defaultError => ApiErrorModel(
          code: ResponseCode.defaultError,
          message: ResponseMessage.defaultError,
        ),
    };
  }
}

class ErrorHandler implements Exception {
  final ApiErrorModel apiErrorModel;

  ErrorHandler.handle(Object error)
      : apiErrorModel = _handleException(error);

  @override
  String toString() => 'ErrorHandler: ${apiErrorModel.message} (code: ${apiErrorModel.code})';
}

ApiErrorModel _handleException(Object error) {
  if (error is DioException) {
    return _handleDioException(error);
  }

  return DataSource.defaultError.getFailure();
}

ApiErrorModel _handleDioException(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectionTimeout.getFailure();

    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeout.getFailure();

    case DioExceptionType.receiveTimeout:
      return DataSource.receiveTimeout.getFailure();

    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();

    case DioExceptionType.connectionError:
      return DataSource.noInternetConnection.getFailure();

    case DioExceptionType.badCertificate:
      return DataSource.defaultError.getFailure();

    case DioExceptionType.badResponse:
      return _handleBadResponse(error);

    case DioExceptionType.unknown:
      return DataSource.defaultError.getFailure();
    case DioExceptionType.transformTimeout:
      // TODO: Handle this case.
      throw UnimplementedError();
  }
}

ApiErrorModel _handleBadResponse(DioException error) {
  final response = error.response;

  if (response == null) {
    return DataSource.defaultError.getFailure();
  }

  final responseData = response.data;

  // Try to parse the API error response.
  if (responseData is Map) {
    try {
      return ApiErrorModel.fromJson(
        Map<String, dynamic>.from(responseData),
      );
    } catch (_) {
      // Fall back to HTTP status code mapping.
    }
  }

  return _getFailureFromStatusCode(response.statusCode);
}

ApiErrorModel _getFailureFromStatusCode(int? statusCode) {
  return switch (statusCode) {
    400 => DataSource.badRequest.getFailure(),
    401 => DataSource.unauthorized.getFailure(),
    403 => DataSource.forbidden.getFailure(),
    404 => DataSource.notFound.getFailure(),
    422 => DataSource.unprocessableEntity.getFailure(),
    500 => DataSource.internalServerError.getFailure(),
    _ => DataSource.defaultError.getFailure(),
  };
}

abstract class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
