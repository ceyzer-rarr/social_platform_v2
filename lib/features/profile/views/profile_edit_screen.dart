import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../controllers/profile_edit_controller.dart';
import '../models/profile_model.dart';

class ProfileEditScreen extends GetView<ProfileEditController> {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.textPrimary,
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: controller.save,
            child: const Text(
              'Done',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final ProfileModel? profile = controller.originalProfile;
        if (profile == null) {
          return const Center(child: Text('No profile data'));
        }

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _AvatarHeader(controller: controller, profile: profile),
                  const SizedBox(height: 16),

                  // ---------- PUBLIC INFO ----------
                  const _SectionTitle('Public Information'),
                  const SizedBox(height: 8),
                  _ProfileEditField(
                    label: 'Name',
                    controller: controller.fullNameController,
                    textInputAction: TextInputAction.next,
                  ),
                  _ProfileEditField(
                    label: 'Username',
                    controller: controller.usernameController,
                    textInputAction: TextInputAction.next,
                  ),
                  _ProfileEditField(
                    label: 'Bio',
                    controller: controller.bioController,
                    maxLines: 2,
                    textInputAction: TextInputAction.newline,
                  ),
                  _ProfileEditField(
                    label: 'Website',
                    controller: controller.contactUrlController,
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.next,
                  ),

                  const SizedBox(height: 24),

                  // ---------- PRIVATE INFO ----------
                  const _SectionTitle('Private Information'),
                  const SizedBox(height: 4),
                  const Text(
                    "This information won't be shown on your profile",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // EMAIL – read-only (comes from API, cannot be edited)
                  _ReadOnlyField(
                    label: 'Email',
                    value: profile.email,
                  ),

                  _ProfileEditField(
                    label: 'Address',
                    controller: controller.addressController,
                    textInputAction: TextInputAction.next,
                  ),
                  _ProfileEditField(
                    label: 'Date of birth',
                    controller: controller.birthDateController,
                    readOnly: true,
                    onTap: () => controller.selectBirthDate(context),
                    suffixIcon: const Icon(
                      Icons.calendar_today_outlined,
                      size: 18,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  _ProfileEditField(
                    label: 'Age',
                    controller: controller.ageController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _AvatarHeader extends StatelessWidget {
  final ProfileEditController controller;
  final ProfileModel profile;

  const _AvatarHeader({
    required this.controller,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final File? newAvatar = controller.newAvatarFile.value;

      ImageProvider? avatarImage;
      if (newAvatar != null) {
        avatarImage = FileImage(newAvatar);
      } else if (profile.picture != null && profile.picture!.isNotEmpty) {
        avatarImage = NetworkImage(profile.picture!);
      }

      return Column(
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: Colors.grey.shade300,
            backgroundImage: avatarImage,
            child: avatarImage == null
                ? const Icon(Icons.person, size: 48, color: Colors.white)
                : null,
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: controller.pickAvatar,
            child: const Text(
              'Change Profile Photo',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
    });
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class _ProfileEditField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;

  const _ProfileEditField({
    required this.label,
    required this.controller,
    this.keyboardType,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          readOnly: readOnly,
          onTap: onTap,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            border: const UnderlineInputBorder(),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary, width: 1.2),
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

class _ReadOnlyField extends StatelessWidget {
  final String label;
  final String? value;

  const _ReadOnlyField({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final displayValue = (value == null || value!.isEmpty) ? '-' : value!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          displayValue,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
