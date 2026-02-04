import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/network/api_client.dart';
import '../../../core/utils/snackbar_helper.dart';
import '../../../core/utils/validators.dart';
import '../services/auth_service.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final AuthService _authService = AuthService();

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordObscured = true.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> submit() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    isLoading.value = true;
    final email = emailController.text.trim();
    final password = passwordController.text;

    try {
      final result =
      await _authService.login(email: email, password: password).execute();

      switch (result.status) {
        case LoginStatus.success:
          SnackbarHelper.showSuccess('Login successful');

          // store token in ApiClient so profile/me + others are authenticated
          if (result.token != null) {
            ApiClient.instance.setAuthToken(result.token!);
          }

          // Later: save token in secure storage for auto-login

          // Go to main shell (home + profile bottom nav)
          Get.offAllNamed(AppRoutes.main);
          break;

        case LoginStatus.otpRequired:
          SnackbarHelper.showError(result.message);

          // Go to OTP screen and pass email.
          Get.toNamed(
            AppRoutes.otp,
            arguments: email,
          );
          break;

        case LoginStatus.error:
          SnackbarHelper.showError(result.message);
          break;
      }
    } catch (e) {
      SnackbarHelper.showError('Unexpected error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  String? validateEmail(String? v) => Validators.email(v);

  String? validatePassword(String? v) =>
      Validators.minLength(v, 6, fieldName: 'Password');
}
