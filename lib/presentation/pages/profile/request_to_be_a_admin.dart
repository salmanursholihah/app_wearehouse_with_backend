// presentation/user/pages/user_request_admin_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../user/bloc/request_to_admin/user_request_admin_bloc.dart';
import '../../user/bloc/request_to_admin/user_request_admin_event.dart';
import '../../user/bloc/request_to_admin/user_request_admin_state.dart';

class UserRequestAdminPage extends StatelessWidget {
  const UserRequestAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Admin'),
      ),
      body: BlocConsumer<UserRequestAdminBloc, UserRequestAdminState>(
        listener: (context, state) {
          if (state is UserRequestAdminSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.response.message),
              ),
            );
          }

          if (state is UserRequestAdminError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is UserRequestAdminLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.admin_panel_settings,
                  size: 80,
                  color: Colors.blue,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Ajukan Permintaan Menjadi Admin',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Permintaan akan ditinjau oleh Super Admin.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<UserRequestAdminBloc>()
                          .add(SubmitUserRequestAdmin());
                    },
                    child: const Text('Kirim Request'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
