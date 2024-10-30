import 'package:bookme/data/model/service_provider_model.dart';
import 'package:equatable/equatable.dart';

// part of 'fetch_providers_bloc.dart';

class FetchProviderState extends Equatable {
  const FetchProviderState();

  @override
  List<Object> get props {
    return [];
  }
}

class FetchProviderLoadingState extends FetchProviderState {}

class FetchProviderErrorState extends FetchProviderState {
  final String message;

  const FetchProviderErrorState({required this.message});
  @override
  List<Object> get props {
    return [message];
  }
}

class FetchProviderEmptyState extends FetchProviderState {
  final String message;

  const FetchProviderEmptyState({required this.message});
  @override
  List<Object> get props {
    return [message];
  }
}

// ignore: must_be_immutable
class FetchProviderLoadedState extends FetchProviderState {
  final List<ServiceProviderModel> providerModel;
  const FetchProviderLoadedState({required this.providerModel});
  @override
  List<Object> get props {
    return [providerModel];
  }
}
