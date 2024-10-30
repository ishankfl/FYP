// part of 'FetchMakeComplete_bloc.dart';

import 'package:equatable/equatable.dart';

sealed class MakeCompleteEvent extends Equatable {
  const MakeCompleteEvent();

  @override
  List<Object> get props => [];
}

class MakeCompleteClickedEvent extends MakeCompleteEvent {
  // final String email;

  final String token;
  final String bookId;

  // final bool rememberMe;
  const MakeCompleteClickedEvent({
    required this.token,
    required this.bookId,
  });
}
