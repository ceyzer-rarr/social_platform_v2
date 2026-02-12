class ProfileModel {
  final String username;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? picture;
  final String? cover;
  final String? bio;
  final String? note;
  final String? birthOfDate;
  final int? age;
  final String? nationality;
  final String? contactUrl;
  final String? address;
  final String? followersCount;
  final String? followingsCount;
  final String? postsCount;

  ProfileModel({
    required this.username,
    required this.email,
    this.firstName,
    this.lastName,
    this.picture,
    this.cover,
    this.bio,
    this.note,
    this.birthOfDate,
    this.age,
    this.nationality,
    this.contactUrl,
    this.address,
    this.followersCount,
    this.followingsCount,
    this.postsCount
  });

  String get fullName {
    if ((firstName ?? '').isEmpty && (lastName ?? '').isEmpty) {
      return username;
    }
    return '${firstName ?? ''} ${lastName ?? ''}'.trim();
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      username: json['username']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      firstName: json['first_name']?.toString(),
      lastName: json['last_name']?.toString(),
      picture: json['picture']?.toString(),
      cover: json['cover']?.toString(),
      bio: json['bio']?.toString(),
      note: json['note']?.toString(),
      birthOfDate: json['birth_of_date']?.toString(),
      age: json['age'] is int
          ? json['age'] as int?
          : int.tryParse(json['age']?.toString() ?? ''),
      nationality: json['nationality']?.toString(),
      contactUrl: json['contact_url']?.toString(),
      address: json['address']?.toString(),
      followersCount: json['followers_count']?.toString(),
      followingsCount: json['following_count']?.toString(),
      postsCount: json['posts_count']?.toString(),
    );
  }
}
