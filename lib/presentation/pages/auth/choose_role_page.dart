import 'package:flutter/material.dart';

class ChooseRolePage extends StatelessWidget {
  const ChooseRolePage({super.key});

  static const primaryColor = Color(0xFF2FA4A9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        title: const Text("Login As"),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            const Text(
              "Select Role",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              "Choose how you want to access the system",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 32),

            _roleCard(
              context,
              icon: Icons.admin_panel_settings,
              title: "Admin",
              subtitle: "access to management features",
              onTap: () {
                Navigator.pushReplacementNamed(context, '/admin');
              },
            ),

            const SizedBox(height: 16),

            _roleCard(
              context,
              icon: Icons.person,
              title: "User",
              subtitle: "Limited access (view & tasks)",
              onTap: () {
                Navigator.pushReplacementNamed(context, '/user');
              },
            ),

            const SizedBox(height: 16),

            _roleCard(
              context,
              icon: Icons.person,
              title: "super Admin",
              subtitle: "Full access to all features",
              onTap: () {
                Navigator.pushReplacementNamed(context, '/super-admin');
              },
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // ROLE CARD WIDGET
  // =========================
  Widget _roleCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: primaryColor, size: 30),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
