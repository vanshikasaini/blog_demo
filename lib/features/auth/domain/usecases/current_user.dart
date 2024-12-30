import 'package:blog_demo/core/error/failures.dart';
import 'package:blog_demo/core/usecase/usecase.dart';
import 'package:blog_demo/core/common/entities/user.dart';
import 'package:blog_demo/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository _authRepository;

  CurrentUser(AuthRepository authRepository) : _authRepository = authRepository;
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await _authRepository.currentUser();
  }
}
