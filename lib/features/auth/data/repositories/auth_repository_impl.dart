import 'package:blog_demo/core/error/exceptions.dart';
import 'package:blog_demo/core/error/failures.dart';
import 'package:blog_demo/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_demo/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  // final ConnectionChecker connectionChecker;
  const AuthRepositoryImpl(
    this.remoteDataSource,
    // this.connectionChecker,
  );

  // @override
  // Future<Either<Failure, String>> currentUser() async {
  //   try {
  //     if (!await (connectionChecker.isConnected)) {
  //       // final session = remoteDataSource.currentUserSession;

  //       if (session == null) {
  //         return left(Failure('User not logged in!'));
  //       }

  //       return right(
  //         UserModel(
  //           id: session.user.id,
  //           email: session.user.email ?? '',
  //           name: '',
  //         ),
  //       );
  //     }
  //     final user = await remoteDataSource.getCurrentUserData();
  //     if (user == null) {
  //       return left(Failure('User not logged in!'));
  //     }

  //     return right(user);
  //   } on ServerException catch (e) {
  //     return left(Failure(e.message));
  //   }
  // }

  @override
  Future<Either<Failure, String>> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // async {
    throw UnimplementedError();
    // return
    // _getUser(
    //   () async =>
    //   await remoteDataSource.loginWithEmailPassword(
    //     email: email,
    //     password: password,
    //   ),
    // );
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userId = await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
    // return _getUser(
    //   () async => await remoteDataSource.signUpWithEmailPassword(
    //     name: name,
    //     email: email,
    //     password: password,
    //   ),
    // );
  }

  @override
  Future<Either<Failure, String>> currentUser() {
    // TODO: implement currentUser
    throw UnimplementedError();
  }

  // Future<Either<Failure, String>> _getUser(
  //   Future<String> Function() fn,
  // ) async {
  //   try {
  //     if (!await (connectionChecker.isConnected)) {
  //       return left(Failure(Constants.noConnectionErrorMessage));
  //     }
  //     final user = await fn();

  //     return right(user);
  //   } on ServerException catch (e) {
  //     return left(Failure(e.message));
  //   }
  // }
}
