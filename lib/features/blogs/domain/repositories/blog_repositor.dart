import 'dart:io';

import 'package:blog_demo/core/error/failures.dart';
import 'package:blog_demo/features/blogs/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  });
  Future<Either<Failure, List<Blog>>> getAllBlogs();
  // Future<String> uploadBlogImage(
  //     {required File image, required BlogModel blog});
}
