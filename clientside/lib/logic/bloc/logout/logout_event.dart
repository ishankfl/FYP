import 'package:equatable/equatable.dart';

sealed class LogoutEvent extends Equatable {
  const LogoutEvent();

  @override
  List<Object> get props => [];
}

class LogoutClickedEvent extends LogoutEvent {
  final String token;
  const LogoutClickedEvent({required this.token});
}
