// part of 'fetch_profile_bloc.dart';
import 'package:equatable/equatable.dart';

sealed class FetchProviderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProviderHit extends FetchProviderEvent {
  final String newToken;
  final int id;
  // bool isemergency

  FetchProviderHit({required this.newToken, required this.id}) : super();

  @override
  List<Object> get props => [newToken, id];
}

// part of 'fetch_home_bloc.dart';

// sealed class FetchHomeEvent extends Equatable {
//   const FetchHomeEvent();

//   @override
//   List<Object> get props => [];
// }

// class FetchHomeHit extends FetchHomeEvent {}
