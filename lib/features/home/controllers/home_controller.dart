// lib/features/home/controllers/home_controller.dart
import 'package:get/get.dart';

import '../models/home_feed_model.dart';
import '../services/home_service.dart';

class HomeController extends GetxController {
  final HomeService _service = HomeService();

  final posts = <HomePost>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHomeFeed();
  }

  Future<void> fetchHomeFeed() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final data = await _service.getHomeFeed();
      posts.assignAll(data);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshFeed() async {
    await fetchHomeFeed();
  }

  Future<void> toggleLike(HomePost post) async {
    final index = posts.indexWhere((p) => p.id == post.id);
    if (index == -1) return;

    final current = posts[index];

    // optimistic update
    final nextLiked = !current.isLiked;
    final nextLikesCount = nextLiked
        ? current.likesCount + 1
        : (current.likesCount > 0 ? current.likesCount - 1 : 0);

    posts[index] = current.copyWith(
      isLiked: nextLiked,
      likesCount: nextLikesCount,
    );

    try {
      final res = await _service.toggleLike(current.id);

      // OPTIONAL: if API returns authoritative values, sync them:
      // e.g. { data: { is_liked: true, likes_count: 10 } }
      final data = (res['data'] is Map<String, dynamic>) ? res['data'] as Map<String, dynamic> : null;
      if (data != null) {
        final serverLiked = data['is_liked'] == true || data['is_liked'] == 1;
        final serverLikes = data['likes_count'];
        posts[index] = posts[index].copyWith(
          isLiked: serverLiked,
          likesCount: serverLikes is int ? serverLikes : int.tryParse(serverLikes?.toString() ?? '') ?? posts[index].likesCount,
        );
      }
    } catch (e) {
      // revert on error
      posts[index] = current;
    }
  }
}
