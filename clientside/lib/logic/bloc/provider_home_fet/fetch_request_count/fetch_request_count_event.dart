import 'package:equatable/equatable.dart';

sealed class FetchRequestCountEvent extends Equatable {
  const FetchRequestCountEvent();

  @override
  List<Object> get props => [];
}

class FetchRequestCountHit extends FetchRequestCountEvent {
  final String token;

  FetchRequestCountHit({required this.token});
}
