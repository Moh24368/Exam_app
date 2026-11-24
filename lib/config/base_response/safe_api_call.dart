import 'package:exam/config/base_response/base_response.dart';
import 'package:flutter/foundation.dart';

Future<BaseResponse<T>> safeApiCall<T>(
  Future<T> Function() call, {
  String tag = 'API',
}) async {
  try {
    final data = await call();
    return SuccessBaseResponse(data: data);
  } catch (error, stackTrace) {
    debugPrint('$tag Error: $error\n$stackTrace');
    return ErrorBaseResponse(errorObj: error);
  }
}
