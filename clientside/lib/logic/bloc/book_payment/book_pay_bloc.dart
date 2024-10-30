import 'package:bookme/data/repository/payment_repo.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class BookPaymentBloc extends HydratedBloc<BookPaymentEvent, BookPaymentState> {
  BookPaymentBloc({required PaymentRepository apiRepository})
      : super(BookPaymentInitial()) {
    on<BookPaymentClickedEvent>((event, emit) async {
      try {
        emit(BookPaymentLoading());
        final bookPayment = await apiRepository.bookPayment(
            transactionId: event.transactionId,
            token: event.token,
            amount: event.amount,
            bookId: event.bookId,
            serviceType: event.serviceType);
        // print(login.error);
        // print('This is the error ${login.error}');
        // if (login.error == "") {
        //   print("error not found");
        //   print(login.access);
        //   // emit(BookPaymentState(message: login.error));
        //   return;
        // }
        // if (bookPayment.error != null) {
        //   emit(BookPaymentError(message: login.error));
        //   return;
        // }
        emit(BookPaymentLoaded(
          loginModel: bookPayment,
        ));
      } catch (Exception) {
        emit(const BookPaymentError(
            message: "Failed to fetch data, is your device online?"));
      }
    });
  }
  @override
  void onChange(Change<BookPaymentState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }

  @override
  BookPaymentState fromJson(Map<String, dynamic> json) {
    try {
      return BookPaymentLoaded.fromMap(json);
    } catch (e) {
      return BookPaymentInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(BookPaymentState state) {
    if (state is BookPaymentLoaded) {
      return state.toMap();
    }
    return {};
  }
}
