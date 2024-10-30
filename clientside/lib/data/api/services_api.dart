import 'package:bookme/data/api/api_export.dart';
import 'package:bookme/data/api/api_url_response.dart';
import 'package:bookme/data/model/services_model.dart';

class ServicesApiProvider {
  Future<List<ServicesModel>> fetchServices() async {
    try {
      String url = "services/api/fetchservices/";
      Response request = await urlResponse(url);

      if (request.statusCode == 200) {
        List<ServicesModel> services = List.from(jsonDecode(request.body))
            .map((e) => ServicesModel.fromMap(e))
            .toList();
        return services;
      } else {
        return [ServicesModel.withError("Server Error")];
      }
    } on TimeoutException {
      return [ServicesModel.withError("Please Check you wifi")];
    } catch (err) {
      return [ServicesModel.withError("Connection problem")];
    }
  }
}
