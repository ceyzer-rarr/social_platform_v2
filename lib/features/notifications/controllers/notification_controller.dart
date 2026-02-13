// lib/features/notifications/controllers/notification_controller.dart
import 'package:get/get.dart';
import '../models/app_notification.dart';
import '../services/notification_service.dart';

class NotificationController extends GetxController {
  final NotificationService _service = NotificationService();

  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxList<AppNotification> notifications = <AppNotification>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _service.getNotifications();
      notifications.assignAll(result);
    } catch (e) {
      errorMessage.value = 'Failed to load notifications.\n$e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshNotifications() async {
    await fetchNotifications();
  }
}