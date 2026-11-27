// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/auth/data/datasources/auth_api_client.dart' as _i552;
import '../../features/auth/data/datasources/remote/auth_remote_datasources.dart'
    as _i740;
import '../../features/auth/data/datasources/remote/auth_remote_datasources_impl.dart'
    as _i790;
import '../../features/auth/data/datasources/remote/forgot_password_fake_data_source.dart'
    as _i300;
import '../../features/auth/data/datasources/remote/forgot_password_remote_datasource.dart'
    as _i522;
import '../../features/auth/data/datasources/remote/forgot_password_remote_datasource_impl.dart'
    as _i904;
import '../../features/auth/data/repositories/auth_repo_impl.dart' as _i662;
import '../../features/auth/domain/repositories/auth_repo.dart' as _i723;
import '../../features/auth/domain/usecases/forgot_password_use_case.dart'
    as _i18;
import '../../features/auth/domain/usecases/signin_usecase.dart' as _i435;
import '../../features/auth/domain/usecases/signup_usecase.dart' as _i57;
import '../../features/auth/presentation/forget_password/cubit/forgot_password_cubit.dart'
    as _i28;
import '../../features/auth/presentation/signin/cubit/signin_view_model.dart'
    as _i1064;
import '../../features/auth/presentation/signup/cubit/signup_view_model.dart'
    as _i453;
import '../network/dio_module.dart' as _i614;
import '../storage/auth_session.dart' as _i687;
import '../storage/secure_storage_service.dart' as _i666;
import '../storage/shared_preferences.dart' as _i31;
import '../storage/storage_module.dart' as _i699;

const String _dev = 'dev';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final storageModule = _$StorageModule();
    final dioModule = _$DioModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => storageModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => storageModule.secureStorage,
    );
    gh.factory<_i522.ForgotPasswordRemoteDataSource>(
      () => _i300.ForgotPasswordFakeDataSource(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i666.SecureStorageService>(
      () => _i666.SecureStorageService(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i31.SharedPreferencesHelper>(
      () => _i31.SharedPreferencesHelper(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i687.AuthSession>(
      () => _i687.AuthSession(gh<_i666.SecureStorageService>()),
    );
    gh.singleton<_i361.Dio>(() => dioModule.dio(gh<_i687.AuthSession>()));
    gh.lazySingleton<_i552.AuthApiClient>(
      () => _i552.AuthApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i740.AuthRemoteDataSource>(
      () => _i790.AuthRemoteDataSourceImpl(gh<_i552.AuthApiClient>()),
    );
    gh.factory<_i522.ForgotPasswordRemoteDataSource>(
      () => _i904.ForgotPasswordRemoteDataSourceImpl(gh<_i552.AuthApiClient>()),
      registerFor: {_prod},
    );
    gh.factory<_i723.AuthRepo>(
      () => _i662.AuthRepoImpl(
        gh<_i740.AuthRemoteDataSource>(),
        gh<_i687.AuthSession>(),
        gh<_i522.ForgotPasswordRemoteDataSource>(),
      ),
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
    gh.factory<_i435.SigninUsecase>(
      () => _i435.SigninUsecase(gh<_i723.AuthRepo>()),
    );
    gh.factory<_i28.ForgotPasswordCubit>(
      () => _i28.ForgotPasswordCubit(
        gh<_i18.ForgotPasswordUseCase>(),
        gh<_i18.VerifyResetCodeUseCase>(),
        gh<_i18.ResetPasswordUseCase>(),
      ),
    );
    gh.factory<_i57.SignupUseCase>(
      () => _i57.SignupUseCase(gh<_i723.AuthRepo>()),
    );
    gh.factory<_i453.SignupViewModel>(
      () => _i453.SignupViewModel(gh<_i57.SignupUseCase>()),
    );
    gh.factory<_i1064.SigninViewModel>(
      () => _i1064.SigninViewModel(gh<_i435.SigninUsecase>()),
    );
    return this;
  }
}

class _$StorageModule extends _i699.StorageModule {}

class _$DioModule extends _i614.DioModule {}
