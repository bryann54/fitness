// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:uuid/uuid.dart' as _i706;

import '../../features/account/data/datasources/account_remote_datasource.dart'
    as _i302;
import '../../features/account/data/repositories/account_repository_impl.dart'
    as _i857;
import '../../features/account/domain/repositories/account_repository.dart'
    as _i1067;
import '../../features/account/domain/usecases/update_user_profile_usecase.dart'
    as _i475;
import '../../features/account/presentation/bloc/account_bloc.dart' as _i708;
import '../../features/auth/data/datasources/auth_remoteDataSource.dart'
    as _i167;
import '../../features/auth/data/repositories/auth_repositoryImpl.dart'
    as _i877;
import '../../features/auth/domain/repositories/auth_epository.dart' as _i626;
import '../../features/auth/domain/usecases/auth_usecases.dart' as _i46;
import '../../features/auth/domain/usecases/get_user_fitness_profile_usecase.dart'
    as _i928;
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i797;
import '../../features/onboarding/data/datasources/onboarding_remote_datasource.dart'
    as _i608;
import '../../features/onboarding/data/repositories/onboarding_repository_impl.dart'
    as _i452;
import '../../features/onboarding/domain/repositories/onboarding_repository.dart'
    as _i430;
import '../../features/onboarding/domain/usecases/get_fitness_profile_usecase.dart'
    as _i488;
import '../../features/onboarding/domain/usecases/save_fitness_profile_usecase.dart'
    as _i674;
import '../../features/onboarding/presentation/bloc/onboarding_bloc.dart'
    as _i792;
import '../../features/workouts/data/datasources/workouts_remote_datasource%20copy.dart'
    as _i597;
import '../../features/workouts/data/repositories/workouts_repository_impl.dart'
    as _i774;
import '../../features/workouts/domain/repositories/workouts_repository.dart'
    as _i243;
import '../../features/workouts/domain/usecases/get_workout_by_day_usecase.dart'
    as _i1024;
import '../../features/workouts/domain/usecases/get_workouts_usecase.dart'
    as _i653;
