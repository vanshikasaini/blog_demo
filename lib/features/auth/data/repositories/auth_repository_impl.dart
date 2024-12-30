import 'package:blog_demo/core/error/exceptions.dart';
import 'package:blog_demo/core/error/failures.dart';
import 'package:blog_demo/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_demo/features/auth/domain/entities/user.dart';
import 'package:blog_demo/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

/// sb is used because Supabase is also have User class and we also created User class

class AuthRepositoryImpl implements AuthRepository {
  // to get dependency injection use like this  without ==>  AuthRemoteDataSource remoteDataSource= AuthRemoteDataSource();
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
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    // try {
    //   // accepts User but remoteDataSource.signUpWithEmailPassword has USerModel
    //   final user = await remoteDataSource.loginWithEmailPassword(
    //     email: email,
    //     password: password,
    //   );
    //   return right(user);
    // } on ServerException catch (e) {
    //   return left(Failure(e.message));
    // }
    return _getUser(
      () async => await remoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

//Follows liskov substitution principle
  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    /// Instead of using biolerplate code or same code we used wrapper function which calls another function
    // try {
    //   // accepts User but remoteDataSource.signUpWithEmailPassword has USerModel
    //   final user = await remoteDataSource.signUpWithEmailPassword(
    //     name: name,
    //     email: email,
    //     password: password,
    //   );
    //   return right(user);
    // } on ServerException catch (e) {
    //   return left(Failure(e.message));
    // }
    return _getUser(
      () async => await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, String>> currentUser() {
    // TODO: implement currentUser
    throw UnimplementedError();
  }

// Wrapper Function
  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      // if (!await (connectionChecker.isConnected)) {
      //   return left(Failure(Constants.noConnectionErrorMessage));
      // }
      final user = await fn();

      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
