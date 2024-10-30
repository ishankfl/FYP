import 'package:bookme/logic/bloc/booking/booking_event.dart';
import 'package:bookme/logic/bloc/booking/booking_state.dart';
import 'package:get/get.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../data/repository/fetch_booking_repo.dart';

class BookingBloc extends HydratedBloc<BookingEvent, BookingState> {
  BookingBloc({required BookingRepository apiRepository})
      : super(BookingInitial()) {
    on<BookingClickedEvent>((event, emit) async {
      emit(BookingLoading());
      try {
        final bookModel = await apiRepository.bookService(
            provider: event.provider,
            service: event.service,
            start_date_time: event.start_date_time,
            token: event.token,
            expectedHours: event.expectedHours,
            latitude: event.latitude,
            location: event.location,
            longitude: event.longitude,
            address: event.address);

        print(bookModel);
        print("on bloc model");

        if (bookModel[0].message != null || bookModel[0].error != null) {
          emit(BookingError(message: bookModel[0].message));
          return;
        }
        emit(BookingLoaded(
          bookModel: bookModel,
        ));
      } catch (err) {
        emit(BookingError(
          message: "Internal server error",
        ));
        print("error on bloc ${err}");
      }
    });
  }
  @override
  void onChange(Change<BookingState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }

  @override
  BookingState fromJson(Map<String, dynamic> json) {
    try {
      return BookingLoaded.fromMap(json);
    } catch (e) {
      return BookingInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(BookingState state) {
    if (state is BookingLoaded) {
      return state.toMap();
    }
    return {};
  }
}
