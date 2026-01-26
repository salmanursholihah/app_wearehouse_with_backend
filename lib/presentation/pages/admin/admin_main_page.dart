import 'package:flutter/material.dart';
import 'dashboard/admin_dashboard_page.dart';
import 'inventory/inventory_page.dart';
import '../../widgets/admin_buttom_navbar.dart';

import 'jobs/jobs_pages.dart';
import 'profile/profile_pages.dart';
import 'scan/scan_pages.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  int _index = 0;

  final pages = const [
    AdminDashboardPage(),
    InventoryPage(),
    ScanPage(),
    JobsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: AdminBottomNavbar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
