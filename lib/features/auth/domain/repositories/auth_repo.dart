import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/features/auth/domain/entities/signin_entity.dart';
import 'package:exam/features/auth/domain/entities/signup_params.dart';
import 'package:exam/features/auth/domain/entities/user_entity.dart';

abstract interface class AuthRepo {
  Future<BaseResponse<SigninEntity>> login(
    String email,
    String password, {
    required bool rememberMe,
  });

// domain/repositories/auth_repo.dart
Future<BaseResponse<UserEntity>> signup(SignupParams params);
}
