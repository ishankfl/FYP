import 'package:equatable/equatable.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordClickedEvent extends ForgotPasswordEvent {
  final String email;
  const ForgotPasswordClickedEvent({required this.email});
}
