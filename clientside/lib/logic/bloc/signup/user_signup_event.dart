part of 'user_signup_bloc.dart';
// import 'package:bookme/logic/bloc/signup/user_signup_state.dart';
// part of 'user.dart';

sealed class SignUpUserEvent extends Equatable {
  const SignUpUserEvent();

  @override
  List<Object> get props => [];
}

class SignUpUserClickEvent extends SignUpUserEvent {
  final String full_name;
  final String email;
  final String city;
  final String phonenumber;
  final String password;
  final String user_type;
  final String location;
  const SignUpUserClickEvent(
      {required this.email,
      required this.location,
      required this.city,
      required this.phonenumber,
      required this.full_name,
      required this.password,
      required this.user_type});
}

class UpdateUserClickEvent extends SignUpUserEvent {
  UserModel model;
  UpdateUserClickEvent({required this.model});
  // String? full_name;
  // String? email;
  // String? city;
  // String? full_name;
}
