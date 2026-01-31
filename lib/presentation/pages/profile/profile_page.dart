import 'package:app_wearehouse_with_backend/presentation/user/bloc/about/about_bloc.dart';
import 'package:app_wearehouse_with_backend/presentation/user/bloc/about/about_event.dart';
import 'package:app_wearehouse_with_backend/presentation/user/bloc/update_profil/profile_update_bloc.dart';
import 'package:app_wearehouse_with_backend/presentation/user/bloc/update_profil/profile_update_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection.dart';
import '../profile/edit_password.dart';
import '../profile/edit_profile.dart';
import '../profile/request_to_be_a_admin.dart';
import '../profile/tentang_kami_page.dart';
import '../../user/bloc/request_to_admin/user_request_admin_bloc.dart';

class UserProfilePage extends StatelessWidget {
const UserProfilePage({super.key});

static const _primary = Color(0xFF2FA4A9);

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFFF6F8FA),
appBar: AppBar(
title: const Text('Profile'),
backgroundColor: _primary,
elevation: 0,
),
body: ListView(
padding: const EdgeInsets.all(16),
children: [
_profileHeader(),
const SizedBox(height: 24),

/// CHANGE PASSWORD
_menuCard(
icon: Icons.lock_outline,
title: 'Change Password',
onTap: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) => const ChangePasswordPage(),
),
);
},
),

/// REQUEST TO BE ADMIN
_menuCard(
icon: Icons.admin_panel_settings_outlined,
title: 'Request to be Admin',
onTap: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) => BlocProvider(
create: (_) => sl<UserRequestAdminBloc>(),
    child: const UserRequestAdminPage(),
    ),
    ),
    );
    },
    ),

    /// EDIT PROFILE (🔥 FIX PROVIDER DI SINI)
    _menuCard(
    icon: Icons.person_outline,
    title: 'Change Profile',
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (_) => BlocProvider(
    create: (_) => sl<ProfileBloc>()..add(LoadProfile()),
        child: const EditProfilePage(),
        ),
        ),
        );
        },
        ),


        /// ABOUT US
       _menuCard(
  icon: Icons.info_outline,
  title: 'About Us',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => sl<AboutBloc>()..add(LoadAbout()),
          child: const TentangKamiPage(),
        ),
      ),
    );
  },
),

            /// LOGOUT
            _menuCard(
            icon: Icons.logout,
            title: 'Logout',
            color: Colors.red,
            onTap: () {
            Navigator.popUntil(context, (route) => route.isFirst);
            },
            ),
            ],
            ),
            );
            }

            // =========================
            // PROFILE HEADER
            // =========================
            Widget _profileHeader() {
            return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
            color: _primary,
            borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
            children: [
            const CircleAvatar(
            radius: 32,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 36, color: _primary),
            ),
            const SizedBox(width: 16),
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
            Text(
            'Nama User',
            style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            ),
            ),
            SizedBox(height: 4),
            Text(
            'User',
            style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
            ),
            ),
            ],
            ),
            ],
            ),
            );
            }

            // =========================
            // MENU ITEM
            // =========================
            Widget _menuCard({
            required IconData icon,
            required String title,
            Color color = _primary,
            required VoidCallback onTap,
            }) {
            return GestureDetector(
            onTap: onTap,
            child: Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
            BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            ),
            ],
            ),
            child: Row(
            children: [
            Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
            child: Text(
            title,
            style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            ),
            ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
            ],
            ),
            ),
            );
            }
            }
