part of 'fetch_home_bloc.dart';

class FetchHomeState extends Equatable {
  const FetchHomeState();

  @override
  List<Object> get props {
    return [];
  }
}

class FetchLoadingState extends FetchHomeState {}

class FetchErrorState extends FetchHomeState {
  final String message;

  const FetchErrorState({required this.message});
  @override
  List<Object> get props {
    return [message];
  }
}

// ignore: must_be_immutable
class FetchLoadedState extends FetchHomeState {
  final List<ServicesModel> servicesModel;
  const FetchLoadedState({required this.servicesModel});
  @override
  List<Object> get props {
    return [servicesModel];
  }
}
