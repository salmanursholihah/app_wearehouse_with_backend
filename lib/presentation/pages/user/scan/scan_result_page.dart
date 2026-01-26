import 'package:flutter/material.dart';
import '../../admin/product/ajust_page.dart';
import '../../admin/product/outbound_distributor_page.dart';
import '../../admin/product/outbound_job_page.dart';

class UserScanResultPage extends StatefulWidget {
  const UserScanResultPage({super.key});

  @override
  State<UserScanResultPage> createState() => _UserScanResultPageState();
}

class _UserScanResultPageState extends State<UserScanResultPage>
    with SingleTickerProviderStateMixin {
  final String productName = "Air Filter AF-128";
  final int stock = 25;

  bool get isLow => stock < 10;

  // ===== KONFIRMASI SEBELUM PINDAH =====
  void _confirmAction({required String title, required Widget page}) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.info_outline,
                size: 40,
                color: Color(0xFF2FA4A9),
              ),

              const SizedBox(height: 12),

              Text(
                "Lanjut ke $title?",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Batal"),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2FA4A9),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => page),
                        );
                      },
                      child: const Text("Lanjut"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),

      appBar: AppBar(
        title: const Text("Product Result"),
        backgroundColor: const Color(0xFF2FA4A9),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== PREVIEW FOTO (SIMULASI) =====
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.inventory_2,
                size: 90,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 16),

            // ===== CARD INFO =====
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // ===== BADGE STOCK =====
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isLow
                              ? Colors.red.withOpacity(0.1)
                              : Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          isLow ? "Low Stock" : "Available",
                          style: TextStyle(
                            fontSize: 12,
                            color: isLow ? Colors.red : Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  _rowInfo(Icons.category, "Category", "Sparepart"),

                  _rowInfo(Icons.storage, "Stock", "$stock pcs"),

                  _rowInfo(Icons.warehouse, "Warehouse", "WH-01"),
                ],
              ),
            ),

            const SizedBox(height: 24),

           
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _rowInfo(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF2FA4A9)),
          const SizedBox(width: 8),
          Text("$title : "),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }


}
