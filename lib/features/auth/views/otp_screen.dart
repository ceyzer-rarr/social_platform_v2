import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/primary_button.dart';
import '../controllers/otp_controller.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.black,),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // IconButton(
                  //   onPressed: () => Get.back(),
                  //   icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                  //   padding: EdgeInsets.zero,
                  //   constraints: const BoxConstraints(),
                  // ),
                  const SizedBox(height: 16),

                  Center(
                    child: Column(
                      children: const [
                        Text(
                          'cignifi',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                            letterSpacing: 1.5,
                          ),
                        ),
                        SizedBox(height: 4),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  const Text('Verify your Account', style: AppTextStyles.title),
                  const SizedBox(height: 8),
                  Text(
                    'We have sent a 6-digit code to\n${controller.email}',
                    style: AppTextStyles.subtitle,
                  ),

                  const SizedBox(height: 24),

                  TextField(
                    controller: controller.otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: InputDecoration(
                      counterText: '',
                      labelText: 'OTP Code',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                        const BorderSide(color: AppColors.inputBorder),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                        const BorderSide(color: AppColors.inputBorder),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: AppColors.primary, width: 1.2),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Obx(
                        () => PrimaryButton(
                      label: 'Verify',
                      isLoading: controller.isVerifying.value,
                      onPressed: controller.verify,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Center(
                    child: Obx(
                          () => TextButton(
                        onPressed:
                        controller.isResending.value ? null : controller.resend,
                        child: controller.isResending.value
                            ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                            : const Text(
                          'Resend OTP',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
