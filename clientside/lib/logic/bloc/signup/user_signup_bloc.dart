import 'dart:convert';
import 'package:bookme/data/model/user_model.dart';
import 'package:bookme/data/repository/authetication/usersignup_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'user_signup_event.dart';
part 'user_signup_state.dart';

class SignUpUserBloc extends Bloc<SignUpUserEvent, SignUpUserState> {
  SignUpUserBloc({required SignUpUserRepository apiRepository})
      : super(SignUpUserInitial()) {
    on<SignUpUserClickEvent>((event, emit) async {
      emit(SignUpUserLoading());
      try {
        final signUpUser = await apiRepository.signUp(
            full_name: event.full_name,
            city: event.city,
            email: event.email,
            password: event.password,
            phonenumber: event.phonenumber,
            user_type: event.user_type,
            location: event.location);
        if (signUpUser.error != null) {
          emit(SignUpUserError(message: signUpUser.error));
          return;
        }
        emit(SignUpUserLoaded(
          userModel: signUpUser,
        ));
      } catch (Exception) {
        emit(SignUpUserError(message: "Is your device is offline?"));
      }
    });

    on<UpdateUserClickEvent>(
      (event, emit) async {
        emit(UpdateUserLoading());
        try {
          final signUpUser = await apiRepository.updateUser(model: event.model);
          print("Inthe bloc");

          if (signUpUser.error != null) {
            print("Inthe bloc");
            emit(UpdateUserError(message: signUpUser.error));
            return;
          }
          emit(UpdateUserLoaded(
            userModel: signUpUser,
          ));
        } catch (Exception) {
          emit(UpdateUserError(message: "Is your went?"));
        }
      },
    );
  }
  @override
  void onChange(Change<SignUpUserState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
    // print(super.storageToken);
  }

  @override
  SignUpUserState fromJson(Map<String, dynamic> json) {
    try {
      print(json);
      return SignUpUserLoaded.fromMap(json);
    } catch (e) {
      return SignUpUserInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(SignUpUserState state) {
    if (state is SignUpUserLoaded) {
      return state.toMap();
    }
    return {};
  }
}
