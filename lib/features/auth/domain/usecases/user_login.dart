// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/src/either.dart';

import 'package:blog_demo/core/error/failures.dart';
import 'package:blog_demo/core/usecase/usecase.dart';
import 'package:blog_demo/features/auth/domain/entities/user.dart';
import 'package:blog_demo/features/auth/domain/repository/auth_repository.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  AuthRepository _authRepository;
  UserLogin(
    this._authRepository,
  );
  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await _authRepository.loginWithEmailPassword(
        email: params.email, password: params.password);
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
