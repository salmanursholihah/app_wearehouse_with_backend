import 'package:app_wearehouse_with_backend/presentation/pages/admin/dashboard/admin_dashboard_page.dart';
import 'package:app_wearehouse_with_backend/presentation/pages/user/dashboard/user_dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

// DATASOURCE
import 'data/datasources/auth_remote_datasource.dart';

// BLOC
import '../../../presentation/auth/bloc/login_bloc.dart';
// PAGES
import '../../../presentation/pages/auth/login_page.dart';
import '../../../presentation/pages/auth/register_page.dart';
import '../../../presentation/pages/admin/admin_main_page.dart';
import '../../../presentation/pages/user/user_main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /// LOGIN BLOC
        BlocProvider<LoginBloc>(
          create: (_) => LoginBloc(
            AuthRemoteDatasourceImpl(http.Client()),
          ),
        ),

        /// nanti bloc lain (register, logout, profile, dll)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Warehouse App',

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),

        /// ⬇️ ROUTING RESMI
        initialRoute: '/login',
        routes: {
          '/login': (_) => const LoginPage(),
          // '/register': (_) => const RegisterPage(),
          '/admin': (_) => const AdminDashboardPage(),
          '/user': (_) => const UserDashboardPage(),
        },
      ),
    );
  }
}


