import 'package:exam/config/base_response/base_response.dart';
import 'package:exam/features/auth/domain/entities/signup_params.dart';
import 'package:exam/features/auth/domain/entities/user_entity.dart';
import 'package:exam/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignupUseCase {
  final AuthRepo _authRepo;
  SignupUseCase(this._authRepo);

Future<BaseResponse<UserEntity>> call(SignupParams params) =>
      _authRepo.signup(params);
}