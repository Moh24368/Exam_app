import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/features/auth/domain/entities/user_entity.dart';
import 'package:exam/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignupUseCase {
  final AuthRepo _authRepo;
  SignupUseCase(this._authRepo);

  Future<BaseResponse<UserEntity>> call({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) => _authRepo.signup(
        username: username,
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        rePassword: rePassword,
        phone: phone,
      );
}