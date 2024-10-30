import 'package:bookme/data/model/request_count_model.dart';
import 'package:equatable/equatable.dart';

class FetchRequestCountState extends Equatable {
  const FetchRequestCountState();

  @override
  List<Object> get props {
    return [];
  }
}

class FetchRequestCountLoadingState extends FetchRequestCountState {}

class FetchRequestCountErrorState extends FetchRequestCountState {
  final String message;

  const FetchRequestCountErrorState({required this.message});
  @override
  List<Object> get props {
    return [message];
  }
}

// ignore: must_be_immutable
class FetchRequestCountLoadedState extends FetchRequestCountState {
  final List<RequestCountModel> model;
  const FetchRequestCountLoadedState({required this.model});
  @override
  List<Object> get props {
    return [model];
  }
}
