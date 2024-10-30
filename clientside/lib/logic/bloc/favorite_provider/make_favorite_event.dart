import 'package:equatable/equatable.dart';

sealed class FavoriteProviderEvent extends Equatable {
  const FavoriteProviderEvent();

  @override
  List<Object> get props => [];
}

class FavoriteProviderClickedEvent extends FavoriteProviderEvent {
  final String serviceProvider;
  final String token;
  final bool isFavorite;
  const FavoriteProviderClickedEvent({
    required this.serviceProvider,
    required this.token,
    required this.isFavorite,
  });
}

class ClearFavoriteProviderDetail extends FavoriteProviderEvent {}
