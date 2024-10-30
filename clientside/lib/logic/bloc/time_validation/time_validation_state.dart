import 'package:bookme/data/model/time_validation_model.dart';
import 'package:equatable/equatable.dart';

class TimeValidationState extends Equatable {
  const TimeValidationState();

  @override
  List<Object> get props {
    return [];
  }
}

class TimeValidationLoadingState extends TimeValidationState {}

class TimeValidationErrorState extends TimeValidationState {
  final String message;

  const TimeValidationErrorState({required this.message});
  @override
  List<Object> get props {
    return [message];
  }
}

// ignore: must_be_immutable
class TimeValidationLoadedState extends TimeValidationState {
  final TimeValidationModel model;
  const TimeValidationLoadedState({required this.model});
  @override
  List<Object> get props {
    return [model];
  }
}
