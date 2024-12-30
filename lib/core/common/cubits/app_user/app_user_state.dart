part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLoggedIn extends AppUserState {
  //core cannot depend on other features /folders so we cut enities -user from domqin to core folder
  // as domain layer (other features )can use (core)User from core but core folder must be independent
  final User user;

  AppUserLoggedIn(this.user);
}
