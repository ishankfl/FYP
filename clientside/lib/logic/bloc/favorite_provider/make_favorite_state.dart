import 'package:bookme/data/api/api_export.dart';
import 'package:bookme/data/model/favorite_provider_model.dart';
import 'package:bookme/data/model/model_export.dart';
import 'package:equatable/equatable.dart';

sealed class FavoriteProviderState extends Equatable {
  const FavoriteProviderState();

  @override
  List<Object> get props => [];
}

class FavoriteProviderInitial extends FavoriteProviderState {}

class FavoriteProviderLoading extends FavoriteProviderState {}

class FavoriteProviderLoaded extends FavoriteProviderState {
  final FavoriteProviderModel model;

  const FavoriteProviderLoaded({required this.model});

  @override
  List<Object> get props => [model];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model.toMap(),
    };
  }

  factory FavoriteProviderLoaded.fromMap(Map<String, dynamic> map) {
    try {
      return FavoriteProviderLoaded(
        model: FavoriteProviderModel.fromMap(map['model']),
      );
    } catch (e) {
      FavoriteProviderInitial();
      return FavoriteProviderLoaded(
        model: FavoriteProviderModel.fromMap(map['model']),
      );
    }
  }

  String toJson() => json.encode(toMap());

  factory FavoriteProviderLoaded.fromJson(String source) =>
      FavoriteProviderLoaded.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

class FavoriteProviderError extends FavoriteProviderState {
  final String? message;

  const FavoriteProviderError({required this.message});

  @override
  List<Object> get props => [message!];
}
