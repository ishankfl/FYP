part of 'fetch_home_bloc.dart';

sealed class FetchHomeEvent extends Equatable {
  const FetchHomeEvent();

  @override
  List<Object> get props => [];
}

class FetchHomeHit extends FetchHomeEvent {}
