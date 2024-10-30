import 'package:bookme/data/repository/favorite_provider_repo.dart';
import 'package:bookme/logic/bloc/favorite_provider/make_favorite_event.dart';
import 'package:bookme/logic/bloc/favorite_provider/make_favorite_state.dart';
import 'package:bookme/logic/bloc_export.dart';

class FavoriteProviderBloc
    extends HydratedBloc<FavoriteProviderEvent, FavoriteProviderState> {
  FavoriteProviderBloc({required FavoriteProviderRepo apiRepository})
      : super(FavoriteProviderInitial()) {
    on<ClearFavoriteProviderDetail>((event, emit) => FavoriteProviderInitial());
    on<FavoriteProviderClickedEvent>((event, emit) async {
      try {
        emit(FavoriteProviderLoading());
        final favprovider = await apiRepository.favorite(
            isFavorite: event.isFavorite,
            serviceProvider: event.serviceProvider,
            token: event.token);

        if (favprovider.error != null) {
          emit(FavoriteProviderError(message: favprovider.message));
          return;
        }
        emit(FavoriteProviderLoaded(
          model: favprovider,
        ));
      } catch (exc) {
        emit(const FavoriteProviderError(
            message: "Failed to change, is your device is onlien online?"));
      }
    });
  }
  @override
  void onChange(Change<FavoriteProviderState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }

  @override
  FavoriteProviderState fromJson(Map<String, dynamic> json) {
    try {
      return FavoriteProviderLoaded.fromMap(json);
    } catch (e) {
      return FavoriteProviderInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(FavoriteProviderState state) {
    if (state is FavoriteProviderLoaded) {
      return state.toMap();
    }
    return {};
  }
}
