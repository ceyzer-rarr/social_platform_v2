import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../constants/api_endpoints.dart';

class ApiClient {
  ApiClient._internal();

  static final ApiClient instance = ApiClient._internal();

  final http.Client _client = http.Client();

  Future<Map<String, dynamic>> post(
      String path, {
        Map<String, dynamic>? body,
      }) async {
    final uri = Uri.parse(ApiEndpoints.baseUrl + path);

    try {
      final response = await _client
          .post(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode(body ?? {}),
      )
          .timeout(const Duration(seconds: 15));

      final decoded =
      response.body.isNotEmpty ? jsonDecode(response.body) : null;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return decoded is Map<String, dynamic> ? decoded : {};
      } else {
        throw ApiException(
          statusCode: response.statusCode,
          message: decoded is Map<String, dynamic>
              ? (decoded['message']?.toString() ?? 'Unknown error')
              : 'Something went wrong',
          errors: decoded is Map<String, dynamic> ? decoded['errors'] : null,
        );
      }
    } on SocketException {
      throw ApiException(message: 'Cannot connect to the server.');
    } on HttpException {
      throw ApiException(message: 'HTTP error occurred.');
    } on FormatException {
      throw ApiException(message: 'Invalid response format.');
    }
  }
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic errors;

  ApiException({required this.message, this.statusCode, this.errors});

  @override
  String toString() => 'ApiException($statusCode): $message';
}
