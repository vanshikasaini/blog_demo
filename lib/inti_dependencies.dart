import 'package:blog_demo/core/secrets/app_secrets.dart';
import 'package:blog_demo/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_demo/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_demo/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_demo/features/auth/domain/usecases/user_login.dart';
import 'package:blog_demo/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_demo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supaBaseUrl, anonKey: AppSecrets.anonKeyUrl);
// Everytime create new instance of class - mostly not used
  //serviceLocator.registerFactory(factoryFunc);

  serviceLocator.registerLazySingleton(() => supabase.client);
}
//register dependencies with Service Locator

void _initAuth() {
  // serviceLocator.registerFactory<AuthRemoteDataSource>(
  //   () => AuthRemoteDataSourceImpl(
  //     serviceLocator(),
  //   ),
  // );

  // serviceLocator.registerFactory<AuthRepository>(
  //   () => AuthRepositoryImpl(
  //     serviceLocator(),
  //   ),
  // );
  // serviceLocator.registerFactory<UserSignUp>(
  //   () => UserSignUp(
  //     serviceLocator(),
  //   ),
  // );

  // serviceLocator.registerFactory<UserLogin>(
  //   () => UserLogin(
  //     serviceLocator(),
  //   ),
  // );
  // serviceLocator.registerLazySingleton(
  //   () => AuthBloc(
  //     userSignUp: serviceLocator(),
  //     userLogin: serviceLocator(),
  //   ),
  // );

  /// Code Reformate
  /// Data source
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    //Usecase Signup
    ..registerFactory<UserSignUp>(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    //Usecase Login
    ..registerFactory<UserLogin>(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
      ),
    );
}
