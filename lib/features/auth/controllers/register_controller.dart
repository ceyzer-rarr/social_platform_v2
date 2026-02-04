import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/snackbar_helper.dart';
import '../../../core/utils/validators.dart';
import '../services/auth_service.dart';
import '../../../routes/app_routes.dart';

class RegisterController extends GetxController {
  final AuthService _authService = AuthService();

  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordObscured = true.obs;
  final isConfirmPasswordObscured = true.obs;

  @override
  void onClose() {
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future<void> submit() async {
    // 1. validate form
    if (!(formKey.currentState?.validate() ?? false)) return;

    // 2. confirm password match
    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      SnackbarHelper.showError('Password and confirmation do not match');
      return;
    }

    isLoading.value = true;

    final email = emailController.text.trim();

    try {
      // 3. call API
      await _authService.register(
        username: usernameController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: email,
        password: passwordController.text,
        passwordConfirmation: confirmPasswordController.text,
      );

      // 4. show message
      SnackbarHelper.showSuccess(
          'Registered successfully. OTP sent to your email.');

      // 5. navigate to OTP screen and pass email
      Get.toNamed(
        AppRoutes.otp,
        arguments: email,
      );
    } catch (e) {
      SnackbarHelper.showError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // (optional) you can also add small helpers like:
  String? validateEmail(String? v) => Validators.email(v);
}
