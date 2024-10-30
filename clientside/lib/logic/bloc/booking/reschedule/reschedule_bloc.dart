// ignore_for_file: avoid_print

import 'package:bookme/data/repository/fetch_booking_repo.dart';
import 'package:bookme/logic/bloc_export.dart';

class RescheduleBloc extends HydratedBloc<RescheduleEvent, RescheduleState> {
  RescheduleBloc({required BookingRepository apiRepository})
      : super(RescheduleInitial()) {
    on<RescheduleClickedEvent>((event, emit) async {
      emit(RescheduleLoading());
      try {
        final updateModel = await apiRepository.rescheduleBooking(
            token: event.token,
            expectedHours: event.expectedHours,
            bookId: event.bookId,
            startDateTime: event.start_date_time);

        print(updateModel);
        print("on bloc model");

        if (updateModel[0].message != null || updateModel[0].error != null) {
          emit(RescheduleError(message: updateModel[0].message));
          return;
        }
        emit(RescheduleLoaded(
          updateModel: updateModel,
        ));
      } catch (err) {
        emit(const RescheduleError(
          message: "Internal server error",
        ));
        print("error on bloc $err");
      }
    });
  }
  @override
  void onChange(Change<RescheduleState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }

  @override
  RescheduleState fromJson(Map<String, dynamic> json) {
    try {
      return RescheduleLoaded.fromMap(json);
    } catch (e) {
      return RescheduleInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(RescheduleState state) {
    if (state is RescheduleLoaded) {
      return state.toMap();
    }
    return {};
  }
}
