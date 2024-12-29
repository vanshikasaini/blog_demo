import 'package:blog_demo/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  //Session? get currentUserSession;
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  });
  //Future<String?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);

  // @override
  // Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw const ServerException('User is null!');
      }
      return response.user!.id;
      // return String.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
    // // TODO: implement
//     throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {
          'name': name,
        },
      );
      if (response.user == null) {
        throw const ServerException('User is null!');
      }
      return response.user!.id;
      // return String.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  // @override
  // Future<String?> getCurrentUserData() async {
  //   try {
  //     if (currentUserSession != null) {
  //       final userData = await supabaseClient.from('profiles').select().eq(
  //             'id',
  //             currentUserSession!.user.id,
  //           );
  //       return String.fromJson(userData.first).copyWith(
  //         email: currentUserSession!.user.email,
  //       );
  //     }

  //     return null;
  //   } catch (e) {
  //     throw ServerException(e.toString());
  //   }
  // }
}
