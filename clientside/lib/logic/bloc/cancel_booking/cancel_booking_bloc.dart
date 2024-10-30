import 'package:bookme/logic/bloc/cancel_booking/cancel_booking_event.dart';
import 'package:bookme/logic/bloc/cancel_booking/cancel_booking_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../data/repository/fetch_booking_repo.dart';

class CancelBookingBloc extends Bloc<CancelBookingEvent, CancelBookingState> {
  CancelBookingBloc({required BookingRepository apiRepository})
      : super(CancelBookingInitial()) {
    on<CancelBookingDetailsClickedEvent>((event, emit) async {
      emit(CancelBookingLoading());
      final cancelBookModel = await apiRepository.cancelBook(
          token: event.token, bookId: event.bookId);
      // print("In thsdd");
      print(cancelBookModel);
      if (cancelBookModel[0].error != 0) {
        emit(CancelBookingError(message: cancelBookModel[0].message));
        return;
      }
      emit(CancelBookingSuccess(
        model: cancelBookModel,
      ));
    });
  }
  @override
  void onChange(Change<CancelBookingState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }

  @override
  CancelBookingState fromJson(Map<String, dynamic> json) {
    try {
      return CancelBookingSuccess.fromMap(json);
    } catch (e) {
      return CancelBookingInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(CancelBookingState state) {
    if (state is CancelBookingSuccess) {
      return state.toMap();
    }
    return {};
  }
}
