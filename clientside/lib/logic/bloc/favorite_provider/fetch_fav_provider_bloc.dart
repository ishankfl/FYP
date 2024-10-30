import 'package:bookme/data/repository/favorite_provider_repo.dart';
import 'package:bookme/logic/bloc/favorite_provider/fetch_fav_provider_event.dart';
import 'package:bookme/logic/bloc/favorite_provider/fetch_fav_provider_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class FetchFavProviderBloc
    extends HydratedBloc<FetchFavProviderEvent, FetchFavProviderState> {
  FetchFavProviderBloc({required FavoriteProviderRepo apiRepository})
      : super(FetchFavProviderInitial()) {
    on<ClearFetchPoviderEvent>((event, state) => FetchFavProviderInitial());
    on<FetchFavProviderDetailsClickedEvent>((event, emit) async {
      // List<>bookModel
      try {
        emit(FetchFavProviderLoading());
        final bookModel = await apiRepository.fetchFavoriteProviders(
          token: event.token,
        );
        // print("FetchFavoriteProviders loaded");
        // print(bookModel);
        if (bookModel[0].by_user == null) {
          emit(const FetchFavProviderEmpty());
          return;
        }
        // print(bookModel);
        if (bookModel[0].message != null) {
          emit(FetchFavProviderError(message: bookModel[0].message));
          return;
        }
        emit(FetchFavProviderLoaded(
          bookModel: bookModel,
        ));
      } catch (exe) {
        emit(FetchFavProviderError(message: "Error while fetching data"));
        return;
      }
    });
  }
  @override
  void onChange(Change<FetchFavProviderState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }

  @override
  FetchFavProviderState fromJson(Map<String, dynamic> json) {
    try {
      return FetchFavProviderLoaded.fromMap(json);
    } catch (e) {
      return FetchFavProviderInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(FetchFavProviderState state) {
    if (state is FetchFavProviderLoaded) {
      return state.toMap();
    }
    return {};
  }
}
