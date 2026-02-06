import 'package:get/get.dart';

import '../../../core/network/api_client.dart';
import '../../../core/utils/snackbar_helper.dart';
import '../../auth/services/auth_service.dart';
import '../models/profile_model.dart';
import '../services/profile_service.dart';
import '../../../routes/app_routes.dart';
import '../models/profile_post_model.dart';

class ProfileController extends GetxController {
  final ProfileService _profileService = ProfileService();
  final AuthService _authService = AuthService();

  final Rxn<ProfileModel> profile = Rxn<ProfileModel>();
  final isLoading = false.obs;

  final RxList<ProfilePostModel> posts = <ProfilePostModel>[].obs;
  final isPostsLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
    fetchMyPosts();
  }

  Future<void> fetchProfile() async {
    isLoading.value = true;
    try {
      final me = await _profileService.getMe();
      profile.value = me;
    } catch (e) {
      SnackbarHelper.showError('Failed to load profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
    } catch (_) {
      // ignore; we'll still clear token + navigate
    } finally {
      ApiClient.instance.setAuthToken(null);
      Get.offAllNamed(AppRoutes.login);
    }
  }

  Future<void> fetchMyPosts() async {
    isPostsLoading.value = true;
    try {
      final result = await _profileService.getMyPhotos();
      posts.assignAll(result);
    } catch (e) {
      SnackbarHelper.showError('Failed to load posts');
    } finally {
      isPostsLoading.value = false;
    }
  }
}
