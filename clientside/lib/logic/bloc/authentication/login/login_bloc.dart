import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/data/repository/authetication/login_repo.dart';

class LoginBloc extends HydratedBloc<LoginEvent, LoginState> {
  LoginBloc({required LoginRepository apiRepository, required bool rememberMe})
      : super(LoginInitial()) {
    on<ClearLoginDetail>((event, emit) => LoginInitial());
    on<LoginClickedEvent>((event, emit) async {
      try {
        emit(LoginLoading());
        final login = await apiRepository.loginUser(
            email: event.email, password: event.password);

        if (login.error != null) {
          emit(LoginError(message: login.error));
          return;
        }
        emit(LoginLoaded(
          loginModel: login,
        ));
      } catch (exc) {
        emit(const LoginError(
            message: "Failed to fetch data, is your device online?"));
      }
    });
  }
  @override
  void onChange(Change<LoginState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }

  @override
  LoginState fromJson(Map<String, dynamic> json) {
    try {
      return LoginLoaded.fromMap(json);
    } catch (e) {
      return LoginInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(LoginState state) {
    if (state is LoginLoaded) {
      return state.toMap();
    }
    return {};
  }
}
