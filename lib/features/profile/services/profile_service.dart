import 'dart:io';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../models/profile_model.dart';
import '../models/profile_post_model.dart';

class ProfileService {
  final ApiClient _client = ApiClient.instance;

  Future<ProfileModel> getMe() async {
    final res = await _client.get(ApiEndpoints.profileMe);
    final data = res['data'] as Map<String, dynamic>? ?? {};
    return ProfileModel.fromJson(data);
  }

  Future<ProfileModel> updateProfile({
    required String username,
    required String firstName,
    required String lastName,
    String? bio,
    String? note,
    String? birthOfDate,
    String? age,
    String? contactUrl,
    String? address,
    File? picture,
    File? cover,
  }) async {
    final fields = <String, String>{
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
    };

    if (bio != null) fields['bio'] = bio;
    if (note != null) fields['note'] = note;
    if (birthOfDate != null) fields['birth_of_date'] = birthOfDate;
    if (age != null) fields['age'] = age;
    if (contactUrl != null) fields['contact_url'] = contactUrl;
    if (address != null) fields['address'] = address;

    final files = <String, File>{};
    if (picture != null) files['picture'] = picture;
    if (cover != null) files['cover'] = cover;

    final res = await _client.postMultipart(
      ApiEndpoints.profileUpdate,
      fields: fields,
      files: files.isEmpty ? null : files,
    );

    final data = res['data'] as Map<String, dynamic>? ?? {};
    return ProfileModel.fromJson(data);
  }

  Future<List<ProfilePostModel>> getMyPhotos() async {
    final res = await _client.get(ApiEndpoints.profileMyPhotos);

    final List list = res['data'] ?? [];
    return list.map((e) => ProfilePostModel.fromJson(e)).toList();
  }
}
