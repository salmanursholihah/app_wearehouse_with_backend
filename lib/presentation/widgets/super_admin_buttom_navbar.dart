import 'package:flutter/material.dart';

class SuperAdminBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const SuperAdminBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: const Color(0xFF2FA4A9),
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.data_exploration),
          label: 'Manage User',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.photo_library),
          label: 'Manage Data',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.monitor_sharp),
          label: 'Monitoring',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_accessibility),
          label: 'Settings',
        ),
      ],
    );
  }
}
