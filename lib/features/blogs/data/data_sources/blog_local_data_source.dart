import 'package:blog_demo/features/blogs/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  void uploadLocalBlogs({required List<BlogModel> blogs});
  List<BlogModel> getAllBlogs();
}

class BlogLocalDataSourceImpl extends BlogLocalDataSource {
  final Box box;

  BlogLocalDataSourceImpl({required this.box});

  @override
  List<BlogModel> getAllBlogs() {
    List<BlogModel> blogs = [];
    // box.values.toList();
    for (int i = 0; i < box.length; i++) {
      blogs.add(
        BlogModel.fromJson(
          box.get(i.toString()),
        ),
      );
    }
    return blogs;
  }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    box.clear();
    // Convert List<BlogModel> into Map<String, BlogModel>

    //BlogModel must store as JSON in local storage to fecth as Json
    Map<String, dynamic> blogsMap = {
      for (var blog in blogs) blog.id: blog.toJson(),
    };
    box.putAll(blogsMap);
  }
}
