import 'package:bookme/data/api/services_api.dart';
import 'package:bookme/data/model/services_model.dart';

class ServicesRepository {
  ServicesApiProvider apiProvider = ServicesApiProvider();
  Future<List<ServicesModel>> getServices() async {
    return await apiProvider.fetchServices();
  }
}
