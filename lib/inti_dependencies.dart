import 'package:blog_demo/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_demo/core/network/connection_checker.dart';
import 'package:blog_demo/core/secrets/app_secrets.dart';
import 'package:blog_demo/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_demo/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_demo/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_demo/features/auth/domain/usecases/current_user.dart';
import 'package:blog_demo/features/auth/domain/usecases/user_login.dart';
import 'package:blog_demo/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_demo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_demo/features/blogs/data/data_sources/blog_local_data_source.dart';
import 'package:blog_demo/features/blogs/data/data_sources/blog_remote_data_source.dart';
import 'package:blog_demo/features/blogs/data/repositories/blog_repository_impl.dart';
import 'package:blog_demo/features/blogs/domain/repositories/blog_repositor.dart';
import 'package:blog_demo/features/blogs/domain/usecases/get_all_blogs.dart';
import 'package:blog_demo/features/blogs/domain/usecases/upload_blog.dart';
import 'package:blog_demo/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'init_dependencies_main.dart';
