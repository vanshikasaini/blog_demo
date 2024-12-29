import 'package:blog_demo/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

// SuccessType -generic  pass in each usecase,
// Params - params pass in each usecase,
abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}
