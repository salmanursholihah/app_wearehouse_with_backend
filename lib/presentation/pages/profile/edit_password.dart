// import 'package:flutter/material.dart';

// class ChangePasswordPage extends StatelessWidget {
//   const ChangePasswordPage({super.key});

//   static const primaryColor = Color(0xFF2FA4A9);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F8FA),
//       appBar: AppBar(
//         title: const Text('Change Password'),
//         backgroundColor: primaryColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             _passwordField('Current Password'),
//             _passwordField('New Password'),
//             _passwordField('Confirm New Password'),
//             const SizedBox(height: 32),
//             _updateButton(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _passwordField(String label) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: TextField(
//         obscureText: true,
//         decoration: InputDecoration(
//           labelText: label,
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14),
//             borderSide: BorderSide.none,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _updateButton() {
//     return SizedBox(
//       width: double.infinity,
//       height: 52,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: primaryColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//         ),
//         onPressed: () {},
//         child: const Text(
//           'Update Password',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
  
// }
import 'package:app_wearehouse_with_backend/presentation/user/bloc/change_password/change_password_bloc.dart';
import 'package:app_wearehouse_with_backend/presentation/user/bloc/change_password/change_password_event.dart';
import 'package:app_wearehouse_with_backend/presentation/user/bloc/change_password/change_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  static const primaryColor = Color(0xFF2FA4A9);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final currentPasswordC = TextEditingController();
  final newPasswordC = TextEditingController();
  final confirmPasswordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: ChangePasswordPage.primaryColor,
      ),
      body: BlocListener<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            Navigator.pop(context);
          }

          if (state is ChangePasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _field('Current Password', currentPasswordC),
              _field('New Password', newPasswordC),
              _field('Confirm New Password', confirmPasswordC),
              const SizedBox(height: 32),
              _button(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: c,
        obscureText: true,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _button(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ChangePasswordPage.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: () {
          context.read<ChangePasswordBloc>().add(
                SubmitChangePassword(
                  currentPassword: currentPasswordC.text,
                  newPassword: newPasswordC.text,
                  confirmPassword: confirmPasswordC.text,
                ),
              );
        },
        child: const Text(
          'Update Password',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
