import 'package:bookme/data/model/service_provider_model.dart';

import '../api/fetch_providers_api.dart';

class FetchProvidersRepository {
  final fetchProvider = FetchProviderApiProvider();
  Future<List<ServiceProviderModel>> fetchProvidersDetails(
      {required String token, required int id}) {
    return fetchProvider.fetchProviders(id: id, token: token);
  }

  Future<List<ServiceProviderModel>> fetchEmergencyProvidersDetails(
      {required String token, required String service}) {
    return fetchProvider.fetchEmergencyProviders(service: service, token: token);
  }
}
