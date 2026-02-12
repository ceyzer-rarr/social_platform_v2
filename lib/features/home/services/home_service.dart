// lib/core/features/home/services/home_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../models/home_feed_model.dart';

class HomeService {
  final ApiClient _api = ApiClient.instance;

  Future<List<HomePost>> getHomeFeed() async {
    final Map<String, dynamic> json =
    await _api.get(ApiEndpoints.homeFeed);

    final list = json['data'] as List<dynamic>? ?? [];

    return list
        .map((e) => HomePost.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Map<String, dynamic>> toggleLike(int postId) async {
    final res = await _api.post(ApiEndpoints.likeToggle(postId));
    // ApiClient.post returns GetX Response (body inside res.body)
    return (res.body is Map<String, dynamic>) ? (res.body as Map<String, dynamic>) : {};
  }
}