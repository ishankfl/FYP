import 'package:bloc/bloc.dart';
import 'package:bookme/data/model/time_validation_model.dart';
import 'package:bookme/data/repository/time_validation_repo.dart';
import 'package:bookme/logic/bloc/time_validation/time_validation_event.dart';
import 'package:bookme/logic/bloc/time_validation/time_validation_state.dart';

class TimeValidationBloc
    extends Bloc<TimeValidationEvent, TimeValidationState> {
  TimeValidationBloc() : super(const TimeValidationState()) {
    on<TimeValidationHit>((event, emit) async {
      try {
        emit(TimeValidationLoadingState());

        List<TimeValidationModel> data =
            await TimeValidationRepository().chechProviderAvailability(
          expectedHours: event.expectedHours,
          date_time: event.date_time,
          providerId: event.providerId,
          token: event.token.toString(),
        );
        print("on bloc");
        print(data);

        if (data.isNotEmpty && data[0].error != null) {
          emit(TimeValidationErrorState(message: data[0].error!));
        } else {
          print("Loaded state");
          emit(TimeValidationLoadedState(model: data[0]));
        }
      } catch (e, stackTrace) {
        print('Error in TimeValidationBloc: $e');
        print('Stack Trace: $stackTrace');
        emit(const TimeValidationErrorState(message: 'An error occurred.'));
      }
    });
  }
}
