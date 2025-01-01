import 'package:blog_demo/core/error/failures.dart';
import 'package:blog_demo/core/usecase/usecase.dart';
import 'package:blog_demo/features/blogs/domain/entities/blog.dart';
import 'package:blog_demo/features/blogs/domain/repositories/blog_repositor.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;

  GetAllBlogs(this.blogRepository);
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}
