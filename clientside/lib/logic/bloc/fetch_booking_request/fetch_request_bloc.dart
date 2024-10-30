import 'package:bookme/logic/bloc_export.dart';
import '../../../data/repository/fetch_booking_repo.dart';

class FetchBookingBloc extends Bloc<FetchBookingEvent, FetchBookingState> {
  FetchBookingBloc({required BookingRepository apiRepository})
      : super(FetchBookingInitial()) {
    on<ClearBookingDetailsClickedEvent>(
        (event, state) => FetchBookingInitial());
    on<FetchBookingDetailsClickedEvent>((event, emit) async {
      emit(FetchBookingLoading());
      print(event.token.toString());
      final bookModel = await apiRepository.fetchBooking(
        token: event.token,
      );
      if (bookModel.isEmpty) {
        return emit(FetchBookingEmpty());
      }

      if (bookModel[0].message != null) {
        return emit(FetchBookingError(message: bookModel[0].message));
      }

      return emit(FetchBookingLoaded(
        bookModel: bookModel,
      ));
    });
  }
  @override
  void onChange(Change<FetchBookingState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }

  // @override
  // FetchBookingState fromJson(Map<String, dynamic> json) {
  //   try {
  //     return FetchBookingLoaded.fromMap(json);
  //   } catch (e) {
  //     return FetchBookingInitial();
  //   }

  // @override
  // Map<String, dynamic>? toJson(FetchBookingState state) {
  //   if (state is FetchBookingLoaded) {
  //     return state.toMap();
  //   }
  //   return {};
  // }
}
