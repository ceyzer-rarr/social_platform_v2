import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/social_icon_button.dart';
import '../controllers/login_controller.dart';
import '../../../routes/app_routes.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: Colors.black,
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 430,
                minHeight: size.height * 0.9,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Welcome back', style: AppTextStyles.title),
                  const SizedBox(height: 4),
                  const Text(
                    'Log in to your account',
                    style: AppTextStyles.subtitle,
                  ),
                  const SizedBox(height: 24),

                  Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        AppTextField(
                          label: 'Email',
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: controller.validateEmail,
                        ),
                        const SizedBox(height: 16),

                        Obx(
                          () => TextFormField(
                            controller: controller.passwordController,
                            obscureText: controller.isPasswordObscured.value,
                            validator: controller.validatePassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: AppColors.inputBorder,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: AppColors.inputBorder,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: AppColors.primary,
                                  width: 1.2,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isPasswordObscured.value
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_rounded,
                                ),
                                onPressed: () {
                                  controller.isPasswordObscured.value =
                                      !controller.isPasswordObscured.value;
                                },
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // TODO: forgot password
                            },
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        Obx(
                          () => PrimaryButton(
                            label: 'Log in',
                            isLoading: controller.isLoading.value,
                            onPressed: controller.submit,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'or continue with',
                          style: AppTextStyles.subtitle,
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Column(
                    children: [
                      SocialIconButton(
                        icon: const FaIcon(
                          FontAwesomeIcons.google,
                          size: 20,
                          color: Color(0xFFDB4437),
                        ),
                        text: 'Continue with Google',
                        onTap: () {
                          // TODO: Google sign-in
                        },
                      ),
                      const SizedBox(height: 12),
                      SocialIconButton(
                        icon: const FaIcon(
                          FontAwesomeIcons.github,
                          size: 20,
                          color: Colors.black,
                        ),
                        text: 'Continue with GitHub',
                        onTap: () {
                          // TODO: GitHub sign-in
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Center(
                    child: TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.register),
                      child: const Text(
                        "Don't have an account? Sign up",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
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
