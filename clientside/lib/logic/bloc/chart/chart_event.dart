// part of 'FetchChart_bloc.dart';

import 'package:equatable/equatable.dart';

sealed class ChartEvent extends Equatable {
  const ChartEvent();

  @override
  List<Object> get props => [];
}

class ChartClickedEvent extends ChartEvent {
  // final String email;

  final String token;

  // final bool rememberMe;
  const ChartClickedEvent({
    required this.token,
  });
}
