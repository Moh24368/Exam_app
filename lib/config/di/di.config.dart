// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/api/auth_api_service.dart' as _i576;
import '../../features/auth/data/datasources/remote/forgot_password_fake_data_source.dart'
    as _i300;
import '../../features/auth/data/datasources/remote/forgot_password_remote_data_source.dart'
    as _i509;
import '../../features/auth/data/repositories/forgot_password_repository_impl.dart'
    as _i865;
import '../../features/auth/domain/repositories/forgot_password_repository.dart'
    as _i432;
import '../../features/auth/domain/usecases/forgot_password_use_case.dart'
    as _i18;
import '../../features/auth/presentation/forget_password/cubit/forgot_password_cubit.dart'
    as _i28;
import '../network/dio_module.dart' as _i614;

const String _dev = 'dev';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.singleton<_i361.Dio>(() => dioModule.dio);
    gh.factory<_i509.ForgotPasswordRemoteDataSource>(
      () => _i300.ForgotPasswordFakeDataSource(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i576.AuthApiService>(
      () => _i576.AuthApiService(gh<_i361.Dio>()),
    );
    gh.factory<_i509.ForgotPasswordRemoteDataSource>(
      () =>
          _i509.ForgotPasswordRemoteDataSourceImpl(gh<_i576.AuthApiService>()),
      registerFor: {_prod},
    );
    gh.factory<_i432.ForgotPasswordRepository>(
      () => _i865.ForgotPasswordRepositoryImpl(
        gh<_i509.ForgotPasswordRemoteDataSource>(),
      ),
    );
    gh.factory<_i18.ForgotPasswordUseCase>(
      () => _i18.ForgotPasswordUseCase(gh<_i432.ForgotPasswordRepository>()),
    );
    gh.factory<_i18.VerifyResetCodeUseCase>(
      () => _i18.VerifyResetCodeUseCase(gh<_i432.ForgotPasswordRepository>()),
    );
    gh.factory<_i18.ResetPasswordUseCase>(
      () => _i18.ResetPasswordUseCase(gh<_i432.ForgotPasswordRepository>()),
    );
    gh.factory<_i28.ForgotPasswordCubit>(
      () => _i28.ForgotPasswordCubit(
        gh<_i18.ForgotPasswordUseCase>(),
        gh<_i18.VerifyResetCodeUseCase>(),
        gh<_i18.ResetPasswordUseCase>(),
      ),
    );
    return this;
  }
}

class _$DioModule extends _i614.DioModule {}
