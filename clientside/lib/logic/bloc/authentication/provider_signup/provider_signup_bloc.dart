// ignore_for_file: avoid_print

import 'package:bookme/data/repository/authetication/provider_signup_repo.dart';
import 'package:bookme/logic/bloc/authentication/provider_signup/provider_signup_event.dart';
import 'package:bookme/logic/bloc/authentication/provider_signup/provider_signup_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ProviderSignupUserBloc
    extends Bloc<ProviderSignupUserEvent, ProviderSignupUserState> {
  ProviderSignupUserBloc({required ProviderSignupRepository apiRepository})
      : super(ProviderSignupUserInitial()) {
    on<ProviderSignupUserClickEvent>((event, emit) async {
      emit(ProviderSignupUserLoading());

      try {
        final providerSignup = await apiRepository.signUp(
            email: event.email,
            certificate: event.certificate,
            profile: event.profile,
            experience: event.experience,
            service_type: event.service_type);
        print("Inthe bloc");

        if (providerSignup.error != null) {
          print("Inthe bloc");
          emit(ProviderSignupUserError(message: providerSignup.error));
          return;
        }
        emit(ProviderSignupUserLoaded(
          userModel: providerSignup,
        ));
      } catch (exe) {
        emit(ProviderSignupUserError(message: "Is your device is offline?"));
      }
    });
  }
  @override
  void onChange(Change<ProviderSignupUserState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
    // print(super.storageToken);
  }

  ProviderSignupUserState fromJson(Map<String, dynamic> json) {
    try {
      return ProviderSignupUserLoaded.fromMap(json);
    } catch (e) {
      return ProviderSignupUserInitial();
    }
  }

  Map<String, dynamic>? toJson(ProviderSignupUserState state) {
    if (state is ProviderSignupUserLoaded) {
      return state.toMap();
    }
    return {};
  }
}
