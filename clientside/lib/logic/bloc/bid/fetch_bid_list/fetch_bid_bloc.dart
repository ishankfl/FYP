import 'package:bookme/data/repository/bid/bid_repo.dart';
import 'package:bookme/logic/bloc_export.dart';

class FetchBidListBloc
    extends HydratedBloc<FetchBidListEvent, FetchBidListState> {
  FetchBidListBloc({required BidRepo apiRepository})
      : super(FetchBidListInitial()) {
    on<FetchBidListClickedEvent>((event, emit) async {
      try {
        emit(FetchBidListLoading());
        final model = await apiRepository.fetchBidList(
          token: event.token,
        );

        if (model.isEmpty) {
          emit(const FetchBidListEmpty());
          return;
        }

        if (model[0].error != null) {
          emit(FetchBidListError(message: model[0].message!));
          return;
        }
        emit(FetchBidListLoaded(
          loginModel: model,
        ));
      } catch (exe) {
        print(exe);
        emit(const FetchBidListError(
            message: "Failed to fetch data, is your device online?"));
      }
    });
  }
  @override
  void onChange(Change<FetchBidListState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }

  @override
  FetchBidListState fromJson(Map<String, dynamic> json) {
    try {
      return FetchBidListLoaded.fromMap(json);
    } catch (e) {
      return FetchBidListInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(FetchBidListState state) {
    if (state is FetchBidListLoaded) {
      return state.toMap();
    }
    return {};
  }
}
