import 'dart:convert';
import 'package:bookme/data/model/loginsignupmodel/verification_response_model.dart';
import 'package:bookme/data/repository/authetication/verification_response_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc
    extends HydratedBloc<VerificationEvent, VerificationState> {
  VerificationBloc({required VerificationResponseRepository apiRepository})
      : super(VerificationInitial()) {
    on<VerificationClickEvent>((event, emit) async {
      try {
        emit(VerificationLoading());
        print("THis is signupuserloading");
        // print(event);
        final verify = await apiRepository.verifyUser(
          is_forgot_password: event.is_forgot_password,
          secret_code: event.secret_code,
          email: event.email,
          entered_otp: event.otp,
        );

        print('This is the error ${verify.error}');
        if (verify.error == "") {
          print("error not found");
          print(verify.error);
          emit(VerificationError(message: verify.error));
          return;
        }
        if (verify.error != null) {
          emit(VerificationError(message: verify.error));
          return;
        }
        emit(VerificationLoaded(
          verifyModel: verify,
        ));
      } catch (Exception) {
        emit(const VerificationError(
            message: "Failed to fetch data, is your device online?"));
      }
    });
  }
  @override
  void onChange(Change<VerificationState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
    print(super.storageToken);
  }

  @override
  VerificationState fromJson(Map<String, dynamic> json) {
    try {
      return VerificationLoaded.fromMap(json);
    } catch (e) {
      return VerificationInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(VerificationState state) {
    if (state is VerificationLoaded) {
      return state.toMap();
    }
    return {};
  }
}
