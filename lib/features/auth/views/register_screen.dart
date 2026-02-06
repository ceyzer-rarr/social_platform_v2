import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

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
              constraints: BoxConstraints(maxWidth: 430, minHeight: size.height * 0.9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back
                  // IconButton(
                  //   onPressed: () => Get.back(),
                  //   icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                  //   padding: EdgeInsets.zero,
                  //   constraints: const BoxConstraints(),
                  // ),
                  const SizedBox(height: 8),

                  const Text('Create account', style: AppTextStyles.title),
                  const SizedBox(height: 4),
                  const Text(
                    'Sign up to get started',
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
                                  v,
                                  fieldName: 'First name',
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: AppTextField(
                                label: 'Last name',
                                controller: controller.lastNameController,
                                validator: (v) => Validators.requiredField(
                                  v,
                                  fieldName: 'Last name',
                                ),
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

                        // Password + confirm
                        Obx(
                              () => Column(
                            children: [
                              TextFormField(
                                controller: controller.passwordController,
                                obscureText: controller.isPasswordObscured.value,
                                decoration: _passwordDecoration(
                                  'Password',
                                  controller.isPasswordObscured.value,
                                      () {
                                    controller.isPasswordObscured.value =
                                    !controller.isPasswordObscured.value;
                                  },
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
                                decoration: _passwordDecoration(
                                  'Confirm Password',
                                  controller.isConfirmPasswordObscured.value,
                                      () {
                                    controller.isConfirmPasswordObscured.value =
                                    !controller.isConfirmPasswordObscured.value;
                                  },
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

                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text('or continue with',
                            style: AppTextStyles.subtitle),
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
                          color: Color(0xFFDB4437), // Google red
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
                          color: Colors.black, // GitHub black
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
                      onPressed: () => Get.back(),
                      child: const Text(
                        'Already have an account? Log in',
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

  InputDecoration _passwordDecoration(
      String label,
      bool obscured,
      VoidCallback toggle,
      ) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.inputBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.inputBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.2),
      ),
      suffixIcon: IconButton(
        icon: Icon(
          obscured ? Icons.visibility_off_rounded : Icons.visibility_rounded,
        ),
        onPressed: toggle,
      ),
    );
  }
}
