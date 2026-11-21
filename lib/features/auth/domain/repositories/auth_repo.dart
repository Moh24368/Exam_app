import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/features/auth/domain/entities/signin_entity.dart';

abstract class AuthRepo {
  Future<BaseResponse<SigninEntity>> login(
    String email,
    String password, {
    required bool rememberMe,
  });
}
