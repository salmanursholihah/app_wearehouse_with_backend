import 'package:flutter/material.dart';
import 'scan_result_page.dart';

class UserScanPage extends StatefulWidget {
  const UserScanPage({super.key});

  @override
  State<UserScanPage> createState() => _UserScanPageState();
}

class _UserScanPageState extends State<UserScanPage>
    with SingleTickerProviderStateMixin {

  bool isScanning = false;

  Future<void> _simulateScan(BuildContext context) async {
    setState(() => isScanning = true);

    // simulasi proses deteksi 1.5 detik
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;

    setState(() => isScanning = false);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const UserScanResultPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),

      appBar: AppBar(
        title: const Text("Scan Product"),
        backgroundColor: const Color(0xFF2FA4A9),
      ),

      body: Stack(
        children: [

          // ===== BACKGROUND CAMERA PLACEHOLDER =====
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(20),
            ),

            child: Center(
              child: Icon(
                Icons.qr_code_scanner,
                size: 120,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),

          // ===== FRAME SCAN =====
          Center(
            child: Container(
              height: 240,
              width: 240,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          // ===== INFO TEXT =====
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Column(
              children: const [
                Text(
                  "Arahkan kamera ke produk",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 6),
                Text(
                  "Pastikan objek terlihat jelas",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // ===== LOADING OVERLAY =====
          if (isScanning)
            Container(
              color: Colors.black54,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Mendeteksi produk...",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),

      // ===== TOMBOL FOTO =====
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,

      floatingActionButton: SizedBox(
        width: 200,
        height: 50,

        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2FA4A9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),

          onPressed: isScanning
              ? null
              : () => _simulateScan(context),

          icon: const Icon(Icons.camera_alt),
          label: const Text("Take Photo"),
        ),
      ),
    );
  }
}
