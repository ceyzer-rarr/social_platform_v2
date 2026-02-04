import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/info_row.dart';
import '../../../routes/app_routes.dart';
import '../controllers/profile_controller.dart';
import '../models/profile_model.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        if (controller.isLoading.value && controller.profile.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final ProfileModel? profile = controller.profile.value;
        if (profile == null) {
          return const Center(child: Text('No profile data'));
        }

        return RefreshIndicator(
          onRefresh: controller.fetchProfile,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(profile),
                const SizedBox(height: 16),
                _buildPersonalInfoCard(profile),
                const SizedBox(height: 16),
                _buildSettingsCard(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      }),
    );
  }

  // ---------------- HEADER ----------------

  Widget _buildHeader(ProfileModel profile) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 190,
          decoration: BoxDecoration(
            borderRadius:
            const BorderRadius.vertical(bottom: Radius.circular(32)),
            image: profile.cover != null && profile.cover!.isNotEmpty
                ? DecorationImage(
              image: NetworkImage(profile.cover!),
              fit: BoxFit.cover,
            )
                : null,
            gradient: profile.cover == null || profile.cover!.isEmpty
                ? const LinearGradient(
              colors: [AppColors.primary, Color(0xFF8EC5FC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
                : null,
          ),
        ),

        // <-- EDIT BUTTON (TOP-RIGHT) -->
        Positioned(
          top: 40,
          right: 16,
          child: Material(
            color: Colors.white.withOpacity(0.9),
            shape: const CircleBorder(),
            elevation: 2,
            child: IconButton(
              icon: const Icon(
                Icons.edit_outlined,
                size: 20,
                color: AppColors.primary,
              ),
              onPressed: () async {
                final result = await Get.toNamed(AppRoutes.profileEdit);
                // if user saved something, reload profile data
                if (result != null) {
                  await controller.fetchProfile();
                }
              },
            ),
          ),
        ),

        Positioned(
          bottom: -40,
          left: 0,
          right: 0,
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 36,
                  backgroundImage: (profile.picture != null &&
                      profile.picture!.isNotEmpty)
                      ? NetworkImage(profile.picture!)
                      : null,
                  child: (profile.picture == null ||
                      profile.picture!.isEmpty)
                      ? const Icon(Icons.person, size: 40)
                      : null,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                profile.fullName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '@${profile.username}',
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------- PERSONAL INFO CARD ----------------

  Widget _buildPersonalInfoCard(ProfileModel profile) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Personal Info',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              InfoRow(
                icon: Icons.cake_outlined,
                label: 'Date of birth',
                value: profile.birthOfDate,
              ),
              InfoRow(
                icon: Icons.email_outlined,
                label: 'Email Address',
                value: profile.email,
              ),
              InfoRow(
                icon: Icons.flag_outlined,
                label: 'Nationality',
                value: profile.nationality,
              ),
              InfoRow(
                icon: Icons.link_outlined,
                label: 'Contact URL',
                value: profile.contactUrl,
              ),
              InfoRow(
                icon: Icons.location_on_outlined,
                label: 'Address',
                value: profile.address,
              ),
              if (profile.bio != null && profile.bio!.isNotEmpty) ...[
                const SizedBox(height: 8),
                const Text(
                  'Bio',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  profile.bio!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- SETTINGS CARD ----------------

  Widget _buildSettingsCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        child: Column(
          children: [
            // <-- EDIT PROFILE ROW IN SETTINGS -->
            ListTile(
              leading: const Icon(Icons.edit_outlined, color: AppColors.primary),
              title: const Text('Edit Profile'),
              onTap: () async {
                final result = await Get.toNamed(AppRoutes.profileEdit);
                if (result != null) {
                  await controller.fetchProfile();
                }
              },
            ),
            const Divider(height: 1),

            ListTile(
              leading:
              const Icon(Icons.lock_outline, color: AppColors.primary),
              title: const Text('Privacy'),
              onTap: () {
                // TODO: implement later
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading:
              const Icon(Icons.info_outline, color: AppColors.primary),
              title: const Text('Information'),
              onTap: () {
                // TODO: implement later
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text(
                'Log out',
                style: TextStyle(color: Colors.redAccent),
              ),
              onTap: controller.logout,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
