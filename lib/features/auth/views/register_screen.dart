import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/social_icon_button.dart';
import '../controllers/register_controller.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

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
                  // Back arrow
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(height: 16),

                  // Logo placeholder
                  Center(
                    child: Column(
                      children: const [
                        // Replace with Image.asset('assets/logo.png', height: 40)
                        Text(
                          'Social Platform',
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

                  const Text('Create your Account', style: AppTextStyles.title),
                  const SizedBox(height: 4),
                  const Text(
                    'Please fill in the information below to sign up.',
                    style: AppTextStyles.subtitle,
                  ),
                  const SizedBox(height: 24),

                  Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        AppTextField(
                          label: 'Username',
                          controller: controller.usernameController,
                          validator: (v) =>
                              Validators.requiredField(v, fieldName: 'Username'),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: AppTextField(
                                label: 'First name',
                                controller: controller.firstNameController,
                                validator: (v) => Validators.requiredField(
                                    v, fieldName: 'First name'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: AppTextField(
                                label: 'Last name',
                                controller: controller.lastNameController,
                                validator: (v) => Validators.requiredField(
                                    v, fieldName: 'Last name'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          label: 'Email',
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: Validators.email,
                        ),
                        const SizedBox(height: 16),

                        // Password
                        Obx(
                              () => Column(
                            children: [
                              TextFormField(
                                controller: controller.passwordController,
                                obscureText: controller.isPasswordObscured.value,
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
                                validator: (v) => Validators.minLength(
                                  v,
                                  6,
                                  fieldName: 'Password',
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: controller.confirmPasswordController,
                                obscureText:
                                controller.isConfirmPasswordObscured.value,
                                decoration: InputDecoration(
                                  labelText: 'Confirm Password',
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
                                      controller
                                          .isConfirmPasswordObscured.value
                                          ? Icons.visibility_off_rounded
                                          : Icons.visibility_rounded,
                                    ),
                                    onPressed: () {
                                      controller.isConfirmPasswordObscured
                                          .value = !controller
                                          .isConfirmPasswordObscured.value;
                                    },
                                  ),
                                ),
                                validator: (v) => Validators.minLength(
                                  v,
                                  6,
                                  fieldName: 'Confirm Password',
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        Obx(
                              () => PrimaryButton(
                            label: 'Sign up',
                            isLoading: controller.isLoading.value,
                            onPressed: controller.submit,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Or sign up with
                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text('- Or sign up with -',
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

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
