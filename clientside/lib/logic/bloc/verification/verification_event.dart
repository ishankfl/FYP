part of 'verification_bloc.dart';
// import 'package:bookme/logic/bloc/signup/user_signup_state.dart';
// part of 'user.dart';

sealed class VerificationEvent extends Equatable {
  const VerificationEvent();

  @override
  List<Object> get props => [];
}

class VerificationClickEvent extends VerificationEvent {
  final String otp;
  final String email;
  final String secret_code;
  final String is_forgot_password;
  // final String city;
  // final String phonenumber;
  // final String password;
  const VerificationClickEvent(
      {required this.is_forgot_password,
      required this.email,
      required this.otp,
      required this.secret_code});
  //   print("THis is signuinuserevent");
  //   print(email);
  //   print(city);
  //   print(phonenumber);
  //   print(full_name);
  //   print(password);
  // }
}
