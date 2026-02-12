// lib/core/features/home/models/home_feed_model.dart
class HomeFeedResponse {
  final List<HomePost> data;

  HomeFeedResponse({required this.data});

  factory HomeFeedResponse.fromJson(Map<String, dynamic> json) {
    final list = json['data'] as List<dynamic>? ?? [];
    return HomeFeedResponse(
      data: list.map((e) => HomePost.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}

// lib/features/home/models/home_feed_model.dart

class HomePost {
  final int id;
  final FeedUser user;
  final String caption;
  final String picture;
  final String time;
  final int likesCount;
  final int commentsCount;
  final bool isLiked;

  HomePost({
    required this.id,
    required this.user,
    required this.caption,
    required this.picture,
    required this.time,
    required this.likesCount,
    required this.commentsCount,
    required this.isLiked,
  });

  factory HomePost.fromJson(Map<String, dynamic> json) {
    return HomePost(
      id: json['id'] ?? 0,
      user: FeedUser.fromJson(json['user'] ?? {}),
      caption: json['caption'] ?? '',
      picture: json['picture'] ?? '',
      time: json['time'] ?? '',
      likesCount: json['likes_count'] ?? 0,
      commentsCount: json['comments_count'] ?? 0,
      isLiked: json['is_liked'] == true || json['is_liked'] == 1,
    );
  }

  HomePost copyWith({
    int? likesCount,
    bool? isLiked,
  }) {
    return HomePost(
      id: id,
      user: user,
      caption: caption,
      picture: picture,
      time: time,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}

class FeedUser {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String picture;

  FeedUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.picture,
  });

  factory FeedUser.fromJson(Map<String, dynamic> json) {
    return FeedUser(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      username: json['username'] ?? '',
      picture: json['picture'] ?? '',
    );
  }
}

