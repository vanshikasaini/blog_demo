import 'dart:io';

import 'package:blog_demo/core/usecase/usecase.dart';
import 'package:blog_demo/features/blogs/domain/entities/blog.dart';
import 'package:blog_demo/features/blogs/domain/usecases/get_all_blogs.dart';
import 'package:blog_demo/features/blogs/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogs _uploadBlog;
  final GetAllBlogs _getAllBlog;
  BlogBloc({required UploadBlogs uploadBlog, required GetAllBlogs getAllBlog})
      : _uploadBlog = uploadBlog,
        _getAllBlog = getAllBlog,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAllBlogs>(_onFetchAllBlogs);
  }
  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(UploadBlogsParams(
      image: event.image,
      title: event.title,
      content: event.content,
      posterId: event.posterId,
      topics: event.topics,
    ));

    res.fold(
      (l) => emit(BlogFailure(message: l.message)),
      (r) => emit(BlogUploadSuccess()),
    );
  }

  void _onFetchAllBlogs(
      BlogFetchAllBlogs event, Emitter<BlogState> emit) async {
    final res = await _getAllBlog(NoParams());
    res.fold(
      (l) => emit(BlogFailure(message: l.message)),
      (r) => emit(BlogDisplaySuccess(blogs: r)),
    );
  }
}
