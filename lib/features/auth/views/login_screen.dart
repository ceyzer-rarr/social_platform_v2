import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 430, minHeight: size.height * 0.9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back arrow (optional)
                  IconButton(
                    onPressed: () => Get.back(canPop: true),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(height: 16),

                  // Logo
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

                  const Text('Login to your Account', style: AppTextStyles.title),
                  const SizedBox(height: 4),
                  const Text(
                    'Welcome back! Please enter your details.',
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
                                  horizontal: 16, vertical: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: AppColors.inputBorder),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: AppColors.inputBorder),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: AppColors.primary, width: 1.2),
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

                        const SizedBox(height: 24),

                        Obx(
                              () => PrimaryButton(
                            label: 'Sign in',
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
                        child: Text('- Or sign in with -',
                            style: AppTextStyles.subtitle),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialIconButton(
                        icon: const FaIcon(FontAwesomeIcons.google, size: 20),
                        onTap: () {
                          // TODO: implement Google login
                        },
                      ),
                      const SizedBox(width: 16),
                      SocialIconButton(
                        icon: const FaIcon(FontAwesomeIcons.facebookF, size: 20),
                        onTap: () {
                          // TODO: implement Facebook login
                        },
                      ),
                      const SizedBox(width: 16),
                      SocialIconButton(
                        icon: const FaIcon(FontAwesomeIcons.twitter, size: 20),
                        onTap: () {
                          // TODO: implement Twitter login
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Sign up link
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

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
