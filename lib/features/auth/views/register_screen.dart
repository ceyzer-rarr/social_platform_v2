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
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 430,
                minHeight: size.height * 0.9,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        /// Username
                        Obx(() => AppTextField(
                          label: 'Username',
                          controller: controller.usernameController,
                          validator: (v) => Validators.requiredField(
                            v,
                            fieldName: 'Username',
                          ),
                          errorText: controller.usernameError.value,
                          onChanged: (_) =>
                          controller.usernameError.value = null,
                        )),
                        const SizedBox(height: 16),

                        /// First + Last name
                        Row(
                          children: [
                            Expanded(
                              child: AppTextField(
                                label: 'First name',
                                controller:
                                controller.firstNameController,
                                validator: (v) =>
                                    Validators.requiredField(
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
                                validator: (v) =>
                                    Validators.requiredField(
                                      v,
                                      fieldName: 'Last name',
                                    ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        /// Email
                        Obx(() => AppTextField(
                          label: 'Email',
                          controller: controller.emailController,
                          keyboardType:
                          TextInputType.emailAddress,
                          validator: Validators.email,
                          errorText:
                          controller.emailError.value,
                          onChanged: (_) =>
                          controller.emailError.value = null,
                        )),
                        const SizedBox(height: 16),

                        /// Password
                        Obx(() => AppTextField(
                          label: 'Password',
                          controller:
                          controller.passwordController,
                          obscureText:
                          controller.isPasswordObscured.value,
                          validator: (v) =>
                              Validators.minLength(
                                v,
                                6,
                                fieldName: 'Password',
                              ),
                          errorText:
                          controller.passwordError.value,
                          onChanged: (_) =>
                          controller.passwordError.value =
                          null,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordObscured.value
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                            ),
                            onPressed:
                            controller.isPasswordObscured
                                .toggle,
                          ),
                        )),
                        const SizedBox(height: 16),

                        /// Confirm Password
                        Obx(() => AppTextField(
                          label: 'Confirm Password',
                          controller: controller
                              .confirmPasswordController,
                          obscureText: controller
                              .isConfirmPasswordObscured.value,
                          validator: (v) =>
                              Validators.minLength(
                                v,
                                6,
                                fieldName: 'Confirm Password',
                              ),
                          errorText: controller
                              .confirmPasswordError.value,
                          onChanged: (_) =>
                          controller
                              .confirmPasswordError.value =
                          null,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller
                                  .isConfirmPasswordObscured
                                  .value
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                            ),
                            onPressed: controller
                                .isConfirmPasswordObscured
                                .toggle,
                          ),
                        )),

                        const SizedBox(height: 24),

                        /// Submit
                        Obx(() => PrimaryButton(
                          label: 'Sign up',
                          isLoading:
                          controller.isLoading.value,
                          onPressed: controller.submit,
                        )),
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
                        onTap: () {},
                      ),
                      const SizedBox(height: 12),
                      SocialIconButton(
                        icon: const FaIcon(
                          FontAwesomeIcons.github,
                          size: 20,
                          color: Colors.black,
                        ),
                        text: 'Continue with GitHub',
                        onTap: () {},
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
}
