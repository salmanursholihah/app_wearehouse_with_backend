import 'package:flutter/material.dart';

import 'edit_password.dart';
import 'edit_profile.dart';
import 'settings.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const primaryColor = Color(0xFF2FA4A9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          _header(),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _infoCard(),
                const SizedBox(height: 24),
                _menuSection(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // HEADER
  // =========================
  Widget _header() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        children: const [
          CircleAvatar(
            radius: 42,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 50, color: primaryColor),
          ),
          SizedBox(height: 12),
          Text(
            'Admin Warehouse',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'admin@warehouse.com',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }

  // =========================
  // INFO CARD
  // =========================
  Widget _infoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          _infoRow(icon: Icons.badge_outlined, title: 'Role', value: 'Admin'),
          const Divider(height: 32),
          _infoRow(
            icon: Icons.verified_user_outlined,
            title: 'Access Level',
            value: 'Manage Features',
          ),
          const Divider(height: 32),
          _infoRow(
            icon: Icons.schedule_outlined,
            title: 'Last Login',
            value: 'Today, 08:30 AM',
          ),
        ],
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        _iconBox(icon),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // =========================
  // MENU
  // =========================
  Widget _menuSection(BuildContext context) {
    return Column(
      children: [
        _menuItem(
          icon: Icons.edit_outlined,
          title: 'Edit Profile',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const EditProfilePage()),
          ),
        ),
        _menuItem(
          icon: Icons.lock_outline,
          title: 'Change Password',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChangePasswordPage()),
          ),
        ),
        _menuItem(
          icon: Icons.settings_outlined,
          title: 'Settings',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsPage()),
          ),
        ),
        const SizedBox(height: 16),
        _menuItem(
          icon: Icons.logout,
          title: 'Logout',
          color: Colors.red,
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
          },
        ),
      ],
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    Color color = primaryColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
          ],
        ),
        child: Row(
          children: [
            _iconBox(icon, color: color),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _iconBox(IconData icon, {Color color = primaryColor}) {
    return Container(
      height: 42,
      width: 42,
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: color),
    );
  }
}
