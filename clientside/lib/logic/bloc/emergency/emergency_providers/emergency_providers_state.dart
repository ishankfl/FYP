import 'package:bookme/data/model/service_provider_model.dart';
import 'package:equatable/equatable.dart';

// part of 'fetch_providers_bloc.dart';

class FetchEmergencyProviderState extends Equatable {
  const FetchEmergencyProviderState();

  @override
  List<Object> get props {
    return [];
  }
}

class FetchEmergencyProviderLoadingState extends FetchEmergencyProviderState {}

class FetchEmergencyProviderErrorState extends FetchEmergencyProviderState {
  final String message;

  const FetchEmergencyProviderErrorState({required this.message});
  @override
  List<Object> get props {
    return [message];
  }
}

class FetchEmergencyProviderEmptyState extends FetchEmergencyProviderState {
  final String message;

  const FetchEmergencyProviderEmptyState({required this.message});
  @override
  List<Object> get props {
    return [message];
  }
}

// ignore: must_be_immutable
class FetchEmergencyProviderLoadedState extends FetchEmergencyProviderState {
  final List<ServiceProviderModel> providerModel;
  const FetchEmergencyProviderLoadedState({required this.providerModel});
  @override
  List<Object> get props {
    return [providerModel];
  }
}
