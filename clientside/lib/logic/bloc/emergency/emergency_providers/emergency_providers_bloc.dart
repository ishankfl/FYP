import 'package:bookme/data/model/service_provider_model.dart';
import 'package:bookme/data/repository/fetch_providers_repo.dart';
import 'package:bookme/logic/bloc/emergency/emergency_providers/emergency_providers_event.dart';
import 'package:bookme/logic/bloc/emergency/emergency_providers/emergency_providers_state.dart';
import 'package:bookme/logic/bloc_export.dart';

class FetchEmergencyProviderBloc
    extends Bloc<FetchEmergencyProviderEvent, FetchEmergencyProviderState> {
  FetchEmergencyProviderBloc() : super(const FetchEmergencyProviderState()) {
    on<FetchEmergencyProviderHit>((event, emit) async {
      try {
        print("on bloc");
        emit(FetchEmergencyProviderLoadingState());

        List<ServiceProviderModel> user = await FetchProvidersRepository()
            .fetchEmergencyProvidersDetails(
                token: event.newToken, service: event.serviceName);

        if (user.isEmpty) {
          emit(const FetchEmergencyProviderEmptyState(message: "Empty"));
          return;
        }

        if (user[0].error != null) {
          print(user[0].error);
          emit(FetchEmergencyProviderErrorState(
              message: user[0].error.toString()));
          return;
        }

        emit(FetchEmergencyProviderLoadedState(providerModel: user));
        // }
      } catch (e, stackTrace) {
        emit(const FetchEmergencyProviderErrorState(
            message: 'An error occurred.'));
      }
    });
  }
}
