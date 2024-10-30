import 'package:bookme/logic/bloc_export.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../data/repository/fetch_booking_repo.dart';

class AcceptBookingBloc extends Bloc<AcceptBookingEvent, AcceptBookingState> {
  AcceptBookingBloc({required BookingRepository apiRepository})
      : super(AcceptBookingInitial()) {
    on<AcceptBookingDetailsClickedEvent>((event, emit) async {
      emit(AcceptBookingLoading());
      final cancelBookModel = await apiRepository.acceptBook(
          token: event.token, bookId: event.bookId);
      // print("In thsdd");
      // print(cancelBookModel);
      if (cancelBookModel[0].error != 0) {
        emit(AcceptBookingError(message: cancelBookModel[0].message));
        return;
      }
      emit(AcceptBookingSuccess(
        model: cancelBookModel,
      ));
    });
  }
  @override
  void onChange(Change<AcceptBookingState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }

  AcceptBookingState fromJson(Map<String, dynamic> json) {
    try {
      return AcceptBookingSuccess.fromMap(json);
    } catch (e) {
      return AcceptBookingInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(AcceptBookingState state) {
    if (state is AcceptBookingSuccess) {
      return state.toMap();
    }
    return {};
  }
}
