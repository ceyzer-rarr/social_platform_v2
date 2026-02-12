import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/snackbar_helper.dart';
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

  /// Field errors
  final usernameError = RxnString();
  final emailError = RxnString();
  final passwordError = RxnString();
  final confirmPasswordError = RxnString();

  void clearErrors() {
    usernameError.value = null;
    emailError.value = null;
    passwordError.value = null;
    confirmPasswordError.value = null;
  }

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
    clearErrors();

    if (!(formKey.currentState?.validate() ?? false)) return;

    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      confirmPasswordError.value = 'Passwords do not match';
      return;
    }

    isLoading.value = true;

    try {
      await _authService.register(
        username: usernameController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        passwordConfirmation: confirmPasswordController.text,
      );

      SnackbarHelper.showSuccess(
        'Registered successfully. OTP sent to your email.',
      );

      Get.toNamed(
        AppRoutes.otp,
        arguments: emailController.text.trim(),
      );
    } catch (e) {
      _handleRegisterError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void _handleRegisterError(String message) {
    final msg = message.toLowerCase();

    if (msg.contains('username')) {
      usernameError.value = 'Username already taken';
      return;
    }

    if (msg.contains('email')) {
      emailError.value = 'Email already registered';
      return;
    }

    if (msg.contains('password')) {
      passwordError.value = 'Password is too weak';
      return;
    }

    emailError.value = 'Registration failed. Try again.';
  }
}
