import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/snackbar_helper.dart';
import '../services/auth_service.dart';
import '../../../routes/app_routes.dart';

class OtpController extends GetxController {
  final AuthService _authService = AuthService();

  final otpController = TextEditingController();
  final isVerifying = false.obs;
  final isResending = false.obs;

  late final String email;

  @override
  void onInit() {
    super.onInit();
    // email is passed as Get.toNamed(AppRoutes.otp, arguments: email)
    email = Get.arguments as String;
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }

  Future<void> verify() async {
    final otp = otpController.text.trim();
    if (otp.isEmpty) {
      SnackbarHelper.showError('Please enter OTP code');
      return;
    }

    isVerifying.value = true;

    try {
      await _authService.verifyOtp(email: email, otpCode: otp);
      SnackbarHelper.showSuccess('Account verified successfully');

      // After verify, go back to Login
      Get.until((route) => route.settings.name == AppRoutes.login);
    } catch (e) {
      SnackbarHelper.showError('Invalid or expired OTP');
    } finally {
      isVerifying.value = false;
    }
  }

  Future<void> resend() async {
    isResending.value = true;

    try {
      await _authService.resendOtp(email: email);
      SnackbarHelper.showSuccess('OTP resent to $email');
    } catch (e) {
      SnackbarHelper.showError('Unable to resend OTP: $e');
    } finally {
      isResending.value = false;
    }
  }
}
