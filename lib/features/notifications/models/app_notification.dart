// lib/features/notifications/models/app_notification.dart
class AppNotification {
  final int id;
  final String type; // "like" or "follow"
  final NotificationActor actor;
  final NotificationPost? post;
  final bool isFollowingActor;
  final bool isRead;
  final String time;       // "55 seconds ago"
  final DateTime createdAt;

  AppNotification({
    required this.id,
    required this.type,
    required this.actor,
    required this.post,
    required this.isFollowingActor,
    required this.isRead,
    required this.time,
    required this.createdAt,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'] as int,
      type: json['type'] as String,
      actor: NotificationActor.fromJson(json['actor'] as Map<String, dynamic>),
      post: json['post'] != null
          ? NotificationPost.fromJson(json['post'] as Map<String, dynamic>)
          : null,
      isFollowingActor: json['is_following_actor'] as bool? ?? false,
      isRead: json['is_read'] as bool? ?? false,
      time: json['time'] as String? ?? '',
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  /// Short IG-style time: "55s", "2m", "1d", etc.
  String get shortTime {
    final parts = time.split(' ');
    if (parts.length >= 3) {
      final value = parts[0];
      final unit = parts[1].toLowerCase();
      switch (unit) {
        case 'second':
        case 'seconds':
          return '${value}s';
        case 'minute':
        case 'minutes':
          return '${value}m';
        case 'hour':
        case 'hours':
          return '${value}h';
        case 'day':
        case 'days':
          return '${value}d';
        case 'week':
        case 'weeks':
          return '${value}w';
      }
    }
    return time;
  }

  bool get isLike => type == 'like';
  bool get isFollow => type == 'follow';
}

class NotificationActor {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String picture;

  NotificationActor({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.picture,
  });

  factory NotificationActor.fromJson(Map<String, dynamic> json) {
    return NotificationActor(
      id: json['id'] as int,
      username: json['username'] as String? ?? '',
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      picture: json['picture'] as String? ?? '',
    );
  }
}

class NotificationPost {
  final int id;
  final String picture;

  NotificationPost({
    required this.id,
    required this.picture,
  });

  factory NotificationPost.fromJson(Map<String, dynamic> json) {
    return NotificationPost(
      id: json['id'] as int,
      picture: json['picture'] as String? ?? '',
    );
  }
}