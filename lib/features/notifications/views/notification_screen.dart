// lib/features/notifications/views/notification_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/notification_controller.dart';
import '../models/app_notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController controller =
    Get.put(NotificationController());

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.start,
        ),
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

        if (controller.notifications.isEmpty) {
          return const Center(
            child: Text(
              'No notifications yet',
              style: TextStyle(color: Colors.black54),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshNotifications,
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 24),
            itemCount: controller.notifications.length,
            separatorBuilder: (_, __) => const Divider(
              height: 1,
              thickness: 0.3,
              color: Color(0xffe0e0e0),
            ),
            itemBuilder: (context, index) {
              final notif = controller.notifications[index];
              return _NotificationTile(notification: notif);
            },
          ),
        );
      }),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final AppNotification notification;

  const _NotificationTile({required this.notification});

  @override
  Widget build(BuildContext context) {
    final actor = notification.actor;

    String message;
    if (notification.isLike) {
      message = '${actor.username} liked your post.';
    } else if (notification.isFollow) {
      message = '${actor.username} started following you.';
    } else {
      // fallback if other types appear in future
      message = '${actor.username} did something.';
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 22,
            backgroundImage: actor.picture.isNotEmpty
                ? NetworkImage(actor.picture)
                : null,
            child: actor.picture.isEmpty
                ? Text(
              actor.username.isNotEmpty
                  ? actor.username[0].toUpperCase()
                  : '?',
              style: const TextStyle(color: Colors.white),
            )
                : null,
          ),
          const SizedBox(width: 12),

          // Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      height: 1.3,
                    ),
                    children: [
                      TextSpan(
                        text: actor.username,
                        style: TextStyle(
                          fontWeight: notification.isRead
                              ? FontWeight.w500
                              : FontWeight.w700,
                        ),
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: notification.isLike
                            ? 'liked your post.'
                            : notification.isFollow
                            ? 'started following you.'
                            : 'sent you a notification.',
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  notification.shortTime, // e.g. "55s", "2m"
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Right side: Follow button or post thumbnail
          if (notification.isFollow)
            _FollowButton(
              isFollowing: notification.isFollowingActor,
              onPressed: () {
                // TODO: follow/unfollow API
              },
            )
          else if (notification.isLike && notification.post != null)
            _PostThumbnail(imageUrl: notification.post!.picture),
        ],
      ),
    );
  }
}

class _FollowButton extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback onPressed;

  const _FollowButton({
    required this.isFollowing,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          side: BorderSide(
            color: isFollowing ? Colors.grey.shade400 : Colors.blue,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor:
          isFollowing ? Colors.white : Colors.blue, // IG-ish
        ),
        child: Text(
          isFollowing ? 'Following' : 'Follow',
          style: TextStyle(
            color: isFollowing ? Colors.black : Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _PostThumbnail extends StatelessWidget {
  final String imageUrl;

  const _PostThumbnail({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 44,
        height: 44,
        color: Colors.grey[200],
        child: imageUrl.isNotEmpty
            ? Image.network(
          imageUrl,
          fit: BoxFit.cover,
        )
            : const Icon(
          Icons.image_not_supported_outlined,
          size: 20,
          color: Colors.grey,
        ),
      ),
    );
  }
}