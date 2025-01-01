import 'dart:io';

import 'package:blog_demo/core/error/failures.dart';
import 'package:blog_demo/core/usecase/usecase.dart';
import 'package:blog_demo/features/blogs/domain/entities/blog.dart';
import 'package:blog_demo/features/blogs/domain/repositories/blog_repositor.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlogs implements UseCase<Blog, UploadBlogsParams> {
  final BlogRepository blogRepository;

  UploadBlogs({required this.blogRepository});
  @override
  Future<Either<Failure, Blog>> call(UploadBlogsParams params) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
    );
  }
}

class UploadBlogsParams {
  final File image;
  final String title;
  final String content;
  final String posterId;
  final List<String> topics;

  UploadBlogsParams({
    required this.image,
    required this.title,
    required this.content,
    required this.posterId,
    required this.topics,
  });
}
