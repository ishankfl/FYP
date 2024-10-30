import 'package:bookme/data/api/notification_api.dart';
import 'package:bookme/data/model/notification_model.dart';
import 'package:bookme/data/model/service_provider_model.dart';

import '../api/fetch_providers_api.dart';

class NotificationRepository {
  final fetchProvider = NotificationApi();
  Future<List<NotificationModel>> fetchNotifcation({required String token}) {
    return fetchProvider.fetchNotification(token: token);
  }
}
