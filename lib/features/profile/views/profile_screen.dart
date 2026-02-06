import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../controllers/profile_controller.dart';
import '../models/profile_model.dart';
import '../../../routes/app_routes.dart';
import '../screens/settings_screen.dart';

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
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: AppColors.background,
                elevation: 0,
                pinned: true,
                centerTitle: false,
                title: Text(
                  profile.username,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.settings_outlined,
                        color: AppColors.textPrimary),
                    onPressed: () {
                      // TODO: settings later
                      Get.to(() => const SettingsScreen());
                    },
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _ProfileHeader(profile: profile),
                    const SizedBox(height: 16),
                    _ProfileBioSection(profile: profile),
                    const SizedBox(height: 12),
                    _EditProfileButton(onTap: () {
                      Get.toNamed(AppRoutes.profileEdit);
                    }),
                    const SizedBox(height: 16),
                    const _ProfileTabs(),
                    const SizedBox(height: 8),
                    _PostsGrid(),
                    const SizedBox(height: 24),
                    // _BottomActions(onLogout: controller.logout),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final ProfileModel profile;

  const _ProfileHeader({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey.shade300,
            backgroundImage: (profile.picture != null &&
                profile.picture!.isNotEmpty)
                ? NetworkImage(profile.picture!)
                : null,
            child: (profile.picture == null || profile.picture!.isEmpty)
                ? const Icon(Icons.person, size: 40, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 24),
          // Stats
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _StatItem(label: 'Posts', value: '124'),
                _StatItem(label: 'Followers', value: '2.5K'),
                _StatItem(label: 'Following', value: '892'),
              ],
            ),
          ),
        ],
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

class _ProfileBioSection extends StatelessWidget {
  final ProfileModel profile;

  const _ProfileBioSection({required this.profile});

  @override
  Widget build(BuildContext context) {
    final hasFullName = profile.fullName.trim().isNotEmpty;
    final hasBio = profile.bio != null && profile.bio!.isNotEmpty;
    final hasWebsite = profile.contactUrl != null &&
        profile.contactUrl!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasFullName)
            Text(
              profile.fullName,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          if (hasFullName) const SizedBox(height: 4),
          if (hasBio)
            Text(
              profile.bio!,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
          if (hasBio) const SizedBox(height: 4),
          if (hasWebsite)
            GestureDetector(
              onTap: () {
                // TODO: open link later
              },
              child: Text(
                profile.contactUrl!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF0033A1),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _EditProfileButton extends StatelessWidget {
  final VoidCallback onTap;

  const _EditProfileButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 36,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.grey.shade300),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Colors.white,
          ),
          onPressed: onTap,
          child: const Text(
            'Edit Profile',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileTabs extends StatelessWidget {
  const _ProfileTabs();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 8),
      child: TabBarHeader(),
    );
  }
}

/// simple IG-like tabs header (no real switching yet)
class TabBarHeader extends StatelessWidget {
  const TabBarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16),
        _TabItem(
          icon: Icons.grid_on_rounded,
          isActive: true,
        ),
        const SizedBox(width: 32),
        _TabItem(
          icon: Icons.person_pin_outlined,
          isActive: false,
        ),
      ],
    );
  }
}

class _TabItem extends StatelessWidget {
  final IconData icon;
  final bool isActive;

  const _TabItem({
    required this.icon,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final color =
    isActive ? AppColors.textPrimary : AppColors.textSecondary;

    return Column(
      children: [
        Icon(icon, size: 24, color: color),
        const SizedBox(height: 4),
        Container(
          height: 2,
          width: 40,
          color: isActive ? AppColors.textPrimary : Colors.transparent,
        ),
      ],
    );
  }
}

/// Just a placeholder 3-column grid like Instagram posts.
class _PostsGrid extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isPostsLoading.value) {
        return const Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (controller.posts.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: Text('No posts yet')),
        );
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        child: GridView.builder(
          padding: const EdgeInsets.only(top: 8),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.posts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
          ),
          itemBuilder: (_, index) {
            final post = controller.posts[index];

            return AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                post.picture,
                fit: BoxFit.cover,
                loadingBuilder: (_, child, progress) {
                  if (progress == null) return child;
                  return Container(color: Colors.grey.shade300);
                },
                errorBuilder: (_, __, ___) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.broken_image),
                  );
                },
              ),
            );
          },
        ),
      );
    });
  }
}


// class _BottomActions extends StatelessWidget {
//   final VoidCallback onLogout;
//
//   const _BottomActions({required this.onLogout});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const Divider(height: 1),
//         ListTile(
//           leading: const Icon(Icons.privacy_tip_outlined,
//               color: AppColors.textPrimary),
//           title: const Text('Privacy'),
//           onTap: () {
//             // TODO: implement
//           },
//         ),
//         const Divider(height: 1),
//         ListTile(
//           leading: const Icon(Icons.info_outline,
//               color: AppColors.textPrimary),
//           title: const Text('Information'),
//           onTap: () {
//             // TODO: implement
//           },
//         ),
//         const Divider(height: 1),
//         ListTile(
//           leading:
//           const Icon(Icons.logout, color: Colors.redAccent),
//           title: const Text(
//             'Log out',
//             style: TextStyle(color: Colors.redAccent),
//           ),
//           onTap: onLogout,
//         ),
//       ],
//     );
//   }
// }
