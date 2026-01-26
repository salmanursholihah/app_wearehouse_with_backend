import 'package:flutter/material.dart';
import '../ajust_page.dart';
import '../outbound_distributor_page.dart';
import '../outbound_job_page.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {

    // SIMULASI DATA PRODUK
    final String productName = "Air Filter AF-128";

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),

      appBar: AppBar(
        title: const Text('Product Detail'),
        backgroundColor: const Color(0xFF2FA4A9),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            _infoCard(productName),

            const SizedBox(height: 24),

            _actionButton(
              context,
              icon: Icons.edit,
              title: 'Adjust Product',
              page: AdjustStockPage(
                productName: productName,
              ),
            ),

            _actionButton(
              context,
              icon: Icons.local_shipping,
              title: 'Outbound to Distributor',
              page: DistributeFormPage(
                productName: productName,
              ),
            ),

            _actionButton(
              context,
              icon: Icons.build,
              title: 'Outbound to Job / Maintenance',
              page: JobFormPage(
                productName: productName,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String productName) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text('Category: Engine Part'),
          const Text('Stock: 25 Items'),
          const Text('Warehouse: WH-A01'),
        ],
      ),
    );
  }

  Widget _actionButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget page,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),

      child: SizedBox(
        width: double.infinity,
        height: 52,

        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2FA4A9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),

          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => page),
            );
          },

          icon: Icon(icon),
          label: Text(title),
        ),
      ),
    );
  }
}
