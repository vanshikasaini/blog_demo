part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogSuccess extends BlogState {}

final class BlogFailure extends BlogState {
  final String message;

  BlogFailure({required this.message});
}

final class BlogUploadSuccess extends BlogState {}

final class BlogDisplaySuccess extends BlogState {
  final List<Blog> blogs;

  BlogDisplaySuccess({required this.blogs});
}
