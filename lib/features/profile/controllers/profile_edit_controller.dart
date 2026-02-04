import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/utils/snackbar_helper.dart';
import '../../profile/models/profile_model.dart';
import '../../profile/services/profile_service.dart';

class ProfileEditController extends GetxController {
  final ProfileService _profileService = ProfileService();
  final ImagePicker _picker = ImagePicker();

  // form key
  final formKey = GlobalKey<FormState>();

  // text controllers
  final usernameController = TextEditingController();
  final fullNameController = TextEditingController();
  final bioController = TextEditingController();
  final noteController = TextEditingController();
  final birthDateController = TextEditingController();
  final ageController = TextEditingController();
  final contactUrlController = TextEditingController();
  final addressController = TextEditingController();

  // observables
  final isLoading = false.obs;
  final isSaving = false.obs;

  final Rxn<DateTime> birthDate = Rxn<DateTime>();
  final Rxn<File> newAvatarFile = Rxn<File>();
  final Rxn<File> newCoverFile = Rxn<File>();

  late ProfileModel originalProfile;

  @override
  void onInit() {
    super.onInit();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    isLoading.value = true;
    try {
      final profile = await _profileService.getMe();
      originalProfile = profile;

      usernameController.text = profile.username;
      fullNameController.text = profile.fullName;
      bioController.text = profile.bio ?? '';
      noteController.text = profile.note ?? '';
      birthDateController.text = profile.birthOfDate ?? '';
      ageController.text = profile.age?.toString() ?? '';
      contactUrlController.text = profile.contactUrl ?? '';
      addressController.text = profile.address ?? '';
    } catch (e) {
      SnackbarHelper.showError('Failed to load profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickAvatar() async {
    final XFile? picked =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked != null) {
      newAvatarFile.value = File(picked.path);
    }
  }

  Future<void> pickCover() async {
    final XFile? picked =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked != null) {
      newCoverFile.value = File(picked.path);
    }
  }

  Future<void> selectBirthDate(BuildContext context) async {
    final now = DateTime.now();
    final initial = birthDate.value ??
        DateTime(now.year - 18, now.month, now.day); // default 18 y/o

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      birthDate.value = picked;
      birthDateController.text =
      '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
    }
  }

  Future<void> save() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    isSaving.value = true;

    try {
      final fullName = fullNameController.text.trim();
      String firstName = originalProfile.firstName ?? '';
      String lastName = originalProfile.lastName ?? '';

      if (fullName.isNotEmpty) {
        final parts = fullName.split(' ');
        firstName = parts.first;
        lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';
      }

      final updated = await _profileService.updateProfile(
        username: usernameController.text.trim(),
        firstName: firstName,
        lastName: lastName,
        bio: bioController.text.trim(),
        note: noteController.text.trim(),
        birthOfDate: birthDateController.text.trim().isEmpty
            ? null
            : birthDateController.text.trim(),
        age: ageController.text.trim().isEmpty
            ? null
            : ageController.text.trim(),
        contactUrl: contactUrlController.text.trim(),
        address: addressController.text.trim(),
        picture: newAvatarFile.value,
        cover: newCoverFile.value,
      );

      originalProfile = updated;
      SnackbarHelper.showSuccess('Profile updated successfully');
      Get.back(result: updated);
    } catch (e) {
      SnackbarHelper.showError('Failed to update profile: $e');
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    fullNameController.dispose();
    bioController.dispose();
    noteController.dispose();
    birthDateController.dispose();
    ageController.dispose();
    contactUrlController.dispose();
    addressController.dispose();
    super.onClose();
  }
}
