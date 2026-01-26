import 'package:app_wearehouse_with_backend/presentation/pages/admin/scan/scan_pages.dart';
import 'package:flutter/material.dart';

import '../inventory/inventory_page.dart';
import '../jobs/jobs_pages.dart';
import '../scan/scan_pages.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  static const primaryColor = Color(0xFF2FA4A9);

  String _greeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) return "Selamat Pagi";
    if (hour < 15) return "Selamat Siang";
    if (hour < 18) return "Selamat Sore";
    return "Selamat Malam";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Text("Admin Dashboard"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            const SizedBox(height: 20),

            _summarySection(),

            const SizedBox(height: 28),

            _quickActions(context),

            const SizedBox(height: 28),

            _recentActivity(),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${_greeting()}, Admin 👋",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          "Overview sistem hari ini",
          style: TextStyle(color: Colors.grey.shade600),
        ),
      ],
    );
  }

  // ================= SUMMARY =================
  Widget _summarySection() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.25,

      children: const [
        _SummaryCard(
          icon: Icons.inventory_2,
          title: "Total Stock",
          value: "580",
        ),

        _SummaryCard(
          icon: Icons.warning_amber,
          title: "Low Stock",
          value: "8",
          isAlert: true,
        ),

        _SummaryCard(icon: Icons.work, title: "Active Jobs", value: "12"),

        _SummaryCard(icon: Icons.local_shipping, title: "Incoming", value: "5"),
      ],
    );
  }

  // ================= QUICK ACTION =================
  Widget _quickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Quick Actions",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            _ActionButton(
              icon: Icons.inventory,
              label: "Inventory",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const InventoryPage()),
                );
              },
            ),

            _ActionButton(
              icon: Icons.qr_code_scanner,
              label: "Scan",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ScanPage()),
                );
              },
            ),

            _ActionButton(
              icon: Icons.work_outline,
              label: "Jobs",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const JobsPage()),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  // ================= ACTIVITY =================
  Widget _recentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: const [
        Text(
          "Recent Activity",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 12),

        _ActivityTile(icon: Icons.add_circle, text: "Menambahkan 20 item baru"),

        _ActivityTile(icon: Icons.remove_circle, text: "Menggunakan 5 item"),

        _ActivityTile(
          icon: Icons.local_shipping,
          text: "Distribusi barang ke site A",
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
/// COMPONENTS
////////////////////////////////////////////////////////////////////////////////

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool isAlert;

  const _SummaryCard({
    required this.icon,
    required this.title,
    required this.value,
    this.isAlert = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isAlert ? Colors.red : AdminDashboardPage.primaryColor;

    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color),
          ),

          const Spacer(),

          Text(title, style: const TextStyle(fontSize: 12)),

          const SizedBox(height: 4),

          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),

        onTap: onTap,

        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.symmetric(vertical: 16),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),

            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
            ],
          ),

          child: Column(
            children: [
              Icon(icon, color: AdminDashboardPage.primaryColor),

              const SizedBox(height: 8),

              Text(label, style: const TextStyle(fontSize: 12)),
            ],
          ),
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
        leading: Icon(icon, color: AdminDashboardPage.primaryColor),

        title: Text(text),

        trailing: const Icon(Icons.chevron_right),

        onTap: () {},
      ),
    );
  }
}
