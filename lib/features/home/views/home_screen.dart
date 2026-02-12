// lib/features/home/views/home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../models/home_feed_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject controller when HomeScreen is built
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          'Home',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black),
            ),
          );
        }

        if (controller.posts.isEmpty) {
          return const Center(
            child: Text(
              'No posts yet',
              style: TextStyle(color: Colors.black),
            ),
          );
        }

        // Pull to refresh list of posts
        return RefreshIndicator(
          onRefresh: controller.refreshFeed,
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: controller.posts.length,
            itemBuilder: (context, index) {
              final post = controller.posts[index];
              return _PostCard(
                post: post,
                onToggleLike: () => controller.toggleLike(post),
              );
            },
          ),
        );
      }),
    );
  }
}

class _PostCard extends StatelessWidget {
  final HomePost post;
  final VoidCallback onToggleLike;

  const _PostCard({
    required this.post,
    required this.onToggleLike,
  });

  @override
  Widget build(BuildContext context) {
    final liked = post.isLiked;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ===== HEADER =====
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: post.user.picture.isNotEmpty
                    ? NetworkImage(post.user.picture)
                    : null,
                child: post.user.picture.isEmpty
                    ? Text(
                  post.user.username.isNotEmpty
                      ? post.user.username[0].toUpperCase()
                      : '?',
                )
                    : null,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.user.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      post.time, // e.g. "1 day ago"
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_vert, color: Colors.black),
            ],
          ),
        ),

        // ===== IMAGE =====
        Container(
          color: Colors.black,
          child: AspectRatio(
            aspectRatio: 4 / 5, // similar to Instagram
            child: post.picture.isNotEmpty
                ? Image.network(
              post.picture,
              fit: BoxFit.cover,
            )
                : const Center(
              child: Icon(
                Icons.image_not_supported_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ),

        // ===== ACTIONS (like/comment/share/save) =====
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Row(
            children: [
              IconButton(
                onPressed: onToggleLike,
                icon: Icon(
                  liked ? Icons.favorite : Icons.favorite_border,
                  color: liked ? Colors.redAccent : Colors.black,
                ),
              ),
              Text(
                '${post.likesCount}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              IconButton(
                onPressed: () {
                  // TODO: comments screen later
                },
                icon: const Icon(Icons.mode_comment_outlined),
              ),
              IconButton(
                onPressed: () {
                  // TODO: share logic later
                },
                icon: const Icon(Icons.send_outlined),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  // TODO: save logic later
                },
                icon: const Icon(Icons.bookmark_border),
              ),
            ],
          ),
        ),

        // ===== META (likes, caption, comments, time) =====
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- username + caption in one line ---
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    height: 1.4,
                  ),
                  children: [
                    TextSpan(
                      text: post.user.username,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const TextSpan(text: '  '),
                    TextSpan(text: post.caption),
                  ],
                ),
              ),

              // --- "View all X comments" (optional) ---
              if (post.commentsCount > 0) ...[
                const SizedBox(height: 4),
                Text(
                  'View all ${post.commentsCount} comments',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
              const SizedBox(height: 4),
            ],
          ),
        ),
        const SizedBox(height: 3),
      ],
    );
  }
}