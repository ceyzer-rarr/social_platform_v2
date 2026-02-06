import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';
import '../widgets/delete_account_dialog.dart';
import '../widgets/logout_confirm_dialog.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController =
    Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Settings and activity',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        children: [
          _sectionTitle('Your account'),
          _item(
            icon: Icons.shield_outlined,
            title: 'Privacy Center',
            onTap: () {
              // navigate later
            },
          ),
          _item(
            icon: Icons.person_outline,
            title: 'Account Status',
            onTap: () {
              // navigate later
            },
          ),
          _item(
            icon: Icons.info_outline,
            title: 'About',
            onTap: () {
              // navigate later
            },
          ),

          _divider(),

          _sectionTitle('Also from Meta'),
          _item(
            icon: Icons.chat_outlined,
            title: 'WhatsApp',
            subtitle: 'Message privately with friends and family',
          ),
          _item(
            icon: Icons.movie_creation_outlined,
            title: 'Edits',
            subtitle: 'Create videos with powerful editing tools',
            trailing: _blueDot(),
          ),
          _item(
            icon: Icons.alternate_email,
            title: 'Threads',
            subtitle: 'Share ideas and join conversations',
          ),
          _item(
            icon: Icons.facebook,
            title: 'Facebook',
            subtitle: 'Explore things you love',
          ),
          _item(
            icon: Icons.message_outlined,
            title: 'Messenger',
            subtitle: 'Chat and share seamlessly',
          ),

          _divider(),

          _sectionTitle('Login'),
          _textButton(
            text: 'Add account',
            color: const Color(0xFF1877F2),
            onTap: () {
              // add account later
            },
          ),
          _textButton(
            text: 'Log out',
            color: Colors.redAccent,
            onTap: () {
              Get.dialog(
                const LogoutConfirmDialog(),
                barrierDismissible: true,
              );
            },
          ),

          _textButton(
            text: 'Delete account',
            color: Colors.red,
            onTap: () {
              Get.dialog(
                const DeleteAccountDialog(),
                barrierDismissible: true,
              );
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // ---------------- UI HELPERS ----------------

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _item({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
        subtitle,
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 12,
        ),
      )
          : null,
      trailing: trailing ??
          const Icon(Icons.chevron_right, color: Colors.black38),
      onTap: onTap,
    );
  }

  Widget _textButton({
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Divider(height: 1),
    );
  }

  Widget _blueDot() {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
    );
  }
}
