import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const primaryColor = Color(0xFF2FA4A9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _settingTile(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            trailing: Switch(value: true, onChanged: (_) {}),
          ),
          _settingTile(
            icon: Icons.dark_mode_outlined,
            title: 'Dark Mode',
            trailing: Switch(value: false, onChanged: (_) {}),
          ),
          _settingTile(
            icon: Icons.language_outlined,
            title: 'Language',
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          _settingTile(
            icon: Icons.security_outlined,
            title: 'Privacy & Security',
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _settingTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: primaryColor),
        ),
        title: Text(title),
        trailing: trailing,
      ),
    );
  }
}
