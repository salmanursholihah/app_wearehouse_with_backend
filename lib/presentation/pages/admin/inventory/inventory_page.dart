import 'package:flutter/material.dart';
import '../../shared/inventory/inventory_detail_page.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  static const primaryColor = Color(0xFF2FA4A9);

  String selectedCategory = "All";

  final categories = [
    "All",
    "Sparepart",
    "Electrical",
    "Barang Hampir Habis",
    "Barang Habis",
    "Stok Aman",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text('Inventory'),
        backgroundColor: primaryColor,
      ),

      body: Column(
        children: [
          // ===== SEARCH BAR =====
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search item...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // ===== CATEGORY FILTER =====
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: categories.map((cat) {
                final isActive = selectedCategory == cat;

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isActive,
                    selectedColor: primaryColor,
                    labelStyle: TextStyle(
                      color: isActive ? Colors.white : Colors.black,
                    ),
                    onSelected: (_) {
                      setState(() {
                        selectedCategory = cat;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 12),

          // ===== INVENTORY LIST =====
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 8,
              itemBuilder: (context, i) {
                final stock = i % 3 == 0 ? 3 : 25; // dummy stock
                final category = i % 2 == 0 ? "Sparepart" : "Electrical";

                // ===== LOGIC STATUS =====
                String status = "Stok Aman";

                if (stock == 0) {
                  status = "Barang Habis";
                } else if (stock < 5) {
                  status = "Barang Hampir Habis";
                }

                // ===== FILTER LOGIC =====
                if (selectedCategory != "All") {
                  if (selectedCategory != category &&
                      selectedCategory != status) {
                    return const SizedBox();
                  }
                }

                final isLowStock = stock <= 5;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => InventoryDetailPage(
                          name: 'Air Filter #AF-12$i',
                        ),
                      ),
                    );
                  },

                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),

                    child: Row(
                      children: [
                        // ===== ICON =====
                        CircleAvatar(
                          radius: 24,
                          backgroundColor:
                              primaryColor.withOpacity(0.15),
                          child: const Icon(
                            Icons.inventory_2,
                            color: primaryColor,
                          ),
                        ),

                        const SizedBox(width: 12),

                        // ===== INFO =====
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Air Filter #AF-12$i',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                'Category: $category',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ===== STOCK =====
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '$stock pcs',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isLowStock
                                    ? Colors.red
                                    : Colors.green,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: isLowStock
                                    ? Colors.red.withOpacity(0.1)
                                    : Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                status,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isLowStock
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
