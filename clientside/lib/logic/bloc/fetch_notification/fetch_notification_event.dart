import 'package:equatable/equatable.dart';

sealed class FetchNotificationEvent extends Equatable {
  const FetchNotificationEvent();

  @override
  List<Object> get props => [];
}

class FetchNotificationDetailsClickedEvent extends FetchNotificationEvent {
  // final String email;
  final String token;
  // final bool rememberMe;
  const FetchNotificationDetailsClickedEvent({required this.token});
}

class ClearNotificationDetailsClickedEvent extends FetchNotificationEvent {}
