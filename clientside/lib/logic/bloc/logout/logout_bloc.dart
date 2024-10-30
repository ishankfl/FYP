import 'package:bookme/data/repository/authetication/logout_repo.dart';
import 'package:bookme/logic/bloc_export.dart';

class LogoutBloc extends HydratedBloc<LogoutEvent, LogoutState> {
  LogoutBloc({required LogoutRespository apiRepository})
      : super(LogoutInitial()) {
    on<LogoutClickedEvent>((event, emit) async {
      try {
        emit(LogoutLoading());
        final login = await apiRepository.logOutUser(token: event.token);

        if (login.error != null) {
          emit(LogoutError(message: login.message));
          return;
        }
        emit(LogoutLoaded(
          loginModel: login,
        ));
      } catch (exc) {
        emit(const LogoutError(
            message: "Failed to fetch data, is your device online?"));
      }
    });
  }
  @override
  void onChange(Change<LogoutState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }

  @override
  LogoutState fromJson(Map<String, dynamic> json) {
    try {
      return LogoutLoaded.fromMap(json);
    } catch (e) {
      return LogoutInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(LogoutState state) {
    if (state is LogoutLoaded) {
      return state.toMap();
    }
    return {};
  }
}
