// part of 'fetch_profile_bloc.dart';
import 'package:equatable/equatable.dart';

sealed class FetchEmergencyProviderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchEmergencyProviderHit extends FetchEmergencyProviderEvent {
  final String newToken;
  final String serviceName;
  FetchEmergencyProviderHit({required this.newToken, required this.serviceName})
      : super();

  @override
  List<Object> get props => [newToken, serviceName];
}
