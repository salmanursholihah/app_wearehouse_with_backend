// import 'package:flutter/material.dart';

// class LandingPage extends StatelessWidget {
//   const LandingPage({super.key});

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
//           child: Padding(
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               children: [
//                 const Spacer(),

//                 // ICON / ILLUSTRATION
//                 Container(
//                   height: 160,
//                   width: 160,
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.9),
//                     borderRadius: BorderRadius.circular(80),
//                   ),
//                   child: const Icon(
//                     Icons.warehouse_outlined,
//                     size: 90,
//                     color: Color(0xFF159A9C),
//                   ),
//                 ),

//                 const SizedBox(height: 32),

//                 const Text(
//                   "Warehouse Manager",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF263238),
//                   ),
//                 ),

//                 const SizedBox(height: 12),

//                 const Text(
//                   "Kelola stok, distribusi, dan\nmaintenance gudang dengan mudah",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.black54,
//                   ),
//                 ),

//                 const Spacer(),

//                 // BUTTON LOGIN
//                 SizedBox(
//                   width: double.infinity,
//                   height: 54,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(18),
//                       ),
//                       elevation: 8,
//                     ),
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/login');
//                     },
//                     child: const Text(
//                       "Get Started",
//                       style: TextStyle(
//                         color: Color(0xFF159A9C),
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 16),

//                 TextButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/login');
//                   },
//                   child: const Text(
//                     "Already have an account? Login",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 24),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';

// class LandingPage extends StatelessWidget {
//   const LandingPage({super.key});

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
//           child: Padding(
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               children: [
//                 const Spacer(),

//                 // ICON
//                 Container(
//                   height: 160,
//                   width: 160,
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.9),
//                     borderRadius: BorderRadius.circular(80),
//                   ),
//                   child: const Icon(
//                     Icons.warehouse_outlined,
//                     size: 90,
//                     color: Color(0xFF159A9C),
//                   ),
//                 ),

//                 const SizedBox(height: 32),

//                 const Text(
//                   "Warehouse Manager",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF263238),
//                   ),
//                 ),

//                 const SizedBox(height: 12),

//                 const Text(
//                   "Kelola stok, distribusi, dan\nmaintenance gudang dengan mudah",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.black54,
//                   ),
//                 ),

//                 const Spacer(),

//                 // BUTTON GET STARTED
//                 SizedBox(
//                   width: double.infinity,
//                   height: 54,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(18),
//                       ),
//                       elevation: 8,
//                     ),
//                     onPressed: () {
//                       Navigator.pushReplacementNamed(context, '/login');
//                     },
//                     child: const Text(
//                       "Get Started",
//                       style: TextStyle(
//                         color: Color(0xFF159A9C),
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 16),

//                 TextButton(
//                   onPressed: () {
//                     Navigator.pushReplacementNamed(context, '/login');
//                   },
//                   child: const Text(
//                     "Already have an account? Login",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 24),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : null, // JIKA TIDAK ADA HISTORY, BACK TIDAK DITAMPILKAN
      ),
      extendBodyBehindAppBar: true,
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
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Spacer(),

                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: const Icon(
                    Icons.warehouse_outlined,
                    size: 90,
                    color: Color(0xFF159A9C),
                  ),
                ),

                const SizedBox(height: 32),

                const Text(
                  "Warehouse Manager",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF263238),
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  "Kelola stok, distribusi, dan\nmaintenance gudang dengan mudah",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 8,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      "Get Started",
                      style: TextStyle(
                        color: Color(0xFF159A9C),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text(
                    "Already have an account? Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
