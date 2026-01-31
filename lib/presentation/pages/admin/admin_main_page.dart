import 'package:app_wearehouse_with_backend/presentation/pages/admin/scan/scan_pages.dart';
import 'package:flutter/material.dart';
import '../../widgets/admin_buttom_navbar.dart';

import 'dashboard/admin_dashboard_page.dart';
import 'inventory/inventory_page.dart';
import 'jobs/jobs_pages.dart';
import '../profile/profile_pages.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  int _currentIndex = 0;

  final _pages = const [
    AdminDashboardPage(),
    InventoryPage(),
    ScanPage(),
    JobsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: AdminBottomNavbar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
