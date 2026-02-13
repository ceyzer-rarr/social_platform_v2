class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://social-platform.hushstack.me'; // ← change if needed

  static const String register = '/api/auth/register';
  static const String login = '/api/auth/login';
  static const String verifyOtp = '/api/auth/verify-otp';
  static const String resendOtp = '/api/auth/resend-otp';
  static const String logout     = '/api/auth/logout';

  // Profile
  static const String profileMe = '/api/profile/me';
  static const String profileUpdate = '/api/profile/update';
  static const String profileMyPhotos = '/api/profile/posts/photos';

  // Posts
  static const String createPost = '/api/posts';

  // Google
  static const String googleLogin = '/api/auth/google/token';

  static const String homeFeed = '/api/home-feed';
  static String likeToggle(int postId) => '/api/posts/$postId/like-toggle';
  static const String notifications = '/api/notifications';
}
