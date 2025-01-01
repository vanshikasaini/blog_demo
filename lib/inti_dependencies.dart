import 'package:blog_demo/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_demo/core/secrets/app_secrets.dart';
import 'package:blog_demo/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_demo/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_demo/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_demo/features/auth/domain/usecases/current_user.dart';
import 'package:blog_demo/features/auth/domain/usecases/user_login.dart';
import 'package:blog_demo/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_demo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_demo/features/blogs/data/data_sources/blog_remote_data_source.dart';
import 'package:blog_demo/features/blogs/data/repositories/blog_repository_impl.dart';
import 'package:blog_demo/features/blogs/domain/repositories/blog_repositor.dart';
import 'package:blog_demo/features/blogs/domain/usecases/get_all_blogs.dart';
import 'package:blog_demo/features/blogs/domain/usecases/upload_blog.dart';
import 'package:blog_demo/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supaBaseUrl, anonKey: AppSecrets.anonKeyUrl);
// Everytime create new instance of class - mostly not used
  //serviceLocator.registerFactory(factoryFunc);

  serviceLocator.registerLazySingleton(() => supabase.client);

//core - AppUserCubit - state required for lifetime
  serviceLocator.registerLazySingleton(() => AppUserCubit());
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
    // usecase Current User
    ..registerFactory<CurrentUser>(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initBlog() {
  //BlogRemoteDataSource - Datasource
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    //BlogRepository -repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        blogRemoteDataSource: serviceLocator(),
      ),
    ) //UploadBlogs UseCase
    ..registerFactory<UploadBlogs>(
      () => UploadBlogs(
        blogRepository: serviceLocator(),
      ),
    )
    // UseCase -GetAllBlogs
    ..registerFactory<GetAllBlogs>(
      () => GetAllBlogs(
        serviceLocator(),
      ),
    )
    // Bloc BlogBloc --> we have to maintain state so used registerLazySingleton
    ..registerLazySingleton<BlogBloc>(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        getAllBlog: serviceLocator(),
      ),
    );
}
