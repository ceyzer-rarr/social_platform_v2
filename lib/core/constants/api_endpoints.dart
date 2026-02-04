class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'http://10.0.2.2:8000'; // ← change if needed

  static const String register = '/api/auth/register';
  static const String login = '/api/auth/login';
  static const String verifyOtp = '/api/auth/verify-otp';
  static const String resendOtp = '/api/auth/resend-otp';
  static const String logout     = '/api/auth/logout';

  // Profile
  static const String profileMe = '/api/profile/me';
  static const String profileUpdate = '/api/profile/update';
}
