import 'package:app_wearehouse_with_backend/presentation/pages/user/dashboard/user_dashboard_page.dart';
import 'package:app_wearehouse_with_backend/presentation/pages/user/inventory/user_inventory_page.dart';
import 'package:app_wearehouse_with_backend/presentation/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';
import '../../widgets/user_buttom_navbar.dart';

class UserMainPage extends StatefulWidget {
  const UserMainPage({super.key});

  @override
  State<UserMainPage> createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  int _index = 0;

  final pages = const [
    UserDashboardPage(),
    UserInventoryPage(), // READ ONLY
    UserProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: UserBottomNavbar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
