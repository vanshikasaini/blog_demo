import 'package:bloc/bloc.dart';
import 'package:blog_demo/features/auth/domain/entities/user.dart';
import 'package:blog_demo/features/auth/domain/usecases/user_login.dart';
import 'package:blog_demo/features/auth/domain/usecases/user_sign_up.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  //
  //AuthBloc(this._userSignUp); but we have multiple usecase then below
  // declaration
  //
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
  }
  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    //_userSignUp.call() ==> if we do like below declaration it will automatically trigger call()
    final res = await _userLogin(UserLoginParams(
      email: event.email,
      password: event.password,
    ));
    // bloc is place where we decide to show error or succes on UI
    // failure -- Failure , String as response so uId is String after full setup we will have USer as Response
    res.fold((failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess(user)));
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    //_userSignUp.call() ==> if we do like below declaration it will automatically trigger call()
    final res = await _userSignUp(UserSignUpParams(
        email: event.email, password: event.password, name: event.name));
    // bloc is place where we decide to show error or succes on UI
    // failure -- Failure , String as response so uId is String after full setup we will have USer as Response
    res.fold((failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess(user)));
  }
}
