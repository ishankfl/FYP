import 'package:bookme/data/repository/authetication/forgot_password_repo.dart';
import 'package:bookme/logic/bloc_export.dart';

class ForgotPasswordBloc
    extends HydratedBloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({required ForgotPasswordRepository apiRepository})
      : super(ForgotPasswordInitial()) {
    on<ForgotPasswordClickedEvent>((event, emit) async {
      try {
        emit(ForgotPasswordLoading());
        final forgotPassword =
            await apiRepository.forgotPassword(email: event.email);

        if (forgotPassword.error != null) {
          emit(ForgotPasswordError(message: forgotPassword.error));
          return;
        }
        emit(ForgotPasswordLoaded(
          forgotPasswordModel: forgotPassword,
        ));
      } catch (exc) {
        emit(const ForgotPasswordError(
            message: "Failed to fetch data, is your device online?"));
      }
    });
  }
  @override
  void onChange(Change<ForgotPasswordState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }

  @override
  ForgotPasswordState fromJson(Map<String, dynamic> json) {
    try {
      return ForgotPasswordLoaded.fromMap(json);
    } catch (e) {
      return ForgotPasswordInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(ForgotPasswordState state) {
    if (state is ForgotPasswordLoaded) {
      return state.toMap();
    }
    return {};
  }
}
