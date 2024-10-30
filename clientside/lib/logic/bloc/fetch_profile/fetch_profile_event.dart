// part of 'fetch_profile_bloc.dart';
import 'package:equatable/equatable.dart';

sealed class FetchProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProfileHit extends FetchProfileEvent {
  final String newToken;

  FetchProfileHit({required this.newToken}) : super();

  @override
  List<Object> get props => [newToken];
}

// part of 'fetch_home_bloc.dart';

// sealed class FetchHomeEvent extends Equatable {
//   const FetchHomeEvent();

//   @override
//   List<Object> get props => [];
// }

// class FetchHomeHit extends FetchHomeEvent {}
