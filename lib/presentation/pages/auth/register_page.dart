// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../bloc/register/register_bloc.dart';
// import '../../bloc/register/register_event.dart';
// import '../../bloc/register/register_state.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final _nameC = TextEditingController();
//   final _emailC = TextEditingController();
//   final _passwordC = TextEditingController();
//   bool _obscurePassword = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFFE0F7F5),
//               Color(0xFFB2DFDB),
//               Color(0xFF2EC4B6),
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(24),
//               child: BlocConsumer<RegisterBloc, RegisterState>(
//                 listener: (context, state) {
//                   state.whenOrNull(
//                     success: (user) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text(
//                             'Registrasi berhasil, ${user.name}',
//                           ),
//                         ),
//                       );
//                       Navigator.pop(context);
//                     },
//                     error: (msg) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text(msg)),
//                       );
//                     },
//                   );
//                 },
//                 builder: (context, state) {
//                   return Container(
//                     padding: const EdgeInsets.all(24),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(24),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.08),
//                           blurRadius: 20,
//                           offset: const Offset(0, 10),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Text(
//                           "Create Account",
//                           style: TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 24),

//                         _inputField("Name", Icons.person, _nameC),
//                         const SizedBox(height: 16),
//                         _inputField("Email", Icons.email, _emailC),
//                         const SizedBox(height: 16),
//                         _passwordField(),

//                         const SizedBox(height: 24),

//                         SizedBox(
//                           width: double.infinity,
//                           height: 52,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFF2EC4B6),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(16),
//                               ),
//                             ),
//                             onPressed: state.maybeWhen(
//                               loading: () => null,
//                               orElse: () {
//                                 context.read<RegisterBloc>().add(
//                                       RegisterEvent.submit(
//                                         name: _nameC.text,
//                                         email: _emailC.text,
//                                         password: _passwordC.text,
//                                         role: 'user',
//                                       ),
//                                     );
//                               },
//                             ),
//                             child: state.maybeWhen(
//                               loading: () => const SizedBox(
//                                 height: 24,
//                                 width: 24,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               orElse: () => const Text(
//                                 "Register",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _inputField(String hint, IconData icon, TextEditingController c) {
//     return TextField(
//       controller: c,
//       decoration: InputDecoration(
//         hintText: hint,
//         prefixIcon: Icon(icon),
//         filled: true,
//         fillColor: const Color(0xFFF6FDFC),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }

//   Widget _passwordField() {
//     return TextField(
//       controller: _passwordC,
//       obscureText: _obscurePassword,
//       decoration: InputDecoration(
//         hintText: "Password",
//         prefixIcon: const Icon(Icons.lock),
//         suffixIcon: IconButton(
//           icon: Icon(
//             _obscurePassword ? Icons.visibility_off : Icons.visibility,
//           ),
//           onPressed: () {
//             setState(() => _obscurePassword = !_obscurePassword);
//           },
//         ),
//         filled: true,
//         fillColor: const Color(0xFFF6FDFC),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }
// }
