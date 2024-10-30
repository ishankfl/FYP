// import 'package:bookme/logic/bloc/signup/user_signup_state.dart';
// part of 'user.dart';

import 'package:equatable/equatable.dart';

sealed class IndividualChatEvent extends Equatable {
  const IndividualChatEvent();

  @override
  List<Object> get props => [];
}

class FetchIndividualChatEvent extends IndividualChatEvent {
  final String token;
  final String toId;
  const FetchIndividualChatEvent({required this.token, required this.toId});
}
