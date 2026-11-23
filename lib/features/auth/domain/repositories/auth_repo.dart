import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/features/auth/domain/entities/signin_entity.dart';
import 'package:exam/features/auth/domain/entities/user_entity.dart';

abstract interface class AuthRepo {
  Future<BaseResponse<SigninEntity>> login(
    String email,
    String password, {
    required bool rememberMe,
  });

  Future<BaseResponse<UserEntity>> signup({
  required String username,
  required String firstName,
  required String lastName,
  required String email,
  required String password,
  required String rePassword,
  required String phone,
});
}
