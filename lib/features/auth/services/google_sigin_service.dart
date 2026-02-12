import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignService {
  GoogleSignService._();
  static final GoogleSignService instance = GoogleSignService._();

  final GoogleSignIn _gAuth = GoogleSignIn.instance;

  bool _initialized = false;

  // 👇 paste the same value as GOOGLE_CLIENT_ID in your backend .env
  static const String _serverClientId =
      '555702549792-2t03bj6nrn5iq9tdbnfgff64ecm0qoji.apps.googleusercontent.com';

  static const List<String> _basicScopes = <String>[
    'openid',
    'https://www.googleapis.com/auth/userinfo.email',
    'https://www.googleapis.com/auth/userinfo.profile',
  ];

  Future<void> _ensureInitialized() async {
    if (_initialized) return;

    await _gAuth.initialize(
      serverClientId: _serverClientId, // 🔥 REQUIRED on Android
      // clientId: '... (only if you need iOS/web specific)',
    );

    _initialized = true;
  }

  Future<String?> signInAndGetAccessToken() async {
    await _ensureInitialized();

    try {
      final GoogleSignInAccount googleUser =
      await _gAuth.authenticate(scopeHint: _basicScopes);

      final GoogleSignInClientAuthorization authorizedUser =
      await googleUser.authorizationClient.authorizeScopes(_basicScopes);

      return authorizedUser.accessToken;
    } on GoogleSignInException catch (e) {
      print('GoogleSignInException: code=${e.code}, message=${e.details}');
      return null;
    } catch (e) {
      print('Unexpected error in signInAndGetAccessToken: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _gAuth.disconnect();
    } catch (_) {}
  }
}
