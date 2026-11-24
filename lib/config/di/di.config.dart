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

import '../../features/auth/data/datasources/auth_api_client.dart' as _i552;
import '../../features/auth/data/datasources/remote/auth_remote_datasources.dart'
    as _i740;
import '../../features/auth/data/datasources/remote/auth_remote_datasources_impl.dart'
    as _i790;
import '../../features/auth/data/datasources/remote/forgot_password_fake_data_source.dart'
    as _i300;
import '../../features/auth/data/repositories/auth_repo_impl.dart' as _i662;
import '../../features/auth/domain/repositories/auth_repo.dart' as _i723;
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
    gh.factory<_i740.AuthRemoteDataSource>(
      () => _i300.ForgotPasswordFakeDataSource(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i552.AuthApiClient>(
      () => _i552.AuthApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i740.AuthRemoteDataSource>(
      () => _i790.AuthRemoteDataSourceImpl(gh<_i552.AuthApiClient>()),
      registerFor: {_prod},
    );
    gh.factory<_i723.AuthRepo>(
      () => _i662.AuthRepoImpl(gh<_i740.AuthRemoteDataSource>()),
    );
    gh.factory<_i18.ForgotPasswordUseCase>(
      () => _i18.ForgotPasswordUseCase(gh<_i723.AuthRepo>()),
    );
    gh.factory<_i18.VerifyResetCodeUseCase>(
      () => _i18.VerifyResetCodeUseCase(gh<_i723.AuthRepo>()),
    );
    gh.factory<_i18.ResetPasswordUseCase>(
      () => _i18.ResetPasswordUseCase(gh<_i723.AuthRepo>()),
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
