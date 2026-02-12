import 'package:get/get.dart';
import '../../post/views/new_post_screen.dart';
import '../../profile/controllers/profile_controller.dart';

class MainShellController extends GetxController {
  // 0 = Home, 1 = Search, 2 = Notifications, 3 = Profile
  final currentIndex = 0.obs;

  void changeTab(int index) {
    // Always request when user taps Profile tab
    if (index == 3) {
      if (Get.isRegistered<ProfileController>()) {
        Get.find<ProfileController>().fetchMyPosts();// <-- API call
        Get.find<ProfileController>().fetchProfile();
      }
    }

    currentIndex.value = index;
  }

  void openCreatePost() {
    Get.to(() => const NewPostScreen());
  }
}
