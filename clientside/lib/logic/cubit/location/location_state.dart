// part of 'Location_cubit.dart';

import 'package:equatable/equatable.dart';

sealed class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationLoaded extends LocationState {
  final String location;
  final List lonlag;
  const LocationLoaded({required this.location, required this.lonlag});

  @override
  List<Object> get props => [location, lonlag];
}

class LocationLoading extends LocationState {}