import '../../features/workouts/presentation/bloc/workouts_bloc.dart' as _i410;
import '../api_client/client/dio_client.dart' as _i758;
import '../api_client/client_provider.dart' as _i546;
import '../storage/storage_preference_manager.dart' as _i934;
import 'module_injector.dart' as _i759;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModules = _$RegisterModules();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModules.prefs(),
      preResolve: true,
    );
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModules.firebaseAuth);
    gh.lazySingleton<_i116.GoogleSignIn>(() => registerModules.googleSignIn);
    gh.lazySingleton<_i706.Uuid>(() => registerModules.uuid);
    gh.lazySingleton<_i457.FirebaseStorage>(
        () => registerModules.firebaseStorage);
    gh.lazySingleton<_i974.FirebaseFirestore>(
        () => registerModules.firebaseFirestore);
    gh.factory<String>(
      () => registerModules.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.factory<String>(
      () => registerModules.apiKey,
      instanceName: 'ApiKey',
    );
    gh.lazySingleton<_i934.SharedPreferencesManager>(
        () => _i934.SharedPreferencesManager(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i167.AuthRemoteDataSource>(
        () => _i167.AuthRemoteDataSourceImpl(
              firebaseAuth: gh<_i59.FirebaseAuth>(),
              googleSignIn: gh<_i116.GoogleSignIn>(),
              firebaseStorage: gh<_i457.FirebaseStorage>(),
              uuid: gh<_i706.Uuid>(),
            ));
    gh.lazySingleton<_i302.AccountRemoteDataSource>(
        () => _i302.AccountRemoteDataSourceImpl(
              firebaseAuth: gh<_i59.FirebaseAuth>(),
              firebaseStorage: gh<_i457.FirebaseStorage>(),
              firestore: gh<_i974.FirebaseFirestore>(),
              uuid: gh<_i706.Uuid>(),
            ));
    gh.lazySingleton<_i608.OnboardingRemoteDatasource>(
        () => _i608.OnboardingRemoteDatasource(
              gh<_i974.FirebaseFirestore>(),
              gh<_i59.FirebaseAuth>(),
            ));
    gh.lazySingleton<_i597.WorkoutsRemoteDatasource>(
        () => _i597.WorkoutsRemoteDatasource(
              gh<_i974.FirebaseFirestore>(),
              gh<_i59.FirebaseAuth>(),
            ));
    gh.lazySingleton<_i1067.AccountRepository>(() =>
        _i857.AccountRepositoryImpl(
            remoteDataSource: gh<_i302.AccountRemoteDataSource>()));
    gh.lazySingleton<_i361.Dio>(
        () => registerModules.dio(gh<String>(instanceName: 'BaseUrl')));
    gh.lazySingleton<_i430.OnboardingRepository>(() =>
        _i452.OnboardingRepositoryImpl(gh<_i608.OnboardingRemoteDatasource>()));
    gh.lazySingleton<_i626.AuthRepository>(() => _i877.AuthRepositoryImpl(
        remoteDataSource: gh<_i167.AuthRemoteDataSource>()));
    gh.lazySingleton<_i243.WorkoutsRepository>(() =>
        _i774.WorkoutsRepositoryImpl(gh<_i597.WorkoutsRemoteDatasource>()));
    gh.lazySingleton<_i928.GetUserFitnessProfileUseCase>(() =>
        _i928.GetUserFitnessProfileUseCase(gh<_i430.OnboardingRepository>()));
    gh.lazySingleton<_i1024.GetWorkoutByDayUsecase>(
        () => _i1024.GetWorkoutByDayUsecase(gh<_i243.WorkoutsRepository>()));
    gh.lazySingleton<_i653.GetWorkoutsUsecase>(
        () => _i653.GetWorkoutsUsecase(gh<_i243.WorkoutsRepository>()));
    gh.factory<_i475.UpdateUserProfileUseCase>(
        () => _i475.UpdateUserProfileUseCase(gh<_i1067.AccountRepository>()));
    gh.lazySingleton<_i488.GetFitnessProfileUsecase>(
        () => _i488.GetFitnessProfileUsecase(gh<_i430.OnboardingRepository>()));
    gh.lazySingleton<_i674.SaveFitnessProfileUsecase>(() =>
        _i674.SaveFitnessProfileUsecase(gh<_i430.OnboardingRepository>()));
    gh.factory<_i792.OnboardingBloc>(() => _i792.OnboardingBloc(
          gh<_i674.SaveFitnessProfileUsecase>(),
          gh<_i488.GetFitnessProfileUsecase>(),
        ));
    gh.lazySingleton<_i758.DioClient>(() => _i758.DioClient(
          gh<_i361.Dio>(),
          gh<String>(instanceName: 'ApiKey'),
        ));
    gh.lazySingleton<_i546.ClientProvider>(
        () => _i546.ClientProvider(gh<_i758.DioClient>()));
    gh.factory<_i410.WorkoutsBloc>(() => _i410.WorkoutsBloc(
          gh<_i653.GetWorkoutsUsecase>(),
          gh<_i1024.GetWorkoutByDayUsecase>(),
        ));
    gh.factory<_i708.AccountBloc>(() => _i708.AccountBloc(
        updateUserProfileUseCase: gh<_i475.UpdateUserProfileUseCase>()));
    gh.lazySingleton<_i46.SignInWithEmailAndPasswordUseCase>(() =>
        _i46.SignInWithEmailAndPasswordUseCase(gh<_i626.AuthRepository>()));
    gh.lazySingleton<_i46.SignUpWithEmailAndPasswordUseCase>(() =>
        _i46.SignUpWithEmailAndPasswordUseCase(gh<_i626.AuthRepository>()));
    gh.lazySingleton<_i46.SignInWithGoogleUseCase>(
        () => _i46.SignInWithGoogleUseCase(gh<_i626.AuthRepository>()));
    gh.lazySingleton<_i46.SignOutUseCase>(
        () => _i46.SignOutUseCase(gh<_i626.AuthRepository>()));
    gh.lazySingleton<_i46.GetAuthStateChangesUseCase>(
        () => _i46.GetAuthStateChangesUseCase(gh<_i626.AuthRepository>()));
    gh.lazySingleton<_i46.ResetPasswordUseCase>(
        () => _i46.ResetPasswordUseCase(gh<_i626.AuthRepository>()));
    gh.factory<_i797.AuthBloc>(() => _i797.AuthBloc(
          signInWithEmailAndPasswordUseCase:
              gh<_i46.SignInWithEmailAndPasswordUseCase>(),
          signUpWithEmailAndPasswordUseCase:
              gh<_i46.SignUpWithEmailAndPasswordUseCase>(),
          signInWithGoogleUseCase: gh<_i46.SignInWithGoogleUseCase>(),
          signOutUseCase: gh<_i46.SignOutUseCase>(),
          getAuthStateChangesUseCase: gh<_i46.GetAuthStateChangesUseCase>(),
          resetPasswordUseCase: gh<_i46.ResetPasswordUseCase>(),
        ));
    return this;
  }
}

class _$RegisterModules extends _i759.RegisterModules {}
