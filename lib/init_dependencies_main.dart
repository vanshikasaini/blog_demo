part of 'inti_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supaBaseUrl, anonKey: AppSecrets.anonKeyUrl);
  // Get the directory for Hive
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  // Optionally, open a box
  await Hive.openBox('blogs');
// Everytime create new instance of class - mostly not used
  //serviceLocator.registerFactory(factoryFunc);
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(
    () => Hive.box('blogs'),
  );

//core - AppUserCubit - state required for lifetime
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      serviceLocator(),
    ),
  );
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
    ) //BlogLocalDataSource = Local DataSource
    ..registerFactory<BlogLocalDataSource>(
      () => BlogLocalDataSourceImpl(
        box: serviceLocator(),
      ),
    )
    //BlogRepository -repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        blogRemoteDataSource: serviceLocator(),
        blogLocalDataSource: serviceLocator(),
        connectionChecker: serviceLocator(),
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
