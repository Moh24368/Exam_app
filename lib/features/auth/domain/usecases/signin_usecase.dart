import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/features/auth/domain/entities/signin_entity.dart';
import 'package:exam/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SigninUsecase {
  final AuthRepo authRepo;

  SigninUsecase(this.authRepo);

  Future<BaseResponse<SigninEntity>> call({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    return authRepo.login(email, password, rememberMe: rememberMe);
  }
}
