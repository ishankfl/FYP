import 'package:equatable/equatable.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginClickedEvent extends LoginEvent {
  final String email;
  final String password;
  final bool rememberMe;
  const LoginClickedEvent(
      {required this.email, required this.password, required this.rememberMe});
}

class ClearLoginDetail extends LoginEvent {}
