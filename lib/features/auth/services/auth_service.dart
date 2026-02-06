import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_client.dart' show ApiException;

/// Handles all auth-related HTTP calls.
class AuthService {
  final ApiClient _client = ApiClient.instance;

  // ---------- REGISTER ----------

  Future<void> register({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    final body = {
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };

    await _client.post(ApiEndpoints.register, body: body);
  }

  // ---------- LOGIN (EMAIL/PASSWORD) ----------

  LoginResult login({
    required String email,
    required String password,
  }) {
    return LoginResult._(email: email, password: password);
  }

  // ---------- LOGOUT ----------

  Future<void> logout() async {
    await _client.post(ApiEndpoints.logout);
    _client.setAuthToken(null);
  }

  // ---------- DELETE ACCOUNT ----------

  Future<void> deleteAccount() async {
    await _client.delete('/api/delete-account');
    _client.setAuthToken(null);
  }

  // ---------- GOOGLE LOGIN ----------

  Future<Map<String, dynamic>> loginWithGoogleToken(String idToken) async {
    final res = await _client.post(
      '/api/auth/google/token',
      body: {
        'id_token': idToken, // ✅ important
      },
    );
    return res;
  }


  // ---------- GITHUB LOGIN ----------

  Future<Map<String, dynamic>> loginWithGithubToken(String code) async {
    final res = await _client.post(
      '/api/auth/github/token',
      body: {
        'code': code, // ✅ important
      },
    );
    return res;
  }



}


/// Internal class used by AuthService.login()
class LoginResult {
  final String email;
  final String password;

  LoginResult._({required this.email, required this.password});

  Future<LoginResponse> execute() async {
    final client = ApiClient.instance;

    try {
      final body = {
        'email': email,
        'password': password,
      };

      final res = await client.post(ApiEndpoints.login, body: body);

      final data = res['data'] as Map<String, dynamic>? ?? {};
      return LoginResponse(
        status: LoginStatus.success,
        message: 'Login successful',
        token: data['token']?.toString(),
        userId: data['id'] as int?,
        firstName: data['first_name']?.toString(),
        lastName: data['last_name']?.toString(),
      );
    } on ApiException catch (e) {
      final msg = e.message;

      if (e.statusCode == 403 && msg.contains('OTP sent')) {
        return LoginResponse(
          status: LoginStatus.otpRequired,
          message: msg,
        );
      }

      return LoginResponse(
        status: LoginStatus.error,
        message: msg,
      );
    }
  }
}

enum LoginStatus { success, otpRequired, error }

class LoginResponse {
  final LoginStatus status;
  final String message;
  final String? token;
  final int? userId;
  final String? firstName;
  final String? lastName;

  LoginResponse({
    required this.status,
    required this.message,
    this.token,
    this.userId,
    this.firstName,
    this.lastName,
  });
}

// ---------- OTP METHODS ----------

extension OtpMethods on AuthService {
  Future<void> verifyOtp({
    required String email,
    required String otpCode,
  }) async {
    final body = {
      'email': email,
      'otp_code': otpCode,
    };
    await _client.post(ApiEndpoints.verifyOtp, body: body);
  }

  Future<void> resendOtp({
    required String email,
  }) async {
    final body = {
      'email': email,
    };
    await _client.post(ApiEndpoints.resendOtp, body: body);
  }
}
