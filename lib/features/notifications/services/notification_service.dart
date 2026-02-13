import '../../../core/network/api_client.dart';
import '../../../core/constants/api_endpoints.dart';
import '../models/app_notification.dart';

class NotificationService {
  final ApiClient _api = ApiClient.instance;

  Future<List<AppNotification>> getNotifications() async {
    final Map<String, dynamic> json =
    await _api.get(ApiEndpoints.notifications); // /api/notifications

    final list = json['data'] as List<dynamic>? ?? [];

    return list
        .map((e) => AppNotification.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}