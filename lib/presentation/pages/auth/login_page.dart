import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/bloc/login/login_bloc.dart';
import '../../pages/auth/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE0F7F5),
              Color(0xFFB2DFDB),
              Color(0xFF2EC4B6),
            ],
          ),
        ),
        child: SafeArea(
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              state.whenOrNull(
                success: (data) {
                  final role = data.user.role;

                  if (role == 'super_admin') {
                    Navigator.pushReplacementNamed(context, '/super-admin');
                  } else if (role == 'admin') {
                    Navigator.pushReplacementNamed(context, '/admin');
                  } else {
                    Navigator.pushReplacementNamed(context, '/user');
                  }
                },
                error: (msg) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(msg),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                },
              );
            },
            builder: (context, state) {
              final isLoading = state.maybeWhen(
                loading: () => true,
                orElse: () => false,
              );

              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// ICON
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0F7F5),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(
                            Icons.lock_outline,
                            size: 48,
                            color: Color(0xFF159A9C),
                          ),
                        ),

                        const SizedBox(height: 24),

                        const Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),
                        const Text(
                          'Login to manage your warehouse',
                          style: TextStyle(color: Colors.grey),
                        ),

                        const SizedBox(height: 24),

                        /// EMAIL
                        TextField(
                          controller: emailC,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon:
                                const Icon(Icons.email_outlined),
                            filled: true,
                            fillColor: const Color(0xFFF6FDFC),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// PASSWORD
                        TextField(
                          controller: passwordC,
                          obscureText: _obscure,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon:
                                const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscure = !_obscure;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF6FDFC),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        /// LOGIN BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF2EC4B6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 6,
                            ),
                            onPressed: isLoading
                                ? null
                                : () {
                                    context.read<LoginBloc>().add(
                                          LoginEvent.login(
                                            emailC.text.trim(),
                                            passwordC.text.trim(),
                                          ),
                                        );
                                  },
                            child: isLoading
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),

                   Column(
  children: [
    const Text(
      'You do not have an account?',
      style: TextStyle(color: Colors.grey),
      textAlign: TextAlign.center,
    ),
    const SizedBox(height: 8),
    GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const RegisterPage(),
          ),
        );
      },
      child: const Text(
        'Register here',
        style: TextStyle(
          color: Color(0xFF2EC4B6),
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    const SizedBox(height: 24),
  ],
),


                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
