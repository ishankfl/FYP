import 'package:bookme/data/repository/bid/bid_repo.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AddBidBloc extends HydratedBloc<AddBidClickedEvent, AddBidState> {
  AddBidBloc({required BidRepo apiRepository}) : super(AddBidInitial()) {
    on<AddBidClickedEvent>((event, emit) async {
      emit(AddBidLoading());
      final model = await apiRepository.addBidRepo(
          service: event.service,
          textcontent: event.textcontent,
          image: event.image,
          lon: event.lon,
          lat: event.lat,
          location: event.location,
          amount: event.amount,
          token: event.token);

      if (model[0].message != null) {
        emit(AddBidError(message: model[0].message));
        return;
      }
      emit(AddBidSuccess(
        model: model,
      ));
    });
  }
  @override
  void onChange(Change<AddBidState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }

  @override
  AddBidState fromJson(Map<String, dynamic> json) {
    try {
      return AddBidSuccess.fromMap(json);
    } catch (e) {
      return AddBidInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(AddBidState state) {
    if (state is AddBidSuccess) {
      return state.toMap();
    }
    return {};
  }
}
