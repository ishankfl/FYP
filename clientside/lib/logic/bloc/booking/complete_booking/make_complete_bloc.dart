// ignore_for_file: avoid_print

import 'package:bookme/data/repository/fetch_booking_repo.dart';
import 'package:bookme/logic/bloc_export.dart';

class MakeCompleteBloc
    extends HydratedBloc<MakeCompleteEvent, MakeCompleteState> {
  MakeCompleteBloc({required BookingRepository apiRepository})
      : super(MakeCompleteInitial()) {
    on<MakeCompleteClickedEvent>((event, emit) async {
      emit(MakeCompleteLoading());
      try {
        final updateModel = await apiRepository.makeComplete(
          token: event.token,
          bookId: event.bookId,
        );

        print(updateModel);
        print("on bloc model");

        if (updateModel[0].message != null || updateModel[0].error != null) {
          emit(MakeCompleteError(message: updateModel[0].message));
          return;
        }
        emit(MakeCompleteLoaded(
          updateModel: updateModel,
        ));
      } catch (err) {
        emit(const MakeCompleteError(
          message: "Internal server error",
        ));
        print("error on bloc $err");
      }
    });
  }
  @override
  void onChange(Change<MakeCompleteState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }

  @override
  MakeCompleteState fromJson(Map<String, dynamic> json) {
    try {
      return MakeCompleteLoaded.fromMap(json);
    } catch (e) {
      return MakeCompleteInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(MakeCompleteState state) {
    if (state is MakeCompleteLoaded) {
      return state.toMap();
    }
    return {};
  }
}
