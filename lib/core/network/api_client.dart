import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../constants/api_endpoints.dart';

class ApiClient {
  ApiClient._internal();

  static final ApiClient instance = ApiClient._internal();

  final http.Client _client = http.Client();

  String? _authToken;

  void setAuthToken(String? token) {
    _authToken = token;
  }

  Map<String, String> _buildHeaders() {
    final headers = <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };
    if (_authToken != null && _authToken!.isNotEmpty) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $_authToken';
    }
    return headers;
  }

  // ---------------- JSON POST ----------------

  Future<Map<String, dynamic>> post(
      String path, {
        Map<String, dynamic>? body,
      }) async {
    final uri = Uri.parse(ApiEndpoints.baseUrl + path);

    try {
      final response = await _client
          .post(
        uri,
        headers: _buildHeaders(),
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

  // ---------------- JSON GET ----------------

  Future<Map<String, dynamic>> get(String path) async {
    final uri = Uri.parse(ApiEndpoints.baseUrl + path);

    try {
      final response = await _client
          .get(
        uri,
        headers: _buildHeaders(),
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

  // ---------------- MULTIPART POST (for picture + cover) ----------------

  Future<Map<String, dynamic>> postMultipart(
      String path, {
        Map<String, String>? fields,
        Map<String, File>? files,
      }) async {
    final uri = Uri.parse(ApiEndpoints.baseUrl + path);

    final request = http.MultipartRequest('POST', uri);

    // headers WITHOUT content-type; MultipartRequest sets it.
    final headers = _buildHeaders();
    headers.remove(HttpHeaders.contentTypeHeader);
    request.headers.addAll(headers);

    if (fields != null) {
      request.fields.addAll(fields);
    }

    if (files != null) {
      for (final entry in files.entries) {
        request.files.add(
          await http.MultipartFile.fromPath(
            entry.key,
            entry.value.path,
          ),
        );
      }
    }

    try {
      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);
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

  Future<Map<String, dynamic>> delete(String path) async {
    final uri = Uri.parse(ApiEndpoints.baseUrl + path);

    try {
      final response = await _client
          .delete(uri, headers: _buildHeaders())
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
        );
      }
    } catch (e) {
      rethrow;
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
