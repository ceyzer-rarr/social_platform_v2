import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_platform_app/features/home/views/home_screen.dart';

import '../../../core/network/api_client.dart';
import '../../../core/utils/snackbar_helper.dart';
import '../../../core/utils/validators.dart';
import '../services/auth_service.dart';
import '../../../routes/app_routes.dart';
import '../services/google_sigin_service.dart';

class LoginController extends GetxController {
  final AuthService _authService = AuthService();

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordObscured = true.obs;

  final emailError = RxnString();
  final passwordError = RxnString();

  void clearErrors() {
    emailError.value = null;
    passwordError.value = null;
  }

  @override
  // void onClose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.onClose();
  // }
  Future<void> submit() async {
    clearErrors();

    if (!(formKey.currentState?.validate() ?? false)) return;

    isLoading.value = true;

    try {
      final result = await _authService
          .login(
            email: emailController.text.trim(),
            password: passwordController.text,
          )
          .execute();

      switch (result.status) {
        case LoginStatus.success:
          ApiClient.instance.setAuthToken(result.token!);
          Get.offAllNamed(AppRoutes.main);
          break;

        case LoginStatus.error:
          _handleLoginError(result.message);
          break;

        case LoginStatus.otpRequired:
          emailError.value = 'Please verify your account first';
          break;
      }
    } catch (e) {
      emailError.value = 'Something went wrong';
    } finally {
      isLoading.value = false;
    }
  }

  void _handleLoginError(String message) {
    final msg = message.toLowerCase();

    if (msg.contains('email')) {
      emailError.value = 'This email is not registered';
      return;
    }

    if (msg.contains('password')) {
      passwordError.value = 'Incorrect password';
      return;
    }

    // fallback
    emailError.value = 'Invalid email or password';
    passwordError.value = 'Invalid email or password';
  }

  String _mapLoginError(String message) {
    final msg = message.toLowerCase();

    if (msg.contains('email') && msg.contains('not')) {
      return 'This email is not registered';
    }

    if (msg.contains('password')) {
      return 'Incorrect password';
    }

    if (msg.contains('verify') || msg.contains('otp')) {
      return 'Please verify your account first';
    }

    if (msg.contains('blocked') || msg.contains('too many')) {
      return 'Too many attempts. Try again later';
    }

    return 'Invalid email or password';
  }

  Future<void> loginGoogle(String accessToken) async {
    try {
      final response = await _authService.loginWithGoogleToken(accessToken);
      final status = response.body['status'];

      if (status == 200) {
        Get.offAllNamed(AppRoutes.home);
      } else {
        SnackbarHelper.showError(response.body['message']);
      }
    } catch (e) {}
  }

  Future<void> signInWithGoogle() async {
    try {
      final accessToken = await GoogleSignService.instance
          .signInAndGetAccessToken();

      // if we rethrow in the service, we usually won't even reach here on error
      if (accessToken == null) {
        print('Google accessToken is null (user canceled?).');
        return;
      }

      await _authService.loginWithGoogleToken(accessToken);
    } catch (e) {
      print('signInWithGoogle error: $e');
    }
  }

  String? validateEmail(String? v) => Validators.email(v);

  String? validatePassword(String? v) =>
      Validators.minLength(v, 6, fieldName: 'Password');
}
