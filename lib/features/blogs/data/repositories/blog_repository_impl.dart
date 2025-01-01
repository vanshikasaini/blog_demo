// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:blog_demo/core/error/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import 'package:blog_demo/core/error/failures.dart';
import 'package:blog_demo/features/blogs/data/data_sources/blog_remote_data_source.dart';
import 'package:blog_demo/features/blogs/data/models/blog_model.dart';
import 'package:blog_demo/features/blogs/domain/entities/blog.dart';

import '../../domain/repositories/blog_repositor.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  BlogRepositoryImpl({
    required this.blogRemoteDataSource,
  });
  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );
      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );

      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
      debugPrint("BlogRepositoryImpl => 1");
      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      final blogs = await blogRemoteDataSource.getAllBlogs();

      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
