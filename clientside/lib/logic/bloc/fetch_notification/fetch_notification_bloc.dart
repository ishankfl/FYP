import 'package:bookme/data/repository/notification_repo.dart';
import 'package:bookme/logic/bloc/fetch_notification/fetch_notification_state.dart';
import 'package:bookme/logic/bloc_export.dart';

class FetchNotificationBloc
    extends Bloc<FetchNotificationEvent, FetchNotificationState> {
  FetchNotificationBloc({required NotificationRepository apiRepository})
      : super(FetchNotificationInitial()) {
    on<FetchNotificationDetailsClickedEvent>((event, emit) async {
      emit(FetchNotificationLoading());
      print(event.token.toString());
      final model = await apiRepository.fetchNotifcation(
        token: event.token,
      );
      if (model.isEmpty) {
        return emit(FetchNotificationEmpty());
      }

      if (model[0].error != null) {
        return emit(FetchNotificationError(message: model[0].error));
      }

      if (model.isEmpty) {
        return emit(FetchNotificationEmpty());
      }
      return emit(FetchNotificationLoaded(
        model: model,
      ));
    });
  }
  @override
  void onChange(Change<FetchNotificationState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }
}
