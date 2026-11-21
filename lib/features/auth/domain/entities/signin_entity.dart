import 'package:exam/features/auth/domain/entities/user_entity.dart';

class SigninEntity {
  final String token;
  final UserEntity user;

  const SigninEntity({
    required this.token,
    required this.user,
  });

  @override
  String toString() {
    return 'SigninEntity{token: $token, user: $user}';
  }
}