import 'package:bookme/data/repository/authetication/forgot_password_repo.dart';
import 'package:bookme/logic/bloc_export.dart';

class ChangePasswordBloc
    extends HydratedBloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc({required ForgotPasswordRepository apiRepository})
      : super(ChangePasswordInitial()) {
    on<ChangePasswordClickedEvent>((event, emit) async {
      try {
        emit(ChangePasswordLoading());
        final ChangePassword = await apiRepository.changePassword(
            email: event.email, password: event.password);

        if (ChangePassword.error != null) {
          emit(ChangePasswordError(message: ChangePassword.error));
          return;
        }
        emit(ChangePasswordLoaded(
          ChangePasswordModel: ChangePassword,
        ));
      } catch (exc) {
        emit(const ChangePasswordError(
            message: "Failed to fetch data, is your device online?"));
      }
    });
  }
  @override
  void onChange(Change<ChangePasswordState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }

  @override
  ChangePasswordState fromJson(Map<String, dynamic> json) {
    try {
      return ChangePasswordLoaded.fromMap(json);
    } catch (e) {
      return ChangePasswordInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(ChangePasswordState state) {
    if (state is ChangePasswordLoaded) {
      return state.toMap();
    }
    return {};
  }
}
