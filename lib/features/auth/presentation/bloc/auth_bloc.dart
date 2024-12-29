import 'package:bloc/bloc.dart';
import 'package:blog_demo/features/auth/domain/usecases/user_sign_up.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  //
  //AuthBloc(this._userSignUp); but we have multiple usecase then below
  // declaration
  //
  AuthBloc({required UserSignUp userSignUp})
      : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      //_userSignUp.call() ==> if we do like below declaration it will automatically trigger call()
      final res = await _userSignUp(UserSignUpParams(
          email: event.email, password: event.password, name: event.name));
      // bloc is place where we decide to show error or succes on UI
      // failure -- Failure , String as response so uId is String
      res.fold((failure) => emit(AuthFailure(failure.message)),
          (uId) => emit(AuthSuccess(uId)));
    });
  }
}
