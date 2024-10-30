import 'package:bookme/data/repository/repo_export.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class FetchPaymentBloc
    extends HydratedBloc<FetchPaymentEvent, FetchPaymentState> {
  FetchPaymentBloc({required PaymentRepository apiRepository})
      : super(FetchPaymentInitial()) {
    on<FetchPaymentClickedEvent>((event, emit) async {
      // try {
      emit(FetchPaymentLoading());
      final fetchPayment = await apiRepository.fetchPaymentDetails(
        token: event.token,
      );

      if (fetchPayment[0].error != null || fetchPayment[0].error != "") {
        emit(FetchPaymentError(message: fetchPayment[0].error.toString()));
      }

      emit(FetchPaymentLoaded(
        model: fetchPayment,
      ));
      // } catch (exception) {
      //   print(exception);
      //   emit(const FetchPaymentError(
      //       message: "Failed to fetch data, is your device online?"));
      // }
    });
  }
  @override
  void onChange(Change<FetchPaymentState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }

  @override
  FetchPaymentState fromJson(Map<String, dynamic> json) {
    try {
      return FetchPaymentLoaded.fromMap(json);
    } catch (e) {
      return FetchPaymentInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(FetchPaymentState state) {
    if (state is FetchPaymentLoaded) {
      return state.toMap();
    }
    return {};
  }
}
