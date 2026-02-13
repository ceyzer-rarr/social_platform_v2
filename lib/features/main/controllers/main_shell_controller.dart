import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../profile/controllers/profile_controller.dart';
import '../../profile/models/profile_model.dart';
import '../../post/views/new_post_screen.dart';

class MainShellController extends GetxController {
  // 0 = Home, 1 = Search, 2 = Notifications, 3 = Profile
  final currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;

    if (args is Map) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // switch tab
        final tabIndex = args['tabIndex'];
        if (tabIndex is int) {
          changeTab(tabIndex);
        }

        // apply updated profile instantly
        final updated = args['profile'];
        if (updated is ProfileModel && Get.isRegistered<ProfileController>()) {
          Get.find<ProfileController>().profile.value = updated;
        }
      });
    }
  }

  void changeTab(int index) {
    // Always request when user taps Profile tab
    if (index == 3) {
      if (Get.isRegistered<ProfileController>()) {
        Get.find<ProfileController>().fetchMyPosts();
        Get.find<ProfileController>().fetchProfile();
      }
    }

    currentIndex.value = index;
  }

  void openCreatePost() {
    Get.to(() => const NewPostScreen());
  }
}