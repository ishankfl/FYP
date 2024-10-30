import 'package:equatable/equatable.dart';

sealed class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangePasswordClickedEvent extends ChangePasswordEvent {
  final String email;
  final String password;
  const ChangePasswordClickedEvent(
      {required this.password, required this.email});
}
