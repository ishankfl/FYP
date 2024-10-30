import 'package:bookme/data/api/time_validation_api.dart';
import 'package:bookme/data/model/time_validation_model.dart';

class TimeValidationRepository {
  TimeValidationApiProvider apiProvider = TimeValidationApiProvider();
  Future<List<TimeValidationModel>> chechProviderAvailability(
      {required String token,
      required int providerId,
      required String date_time,
      required String expectedHours}) async {
    return await apiProvider.chechProviderAvailability(
      expected_hours: expectedHours,
      date_time: date_time,
      token: token,
      providerId: providerId,
    );
  }
}
