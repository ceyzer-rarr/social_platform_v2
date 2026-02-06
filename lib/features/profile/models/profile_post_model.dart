class ProfilePostModel {
  final int id;
  final String picture;

  ProfilePostModel({
    required this.id,
    required this.picture,
  });

  factory ProfilePostModel.fromJson(Map<String, dynamic> json) {
    return ProfilePostModel(
      id: json['id'],
      picture: json['picture'],
    );
  }
}
