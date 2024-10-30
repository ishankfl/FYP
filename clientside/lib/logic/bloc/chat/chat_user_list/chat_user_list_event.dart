// import 'package:bookme/logic/bloc/signup/user_signup_state.dart';
// part of 'user.dart';

import 'package:equatable/equatable.dart';

sealed class ChatUserListEvent extends Equatable {
  const ChatUserListEvent();

  @override
  List<Object> get props => [];
}

class FetchChatUserListEvent extends ChatUserListEvent {
  final String token;
  const FetchChatUserListEvent({required this.token});
}
