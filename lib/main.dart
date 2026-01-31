import 'package:app_wearehouse_with_backend/data/datasources/change_password_remote_datasource.dart';
import 'package:app_wearehouse_with_backend/injection.dart';
import 'package:app_wearehouse_with_backend/presentation/auth/bloc/register/register_bloc.dart';
import 'package:app_wearehouse_with_backend/presentation/user/bloc/change_password/change_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'data/datasources/auth_remote_datasource.dart';
import 'data/datasources/auth_local_datasource.dart';

import 'presentation/auth/bloc/login/login_bloc.dart';
import 'presentation/auth/bloc/logout/logout_bloc.dart';

import 'presentation/pages/auth/auth_check_page.dart';
import 'presentation/pages/auth/login_page.dart';
import 'presentation/pages/admin/admin_main_page.dart';
import 'presentation/pages/user/user_main_page.dart';
import 'injection.dart' as di;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final client = http.Client();
    final secureStorage = const FlutterSecureStorage();

    final remote = AuthRemoteDatasourceImpl(client);
    final local = AuthLocalDatasourceImpl(secureStorage);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc(remote, local)),
        BlocProvider(create: (_) => LogoutBloc(remote, local)),
        BlocProvider(create: (_) => RegisterBloc(remote, local)),
      BlocProvider(
          create: (_) => ChangePasswordBloc(
            sl<ChangePasswordRemoteDatasource>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Warehouse App',

        // auth check page
        home: const AuthCheckPage(),

        routes: {
          '/login': (_) => const LoginPage(),
          '/admin': (_) => const AdminMainPage(),
          '/user': (_) => const UserMainPage(),
        },
      ),
    );
  }
}
