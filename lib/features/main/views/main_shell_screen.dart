import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../home/views/home_screen.dart';
import '../../profile/views/profile_screen.dart';
import '../controllers/main_shell_controller.dart';
import '../../post/views/new_post_screen.dart'; // NEW

class MainShellScreen extends GetView<MainShellController> {
  const MainShellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
        backgroundColor: AppColors.background,
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: [
            HomeScreen(),
            // TODO: replace with real SearchScreen
            const Center(child: Text('Search')),
            // TODO: replace with real NotificationScreen
            const Center(child: Text('Notifications')),
            const ProfileScreen(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: GestureDetector(
          onTap: controller.openCreatePost,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF7B61FF), // purple
                  Color(0xFF4C9DFF), // blue
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 8,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          color: Colors.white,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_outlined,
                  isActive: controller.currentIndex.value == 0,
                  onTap: () => controller.changeTab(0),
                ),
                _NavItem(
                  icon: Icons.search,
                  isActive: controller.currentIndex.value == 1,
                  onTap: () => controller.changeTab(1),
                ),
                const SizedBox(width: 56), // space for center button
                _NavItem(
                  icon: Icons.notifications_none,
                  isActive: controller.currentIndex.value == 2,
                  onTap: () => controller.changeTab(2),
                ),
                _NavItem(
                  icon: Icons.person_outline,
                  isActive: controller.currentIndex.value == 3,
                  onTap: () => controller.changeTab(3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    super.key,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primary : AppColors.textSecondary;

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Icon(
          icon,
          color: color,
        ),
      ),
    );
  }
}
