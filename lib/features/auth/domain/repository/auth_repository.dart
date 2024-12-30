import 'package:blog_demo/core/error/failures.dart';
import 'package:blog_demo/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  // SUperbase will return Future
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> currentUser();
}
