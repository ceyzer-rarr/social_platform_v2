import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/section_title.dart';
import '../controllers/profile_edit_controller.dart';
import '../models/profile_model.dart';

class ProfileEditScreen extends GetView<ProfileEditController> {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.textPrimary, size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final ProfileModel? profile =
            controller.originalProfile; // after load it is set

        if (profile == null) {
          return const Center(child: Text('No profile data'));
        }

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  _HeaderArea(controller: controller, profile: profile),
                  const SizedBox(height: 16),

                  // ---------- BASIC DETAIL ----------
                  const SectionTitle(text: 'Basic Detail'),
                  AppTextField(
                    label: 'Username',
                    controller: controller.usernameController,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    label: 'Full name',
                    controller: controller.fullNameController,
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => controller.selectBirthDate(context),
                    child: AbsorbPointer(
                      child: AppTextField(
                        label: 'Date of birth',
                        controller: controller.birthDateController,
                        suffixIcon: const Icon(
                          Icons.calendar_today_outlined,
                          size: 18,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ---------- CONTACT DETAIL ----------
                  const SectionTitle(text: 'Contact Detail'),
                  AppTextField(
                    label: 'Contact URL',
                    controller: controller.contactUrlController,
                    keyboardType: TextInputType.url,
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    label: 'Address',
                    controller: controller.addressController,
                    keyboardType: TextInputType.streetAddress,
                  ),

                  const SizedBox(height: 16),

                  // ---------- PERSONAL DETAIL ----------
                  const SectionTitle(text: 'Personal Detail'),
                  AppTextField(
                    label: 'Age',
                    controller: controller.ageController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    label: 'Bio',
                    controller: controller.bioController,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    label: 'Note',
                    controller: controller.noteController,
                    maxLines: 3,
                  ),

                  const SizedBox(height: 24),

                  Obx(
                        () => PrimaryButton(
                      label: 'Save',
                      isLoading: controller.isSaving.value,
                      onPressed: controller.save,
                    ),
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

class _HeaderArea extends StatelessWidget {
  final ProfileEditController controller;
  final ProfileModel profile;

  const _HeaderArea({
    required this.controller,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      File? newCover = controller.newCoverFile.value;
      File? newAvatar = controller.newAvatarFile.value;

      ImageProvider? coverImage;
      if (newCover != null) {
        coverImage = FileImage(newCover);
      } else if (profile.cover != null && profile.cover!.isNotEmpty) {
        coverImage = NetworkImage(profile.cover!);
      }

      ImageProvider? avatarImage;
      if (newAvatar != null) {
        avatarImage = FileImage(newAvatar);
      } else if (profile.picture != null && profile.picture!.isNotEmpty) {
        avatarImage = NetworkImage(profile.picture!);
      }

      return Stack(
        clipBehavior: Clip.none,
        children: [
          // Cover
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(24)),
              color: AppColors.primary,
              image: coverImage != null
                  ? DecorationImage(
                image: coverImage,
                fit: BoxFit.cover,
              )
                  : null,
            ),
          ),
          // Cover edit button
          Positioned(
            right: 12,
            bottom: 12,
            child: InkWell(
              onTap: controller.pickCover,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.photo_camera_outlined,
                  size: 18,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          // Avatar
          Positioned(
            bottom: -40,
            left: 0,
            right: 0,
            child: Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 36,
                      backgroundImage: avatarImage,
                      child: avatarImage == null
                          ? const Icon(Icons.person, size: 36)
                          : null,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: InkWell(
                      onTap: controller.pickAvatar,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 80),
        ],
      );
    });
  }
}
