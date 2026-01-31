import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/bloc/logout/logout_bloc.dart';
import '../inventory/user_inventory_page.dart';
import '../../profile/profile_page.dart';
import '../scan/scan_pages.dart';


class UserDashboardPage extends StatelessWidget {
  const UserDashboardPage({super.key});

  static const primaryColor = Color(0xFF2FA4A9);

  @override  
  Widget build(BuildContext context) {
      final authToken = 'YOUR_AUTH_TOKEN'; // nanti ambil dari storage

    return BlocListener<LogoutBloc, LogoutState>(
      listener: (context, state) {
        state.whenOrNull(
          success: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/login',
              (_) => false,
            );
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
        );
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,

        /// 🔹 APP BAR + LOGOUT
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text("User Dashboard"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.read<LogoutBloc>().add(
                   const LogoutEvent.submit(),
                );
              },
            ),
          ],
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              _header(),
              const SizedBox(height: 20),
              _summary(),
              const SizedBox(height: 24),
              _quickMenu(context),
              const SizedBox(height: 24),
              _recentTask(),
            ],
          ),
        ),
      ),
    );
  }
  // ================= HEADER =================
  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Halo 👋", style: TextStyle(color: Colors.white70)),
          SizedBox(height: 6),
          Text(
            "Warehouse Staff",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "Siap bekerja hari ini?",
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // ================= SUMMARY =================
  Widget _summary() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          _SummaryCard(title: "Stock", value: "320", icon: Icons.inventory_2),
          SizedBox(width: 16),
          _SummaryCard(title: "Jobs", value: "4", icon: Icons.work_outline),
        ],
      ),
    );
  }

  // ================= QUICK MENU =================
  Widget _quickMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Quick Menu",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          _menuTile(
            icon: Icons.inventory,
            title: "Inventory",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UserInventoryPage()),
              );
            },
          ),

          _menuTile(
            icon: Icons.qr_code_scanner,
            title: "Scan Item",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UserScanPage()),
              );
            },
          ),

          _menuTile(
            icon: Icons.person,
            title: "Profile",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UserProfilePage()),
              );
            },
          ),
        ],
      ),
    );
  }

  // ================= RECENT TASK =================
  Widget _recentTask() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Today Activity",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),

          _ActivityTile(icon: Icons.check_circle, text: "Stock check selesai"),

          _ActivityTile(icon: Icons.local_shipping, text: "Distribusi barang"),
        ],
      ),
    );
  }

  Widget _menuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: primaryColor),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
/// COMPONENTS
////////////////////////////////////////////////////////////////////////////////

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: UserDashboardPage.primaryColor),

            const SizedBox(height: 10),

            Text(
              value,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            Text(title, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ActivityTile({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: UserDashboardPage.primaryColor),
        title: Text(text),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}
